-- Don't share the bot token with anyone
configCore.discordConfig = {
    guildId = '1082486358028853338',               -- Set to the ID of your guild
    botToken = 'MTA4NDU2NzQxMjE5MzYyODMzMQ.G_rt_-.20Gp2-fNI9GhmEz9Gn5vhK0kveERTHcPDWDxaQ',              -- Search google "How to get discord bot token"
    cacheDiscordRoles = true,   -- true to cache player roles, false to make a new Discord Request every time
    cacheDiscordRolesTime = 60, -- if CacheDiscordRoles is true, how long to cache roles before clearing (in seconds)
}

configCore.discordLog = {
    name = "Server Monitor",
    avatar = "",
}
