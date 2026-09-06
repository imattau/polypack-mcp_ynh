#!/bin/bash

#=================================================
# PACKAGE-SPECIFIC HELPERS
#=================================================

polypack_mcp_install_venv() {
	python3 -m venv "$install_dir/venv"
	ynh_hide_warnings "$install_dir/venv/bin/pip" install --upgrade pip
	ynh_hide_warnings "$install_dir/venv/bin/pip" install "$install_dir[polypack]"
	chown -R "$app:$app" "$install_dir"
}

polypack_mcp_prepare_data_dir() {
	mkdir -p "$data_dir"
	chown -R "$app:$app" "$data_dir"
	chmod 0750 "$data_dir"
}

polypack_mcp_remove_upstream_runtime_artifacts() {
	# The upstream development repository contains a local polypack-data
	# directory. Runtime data belongs in YunoHost's data_dir instead.
	if [ -d "$install_dir/polypack-data" ]; then
		ynh_safe_rm "$install_dir/polypack-data"
	fi
}
