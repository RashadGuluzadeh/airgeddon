#!/usr/bin/env bash

#Global shellcheck disabled warnings
#shellcheck disable=SC2034,SC2154,SC2148

###### GENERIC PLUGIN VARS ######

plugin_name="Sort explored targets by signal"
plugin_description="Sorts the explored target network list by signal strength, strongest first, before it is shown"
plugin_author="RashadGuluzadeh"

plugin_enabled=1

plugin_minimum_ag_affected_version="10.0"
plugin_maximum_ag_affected_version=""
plugin_distros_supported=("*")

###### PREHOOK: reorder the target list strongest-signal first ######

function sort_targets_prehook_select_target() {

	debug_print

	#Re-sort the parsed network list (field 3 = power %) descending, strongest on top
	if [ -f "${tmpdir}wnws.txt" ]; then
		sort -t "," -rn -k 3 "${tmpdir}wnws.txt" -o "${tmpdir}wnws.txt"
	fi
}
