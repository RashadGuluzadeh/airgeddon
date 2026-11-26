#!/usr/bin/env bash

#Global shellcheck disabled warnings
#shellcheck disable=SC2034,SC2154,SC2148

###### GENERIC PLUGIN VARS ######

plugin_name="Auto monitor mode"
plugin_description="Automatically switches the selected main interface to monitor mode right after it is selected"
plugin_author="RashadGuluzadeh"

plugin_enabled=1

plugin_minimum_ag_affected_version="10.0"
plugin_maximum_ag_affected_version=""
plugin_distros_supported=("*")

###### POSTHOOK: after selecting the main interface, enable monitor mode ######

function auto_monitor_posthook_select_interface() {

	debug_print

	#Act only if an interface was actually selected
	if [ -z "${interface}" ]; then
		return 0
	fi

	#Read the real current mode of the interface
	local current_mode
	current_mode=$(iw dev "${interface}" info 2> /dev/null | grep -oE "type [a-z]+" | awk '{print $2}')

	#If it is a wifi interface and not already in monitor mode, switch it
	if [ -n "${current_mode}" ] && [ "${current_mode}" != "monitor" ]; then
		monitor_option "${interface}"
	fi
}
