# GitHub MCP Server on Smithery (Public Mode)

This repo containerizes [github-mcp-server](https://github.com/github/github-mcp-server) 
and exposes it via [mcp-proxy](https://pypi.org/project/mcp-proxy/) as a 
remote Streamable HTTP/SSE server.

## Public Mode
If no `GITHUB_PERSONAL_ACCESS_TOKEN` is set, the server runs in **anonymous mode**:
- Works with public repos and data only.
- Subject to GitHub's stricter unauthenticated rate limits (60 requests/hour per IP).

## Optional Environment Variables
- `GITHUB_PERSONAL_ACCESS_TOKEN` (optional, for authenticated higher-rate access)
- `GITHUB_READ_ONLY=1` (optional, safe default)
- `GITHUB_TOOLSETS="repos,issues,pull_requests,actions,code_security"` (optional)
- `GITHUB_DYNAMIC_TOOLSETS=1` (optional)
- `GITHUB_HOST="https://<your-ghes>"` (optional, for GitHub Enterprise)

## Port
Exposes Streamable HTTP/SSE on port `8080`.
