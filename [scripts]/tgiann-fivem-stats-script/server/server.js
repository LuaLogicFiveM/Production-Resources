const mysqldump = require("mysqldump");
const http = require("http");
const url = require("url");
const path = require("path");
const fs = require("fs");

const secretKey = GetConvar("tgiann_stats_secret_key", "not-added");

const PORT = GetConvar("tgiann_stats_http_port", "3737");
const HOST = GetConvar("tgiann_stats_http_host", "0.0.0.0");

const mysql_connection_string = GetConvar("mysql_connection_string", "");
const BACKUP_DIR = GetResourcePath(GetCurrentResourceName()) + "/backups";
const SETTINGS_FILE = path.join(BACKUP_DIR, "settings.json");

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

const checkAuth = (key) => {
  if (secretKey == "not-added") {
    return {
      success: false,
      error:
        'Secret key not added in server.cfg, Please add set tgiann_stats_secret_key "your-secret-key-here" to your server cfg file and change the key.',
    };
  } else if (secretKey !== key) {
    return {
      success: false,
      error: "Unauthorized: Invalid or missing API key",
    };
  }

  return { success: true };
};

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

  const authResult = checkAuth(query.key);
  if (!authResult.success) {
    res.writeHead(401);
    res.end(JSON.stringify(authResult));
    return;
  }

  // Handle backup routes
  if (cleanPath.startsWith("/backup/")) {
    try {
      const handled = await handleBackupRoute(
        cleanPath,
        query,
        res,
        CORS_HEADERS,
      );
      if (handled) return;
    } catch (error) {
      console.error("^1[HTTP Server] Backup error:^7", error);
      res.writeHead(500);
      res.end(
        JSON.stringify({ success: false, error: "Internal server error" }),
      );
      return;
    }
  }

  try {
    const result = await exports[
      "tgiann-fivem-stats-script"
    ].CallInternalEndpoint(req.method, cleanPath, query);

    if (result && result.success !== false) {
      res.writeHead(200);
      res.end(JSON.stringify(result));
    } else {
      const statusCode =
        !result || result.error === "Endpoint not found" ? 404 : 400;

      res.writeHead(statusCode);
      res.end(
        JSON.stringify(
          result || {
            success: false,
            error: "Endpoint not found",
          },
        ),
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
      }),
    );
  }
});

// Start server
server.listen(parseInt(PORT), HOST);

// Auto-backup functionality

const DEFAULT_SETTINGS = {
  enabled: false,
  intervalHours: 4,
  maxBackups: 28,
  lastBackupTime: 0,
};

// Ensure backup directory exists
if (!fs.existsSync(BACKUP_DIR)) {
  fs.mkdirSync(BACKUP_DIR, { recursive: true });
}

function readSettings() {
  try {
    if (!fs.existsSync(SETTINGS_FILE)) return { ...DEFAULT_SETTINGS };
    const content = fs.readFileSync(SETTINGS_FILE, "utf-8");
    const settings = JSON.parse(content);
    return { ...DEFAULT_SETTINGS, ...settings };
  } catch {
    return { ...DEFAULT_SETTINGS };
  }
}

function writeSettings(settings) {
  try {
    fs.writeFileSync(SETTINGS_FILE, JSON.stringify(settings, null, 2), "utf-8");
    return true;
  } catch {
    return false;
  }
}

// https://github.com/CommunityOx/oxmysql/blob/main/src/config.ts#L43-L115
function parseUri(connectionString) {
  const splitMatchGroups = connectionString.match(
    new RegExp(
      "^(?:([^:/?#.]+):)?(?://(?:([^/?#]*)@)?([\\w\\d\\-\\u0100-\\uffff.%]*)(?::([0-9]+))?)?([^?#]+)?(?:\\?([^#]*))?$",
    ),
  );

  if (!splitMatchGroups)
    throw new Error(
      `mysql_connection_string structure was invalid (${connectionString})`,
    );

  const authTarget = splitMatchGroups[2] ? splitMatchGroups[2].split(":") : [];

  const options = {
    user: authTarget[0] || undefined,
    password: authTarget[1] || undefined,
    host: splitMatchGroups[3],
    port: parseInt(splitMatchGroups[4]),
    database: splitMatchGroups[5]?.replace(/^\/+/, ""),
    ...(splitMatchGroups[6] &&
      splitMatchGroups[6].split("&").reduce((connectionInfo, parameter) => {
        const [key, value] = parameter.split("=");
        connectionInfo[key] = value;
        return connectionInfo;
      }, {})),
  };

  return options;
}

function parseMysqlConnection() {
  if (!mysql_connection_string) return null;

  const options = mysql_connection_string.includes("mysql://")
    ? parseUri(mysql_connection_string)
    : mysql_connection_string
        .replace(
          /(?:host(?:name)|ip|server|data\s?source|addr(?:ess)?)=/gi,
          "host=",
        )
        .replace(/(?:user\s?(?:id|name)?|uid)=/gi, "user=")
        .replace(/(?:pwd|pass)=/gi, "password=")
        .replace(/(?:db)=/gi, "database=")
        .split(";")
        .reduce((connectionInfo, parameter) => {
          const [key, value] = parameter.split("=");
          if (key) connectionInfo[key] = value;
          return connectionInfo;
        }, {});

  if (!options.database) return null;

  return options;
}

async function createBackup() {
  const options = parseMysqlConnection();
  if (!options) {
    return { success: false, error: "Could not parse mysql_connection_string" };
  }

  const timestamp = new Date()
    .toISOString()
    .replace(/[T]/g, "_")
    .replace(/[:.]/g, "-")
    .slice(0, 19);

  const filename = `backup-${timestamp}.sql`;
  const filePath = path.join(BACKUP_DIR, filename);

  try {
    await mysqldump({
      connection: {
        host: options.host || "localhost",
        // port: options.port ? parseInt(options.port) : 3306,
        user: options.user || "root",
        password: options.password || "",
        database: options.database.toLowerCase(),
      },
      dumpToFile: filePath,
    });

    const stat = fs.statSync(filePath);
    if (stat.size === 0) {
      fs.unlinkSync(filePath);
      return { success: false, error: "Backup file is empty" };
    }

    return { success: true, filename };
  } catch (err) {
    try {
      fs.unlinkSync(filePath);
    } catch {}
    return { success: false, error: err.message || "Backup failed" };
  }
}

function cleanOldBackups(maxBackups) {
  try {
    const files = fs
      .readdirSync(BACKUP_DIR)
      .filter((f) => f.endsWith(".sql"))
      .map((f) => ({
        name: f,
        time: fs.statSync(path.join(BACKUP_DIR, f)).mtimeMs,
      }))
      .sort((a, b) => b.time - a.time);

    for (let i = maxBackups; i < files.length; i++) {
      fs.unlinkSync(path.join(BACKUP_DIR, files[i].name));
    }
  } catch {}
}

function listBackups() {
  try {
    return fs
      .readdirSync(BACKUP_DIR)
      .filter((f) => f.endsWith(".sql"))
      .map((f) => {
        const stat = fs.statSync(path.join(BACKUP_DIR, f));
        const dateMatch = f.match(/(\d{4}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2})/);
        return {
          filename: f,
          size: stat.size,
          createdAt: dateMatch ? dateMatch[1] : "",
        };
      })
      .sort((a, b) => (b.createdAt > a.createdAt ? 1 : -1));
  } catch {
    return [];
  }
}

// Auto backup
let autoBackupInterval = null;

function startAutoBackupCheck() {
  if (autoBackupInterval) clearInterval(autoBackupInterval);

  autoBackupInterval = setInterval(
    async () => {
      const settings = readSettings();
      if (!settings.enabled) return;

      const now = Math.floor(Date.now() / 1000);
      const intervalSeconds = settings.intervalHours * 3600;
      const elapsed = now - (settings.lastBackupTime || 0);

      if (elapsed >= intervalSeconds) {
        const result = await createBackup();
        if (result.success) {
          settings.lastBackupTime = now;
          writeSettings(settings);
          cleanOldBackups(settings.maxBackups);
        }
      }
    },
    5 * 60 * 1000,
  );
}

function stopAutoBackup() {
  if (autoBackupInterval) {
    clearInterval(autoBackupInterval);
    autoBackupInterval = null;
  }
}

startAutoBackupCheck();

// Handle backup API routes - returns true if handled
async function handleBackupRoute(cleanPath, query, res, CORS_HEADERS) {
  if (cleanPath === "/backup/settings") {
    const settings = readSettings();
    res.writeHead(200);
    res.end(JSON.stringify({ success: true, data: settings }));
    return true;
  }

  if (cleanPath === "/backup/settings/update") {
    const settings = readSettings();

    if (query.enabled !== undefined) {
      settings.enabled = query.enabled === "true";
    }

    if (query.intervalHours) {
      const hours = parseInt(query.intervalHours);
      if (hours >= 1) settings.intervalHours = hours;
    }

    if (query.maxBackups) {
      const max = parseInt(query.maxBackups);
      if (max >= 1) settings.maxBackups = max;
    }

    if (!writeSettings(settings)) {
      res.writeHead(500);
      res.end(
        JSON.stringify({ success: false, error: "Failed to save settings" }),
      );
      return true;
    }

    res.writeHead(200);
    res.end(JSON.stringify({ success: true, data: settings }));
    return true;
  }

  if (cleanPath === "/backup/list") {
    const files = listBackups();
    res.writeHead(200);
    res.end(JSON.stringify({ success: true, data: files }));
    return true;
  }

  if (cleanPath === "/backup/create") {
    const result = await createBackup();
    if (!result.success) {
      res.writeHead(500);
      res.end(JSON.stringify({ success: false, error: result.error }));
      return true;
    }

    const settings = readSettings();
    settings.lastBackupTime = Math.floor(Date.now() / 1000);
    writeSettings(settings);
    cleanOldBackups(settings.maxBackups);

    res.writeHead(200);
    res.end(
      JSON.stringify({ success: true, data: { filename: result.filename } }),
    );
    return true;
  }

  if (cleanPath === "/backup/delete") {
    const filename = query.filename;
    if (!filename) {
      res.writeHead(400);
      res.end(
        JSON.stringify({ success: false, error: "Filename is required" }),
      );
      return true;
    }

    const safeName = path.basename(filename);
    if (
      safeName !== filename ||
      !safeName.endsWith(".sql") ||
      safeName.includes("..")
    ) {
      res.writeHead(400);
      res.end(JSON.stringify({ success: false, error: "Invalid filename" }));
      return true;
    }

    const filePath = path.join(BACKUP_DIR, safeName);
    if (!fs.existsSync(filePath)) {
      res.writeHead(404);
      res.end(JSON.stringify({ success: false, error: "File not found" }));
      return true;
    }

    fs.unlinkSync(filePath);
    res.writeHead(200);
    res.end(JSON.stringify({ success: true, data: { deleted: safeName } }));
    return true;
  }

  if (cleanPath === "/backup/download") {
    const filename = query.filename;
    if (!filename) {
      res.writeHead(400, CORS_HEADERS);
      res.end(
        JSON.stringify({ success: false, error: "Filename is required" }),
      );
      return true;
    }

    const safeName = path.basename(filename);
    if (safeName !== filename || !safeName.endsWith(".sql")) {
      res.writeHead(400, CORS_HEADERS);
      res.end(JSON.stringify({ success: false, error: "Invalid filename" }));
      return true;
    }

    const filePath = path.join(BACKUP_DIR, safeName);
    if (!fs.existsSync(filePath)) {
      res.writeHead(404, CORS_HEADERS);
      res.end(JSON.stringify({ success: false, error: "File not found" }));
      return true;
    }

    const stat = fs.statSync(filePath);
    res.writeHead(200, {
      "Content-Type": "application/sql",
      "Content-Length": stat.size,
      "Content-Disposition": `attachment; filename="${safeName}"`,
      "Access-Control-Allow-Origin": "*",
    });

    const readStream = fs.createReadStream(filePath);
    readStream.pipe(res);
    return true;
  }

  return false;
}

// Clean up on resource stop and check for secret key

on("onResourceStop", (resourceName) => {
  if (GetCurrentResourceName() !== resourceName) return;

  stopAutoBackup();
  server.close();
});

if (secretKey === "not-added") {
  const errorFunc = () => {
    console.log(
      '^0Secret key not added in server.cfg, Please add ^3set tgiann_stats_secret_key "your-secret-key-here"^0 to your server.cfg file and change the key.',
    );
    SetTimeout(errorFunc, 4000);
  };

  errorFunc();
}
