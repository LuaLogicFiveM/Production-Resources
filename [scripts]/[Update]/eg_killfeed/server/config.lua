ServerConfig = {}
ServerConfig.AdminGroups = { 'group.tmod', 'group.mod', 'group.admin', 'group.manager', 'group.owner' }
ServerConfig.FrameworkAdmins = { ['owner'] = true, ['manager'] = true}
ServerConfig.DiscordAvatars = {
    Enabled = false,
    BotToken = '',
}
ServerConfig.Webhooks = {
    Enabled = false,
    KillLog = '',
    StrikeLog = '',
}
return ServerConfig
