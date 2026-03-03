ServerConfig = {}
ServerConfig.AdminGroups = { 'group.tmod', 'group.mod', 'group.admin', 'group.manager', 'group.owner' }
ServerConfig.FrameworkAdmins = { ['owner'] = true, ['manager'] = true}
ServerConfig.DiscordAvatars = {
    Enabled = true,
    BotToken = 'MTQ1MjQwNDMzNzU1MTc0MDk1OA.G2wUUW.dXW6H6jqgDAgukpewXGed5R5EEllRygVWz9dik',
}
ServerConfig.Webhooks = {
    Enabled = true,
    KillLog = 'https://discord.com/api/webhooks/1476058495274057778/IWMcJOg0FzrEAr8J2aurYMfmFImK6udDzLyQXWbsquJumjzIv4zpX00jTLl81IWcZHr0',
    StrikeLog = 'https://discord.com/api/webhooks/1476058495274057778/IWMcJOg0FzrEAr8J2aurYMfmFImK6udDzLyQXWbsquJumjzIv4zpX00jTLl81IWcZHr0',
}
return ServerConfig
