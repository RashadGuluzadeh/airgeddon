#!/usr/bin/env bash

#Global shellcheck disabled warnings
#shellcheck disable=SC2034,SC2154,SC2148

###### GENERIC PLUGIN VARS ######

plugin_name="Session logger"
plugin_description="On exit, saves the session capture and scan files into a folder named after the attacked network (ESSID)"
plugin_author="RashadGuluzadeh"

plugin_enabled=1

plugin_minimum_ag_affected_version="10.0"
plugin_maximum_ag_affected_version=""
plugin_distros_supported=("*")

###### PREHOOK: before exit cleanup, archive the session files under the target ESSID ######

function session_logger_prehook_exit_script_option() {

	debug_print

	#Nothing to log if no target network was selected
	if [ -z "${essid}" ]; then
		return 0
	fi

	#Only log if there are capture/scan files worth saving in the working dir
	if ! ls "${tmpdir}"*.cap "${tmpdir}"*.csv > /dev/null 2>&1; then
		return 0
	fi

	#Pick the invoking user's home when run through sudo, otherwise HOME
	local base
	if [ -n "${SUDO_USER}" ] && [ "${SUDO_USER}" != "root" ]; then
		base="/home/${SUDO_USER}"
	else
		base="${HOME}"
	fi

	#Sanitize the ESSID for use as a folder name
	local safe_essid
	safe_essid=$(echo "${essid}" | tr -c 'A-Za-z0-9._-' '_')
	[ -z "${safe_essid}" ] && safe_essid="hidden"

	local logdir="${base}/airgeddon-logs/${safe_essid}/session_$(date +%Y%m%d_%H%M%S)"
	mkdir -p "${logdir}" 2> /dev/null

	#Copy the useful session artifacts
	cp "${tmpdir}"*.cap "${logdir}/" 2> /dev/null
	cp "${tmpdir}"*.csv "${logdir}/" 2> /dev/null
	cp "${tmpdir}"*key* "${logdir}/" 2> /dev/null
	cp "${tmpdir}"*pass* "${logdir}/" 2> /dev/null

	#Make the logs owned by the invoking user, not root
	if [ -n "${SUDO_USER}" ] && [ "${SUDO_USER}" != "root" ]; then
		chown -R "${SUDO_USER}:${SUDO_USER}" "${base}/airgeddon-logs" 2> /dev/null
	fi

	echo
	echo -e "${green_color:-}${pround:-}Session files saved to: ${logdir}${normal_color:-}"
}
