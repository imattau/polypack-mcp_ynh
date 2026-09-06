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

polypack_mcp_runtime_env_file() {
	echo "$data_dir/polypack.env"
}

polypack_mcp_embedding_env_file() {
	echo "$data_dir/.embedding/embedding.env"
}

polypack_mcp_write_runtime_env() {
	local limit_bytes="${1:-0}"
	mkdir -p "$data_dir"
	printf 'POLYPACK_MCP_STORAGE_LIMIT_BYTES=%s\n' "$limit_bytes" >"$(polypack_mcp_runtime_env_file)"
	chown "$app:$app" "$(polypack_mcp_runtime_env_file)"
	chmod 0640 "$(polypack_mcp_runtime_env_file)"
}

polypack_mcp_write_embedding_custom_url() {
	local custom_url="${1:-}"
	local env_file
	env_file="$(polypack_mcp_embedding_env_file)"
	[ -f "$env_file" ] || return 0
	# The custom URL is UI metadata; model loading uses the normalized model id
	# written by the upstream embedding command. Keep it in the same protected
	# environment file so config-panel reloads can restore the selection.
	grep -v '^POLYPACK_MCP_EMBEDDING_CUSTOM_URL=' "$env_file" >"$env_file.tmp" || true
	if [ -n "$custom_url" ]; then
		printf 'POLYPACK_MCP_EMBEDDING_CUSTOM_URL=%s\n' "$custom_url" >>"$env_file.tmp"
	fi
	mv "$env_file.tmp" "$env_file"
	chown "$app:$app" "$env_file"
	chmod 0600 "$env_file"
}

polypack_mcp_remove_upstream_runtime_artifacts() {
	# The upstream development repository contains a local polypack-data
	# directory. Runtime data belongs in YunoHost's data_dir instead.
	if [ -d "$install_dir/polypack-data" ]; then
		ynh_safe_rm "$install_dir/polypack-data"
	fi
}
