#!/usr/bin/env bash

#Global shellcheck disabled warnings
#shellcheck disable=SC2034,SC2154,SC2148

###### GENERIC PLUGIN VARS ######

plugin_name="Monitor mode conflict fix"
plugin_description="Tells NetworkManager to stop managing an interface before it is switched to monitor mode, so it is not grabbed back"
plugin_author="RashadGuluzadeh"

plugin_enabled=1

plugin_minimum_ag_affected_version="10.0"
plugin_maximum_ag_affected_version=""
plugin_distros_supported=("*")

###### PREHOOK: release the interface from NetworkManager before monitor mode ######

function monitor_fix_prehook_monitor_option() {

	debug_print

	local iface="${1}"
	if [ -z "${iface}" ]; then
		return 0
	fi

	#If NetworkManager is present, mark the interface as unmanaged so it does not
	#flip it back to managed mode right after airgeddon sets monitor mode
	if command -v nmcli > /dev/null 2>&1; then
		nmcli dev set "${iface}" managed no > /dev/null 2>&1
	fi
}
