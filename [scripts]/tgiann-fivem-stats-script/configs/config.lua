tgiCoreExports      = exports["tgiann-core"]
config              = tgiCoreExports:getConfig()

-- Database Tables
config.tables       = {
    playerPositions = "tgiann_stats_player_hourly_positions",
    serverOnline = "tgiann_stats_server_hourly_online",
    killLogs = "tgiann_stats_kill_logs",
    moneyLogs = "tgiann_stats_money_logs",
    playerSessions = "tgiann_stats_player_sessions",
    playerDisconnects = "tgiann_stats_player_disconnects",
    chatLogs = "tgiann_stats_chat_logs",
    playerIdentifiers = "tgiann_stats_player_identifiers",
    playerIdentifierMapping = "tgiann_stats_player_identifier_mapping",
}

-- Cron Jobs (https://crontab.guru)
config.cron         = {
    saveOnlineCount = "0 */1 * * *",            -- Every hour
    savePlayerPositions = "0 */1 * * *",        -- Every hour
    collectItems = "0 */1 * * *",               -- Every hour
    updatePlayerActiveSessions = "*/5 * * * *", -- Every 5 minutes
}

-- Max age of data in days (false = never delete)
config.maxAgeTables = {
    playerPositions = 30,      -- days
    serverOnline = 30,         -- days
    killLogs = false,          -- days
    moneyLogs = false,         -- days
    playerSessions = false,    -- days
    playerDisconnects = false, -- days
    chatLogs = 30,             -- days
}

if config.framework == "qb" then
    config.tables.players = "players"
    config.tables.vehicles = "player_vehicles"
elseif config.framework == "esx" then
    config.tables.players = "users"
    config.tables.vehicles = "owned_vehicles"
end

config.inventory = {
    tgiann = GetResourceState("tgiann-inventory") ~= "missing",
    ox = GetResourceState("ox_inventory") ~= "missing",
}

config.ignoreItems = {
    "c_necklace",
    "c_bproof",
    "c_decal",
    "c_torso",
    "c_mask",
    "c_helmet",
    "c_glasses",
    "c_bag",
    "c_pants",
    "c_shoes",
    "c_bracelet",
    "c_watch",
    "c_ear",
}
