Polypack MCP is a local persistent-memory service for MCP clients and the
YunoHost MCP administration server.

It stores durable project, agent, and operational memories in a local Polypack
graph and exposes them through the Model Context Protocol. This YunoHost package
keeps the service on loopback only: it has no browser interface, public domain,
Nginx route, or YunoHost SSO permission.

Remote agents should continue to connect to the authenticated YunoHost MCP
endpoint. A future YunoHost MCP integration can use this local service as its
memory backend without exposing Polypack directly to the network.
