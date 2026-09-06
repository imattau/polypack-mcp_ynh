# Polypack MCP for YunoHost

YunoHost packaging for [polypack-mcp](https://github.com/imattau/polypack-mcp),
a persistent adaptive-memory MCP service.

This package is intentionally local-only. It binds to `127.0.0.1` and does not
create a domain, Nginx route, SSO permission, or public endpoint. It is intended
for MCP clients running on the YunoHost server and for the future YunoHost MCP
integration, where authenticated remote agents reach Polypack through the
YunoHost MCP service.

The durable store is kept in the YunoHost-managed data directory and is backed
up with the application. The package includes an optional configuration panel
for managed Hugging Face embedding models. It downloads models into the
app-owned cache, supports an optional HF API token, accepts a custom Hugging
Face repository, and controls a conservative database disk-usage cleanup
limit; the embedding cache is excluded from that limit.

## Local endpoint

The default endpoint is:

```text
http://127.0.0.1:8765/mcp/
```

The actual port is allocated by YunoHost and is printed after installation.

Open the app's YunoHost configuration panel to choose and install semantic
retrieval, inspect the helper/cache status, or set the database cleanup limit.
