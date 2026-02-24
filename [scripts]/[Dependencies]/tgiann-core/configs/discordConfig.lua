-- Don't share the bot token with anyone
configCore.discordConfig = {
    guildId = '',                   -- Set to the ID of your guild
    botToken = '',                  -- Search google "How to get discord bot token"
    cacheDiscordRoles = true,       -- true to cache player roles, false to make a new Discord Request every time
    cacheDiscordRolesTime = 60,     -- if CacheDiscordRoles is true, how long to cache roles before clearing (in seconds)
    disabledWarningMessage = false, -- Set to true to disable the warning message in console if the bot token is not set
}

configCore.discordLog = {
    name = "TGIANN",
    avatar = "",
}
