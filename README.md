# Polypack MCP for YunoHost

YunoHost packaging for [polypack-mcp](https://github.com/imattau/polypack-mcp),
a persistent adaptive-memory MCP service.

This package is intentionally local-only. It binds to `127.0.0.1` and does not
create a domain, Nginx route, SSO permission, or public endpoint. It is intended
for MCP clients running on the YunoHost server and for the future YunoHost MCP
integration, where authenticated remote agents reach Polypack through the
YunoHost MCP service.

The durable store is kept in the YunoHost-managed data directory and is backed
up with the application. The package does not enable the optional Qwen embedding
helper; that feature needs a YunoHost-native service design before inclusion.

## Local endpoint

The default endpoint is:

```text
http://127.0.0.1:8765/mcp/
```

The actual port is allocated by YunoHost and is printed after installation.
