# --- build the GitHub MCP server (Go) ---
FROM golang:1.22 AS build
WORKDIR /src
RUN git clone https://github.com/github/github-mcp-server . \
 && go build -o /out/github-mcp-server ./cmd/github-mcp-server

# --- minimal runtime with mcp-proxy exposing Streamable HTTP/SSE ---
FROM python:3.12-slim
WORKDIR /app

# Install proxy (wraps stdio into Streamable HTTP/SSE)
RUN pip install --no-cache-dir mcp-proxy

# Add server binary
COPY --from=build /out/github-mcp-server /usr/local/bin/github-mcp-server

# Expose the port
EXPOSE 8080

# Healthcheck (ping proxy root)
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD python - <<'PY' || exit 1
import urllib.request; urllib.request.urlopen("http://127.0.0.1:8080").read()
PY

# Run: proxy on :8080 wrapping the stdio server
ENTRYPOINT ["mcp-proxy","--host","0.0.0.0","--port","8080","--","/usr/local/bin/github-mcp-server","stdio"]
