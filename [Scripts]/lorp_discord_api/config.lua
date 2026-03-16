Config = {}

Config.Debug = false
Config.UseLogs = true
Config.AllowRefreshCommand = true -- To Refresh permissions
Config.CommandUplinkTime = 5 -- You can use the command every 5 Minutes 

Config.CacheRoles = {
    ServerRoles = true,
    UserRoles = true
}

Config.Permissions = {
    { label = "Owner", roleid = 1252153840275427442, groupname = "group.owner"},
    { label = "Developer", roleid = 1082487500871843860, groupname = "group.owner"},
    { label = "Manager", roleid = 1082487502109147146, groupname = "group.manager"},
    { label = "Admin", roleid = 1082487503161933874, groupname = "group.admin"},
    { label = "Mod", roleid = 1082490565247127653, groupname = "group.mod"},
    { label = "TMod", roleid = 1082490208546717776, groupname = "group.tmod"},
    { label = "Event Team", roleid = 1333507094988455967, groupname = "group.event"},
    { label = "Trusted", roleid = 1268042726541230120, groupname = "group.trusted"},

    { label = "Drag Racer", roleid = 1180029634239287386, groupname = "group.drag"},
    { label = "Drag Manager", roleid = 1180029520426827827, groupname = "group.drag_manager"},

    { label = "Pilots License", roleid = 1482111025061826610, groupname = "group.license_pilots"},
    { label = "Commercial License", roleid = 1482110827409707039, groupname = "group.license_commercial"},

    { label = "Law Enforcement", roleid = 1083264517523394591, groupname = "group.leo"},
    { label = "Emergency Services", roleid = 1329895621355765811, groupname = "group.ems"},

    { label = "Ped Options", roleid = 1345846803680985199, groupname = "group.ped"},

    --{ label = "Bronze", roleid = 1082490208546717776, groupname = "group.rank_bronze"},
}

Config.WhitelistRoleID = "1082487500871843860" -- Id of the Role you want to be able to connect
Config.GuildID = '1082486358028853338' -- ID of your Discord Server
Config.BotToken = 'MTI5NjI3NTkyMjQzMzA4NTQ3MQ.GYSU4Z.ND__YhGIXKWsRRYapTIxmp6FZZ1bTD94f4kqEk'

Config.WebsiteLink = "https://lorp.tebex.io/"
Config.DiscordInvite = "https://discord.gg/lorp"
Config.BackgroundLink = ""
Config.ServerName = "Leaned Out Roleplay" -- If you leave "" it automatically gets your Guild Name or you type in a preferred Name
