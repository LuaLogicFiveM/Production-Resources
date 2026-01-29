const http = require("http");
const url = require("url");

const PORT = GetConvar("stats_http_port", "3737");
const HOST = GetConvar("stats_http_host", "0.0.0.0");

const CORS_HEADERS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type, Authorization",
  "Content-Type": "application/json",
};

// Parse query parameters
function parseQueryParams(queryString) {
  const params = {};
  if (queryString) {
    queryString.split("&").forEach((pair) => {
      const [key, value] = pair.split("=");
      if (key && value) {
        params[decodeURIComponent(key)] = decodeURIComponent(value);
      }
    });
  }
  return params;
}

// Create HTTP server
const server = http.createServer(async (req, res) => {
  const parsedUrl = url.parse(req.url);
  const cleanPath = parsedUrl.pathname;
  const query = parseQueryParams(parsedUrl.query);

  // Set CORS headers
  Object.entries(CORS_HEADERS).forEach(([key, value]) => {
    res.setHeader(key, value);
  });

  if (req.method !== "GET") {
    res.writeHead(200);
    res.end();
    return;
  }

  try {
    const result = await exports[
      "tgiann-fivem-stats-script"
    ].CallInternalEndpoint(req.method, cleanPath, query);

    if (result && result.success !== false) {
      res.writeHead(200);
      res.end(JSON.stringify(result));
    } else {
      res.writeHead(result && result.error ? 400 : 404);
      res.end(
        JSON.stringify(
          result || {
            success: false,
            error: "Endpoint not found",
          }
        )
      );
    }
  } catch (error) {
    console.error("^1[HTTP Server] Error:^7", error);
    res.writeHead(500);
    res.end(
      JSON.stringify({
        success: false,
        error: "Internal server error",
        message: error.message,
      })
    );
  }
});

// Start server
server.listen(parseInt(PORT), HOST);

on("onResourceStop", (resourceName) => {
  if (GetCurrentResourceName() === resourceName) server.close();
});
