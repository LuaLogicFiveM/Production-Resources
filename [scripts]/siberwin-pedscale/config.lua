Config = {}

---------------------------------------------
 -- SW - Ped Scale | SW Settings
---------------------------------------------

Config.Title = "Ped Scale"

---------------------------------------------
 -- SW - Ped Scale | Commands
---------------------------------------------

Config.Commands = {
    scalePed = "scalemenu",
    resetScale = "resetscale",
    setScale = "setscale", -- /setscale 0.6
    setWeight = "setweight", -- /setweight 0.9
    giveScaleMenu = "givescalemenu", -- /givescalemenu playerid
    checkScale = "checkscale" -- /checkscale - veritabanı kayıtlarını görüntüle
}

---------------------------------------------
 -- SW - Ped Scale | Scale Settings
---------------------------------------------

Config.MinScale = 0.5
Config.MaxScale = 1.2
Config.ScaleStep = 0.1

---------------------------------------------
 -- SW - Ped Scale | Weight Settings
---------------------------------------------
Config.WeightEnabled = true -- Enable/disable weight feature
Config.MinWeight = 0.8
Config.MaxWeight = 1.15
Config.WeightStep = 0.05

---------------------------------------------
 -- SW - Ped Scale | Language Settings
---------------------------------------------

Config.Language = "en" -- Available: "en", "tr", "es", "de", "fr", "it", "pl", "ru", "ar", "bg", "cs", "el", "fi", "he", "hi", "hr", "hu", "id", "ja", "ko", "nl", "no", "pt-br", "ro", "sv", "th", "uk"

---------------------------------------------
 -- SW - Ped Scale | Notification Settings
---------------------------------------------

Config.Notification = {
    sounds = true, -- Enable/disable notification sounds
    duration = 5000 -- Default notification duration in milliseconds
}

---------------------------------------------
 -- SW - Ped Scale | Auto Apply Settings
---------------------------------------------

Config.AutoApplyOnSpawn = true -- Set to false to disable automatic scale application

---------------------------------------------
 -- SW - Ped Scale | State Bag Synchronization Settings (Ultra-Fast)
---------------------------------------------

Config.StateName = "pedScale" -- State bag key for player scale data
Config.ScaleUpdateInterval = 0 -- Update frequency in milliseconds (0 = every frame for max speed)
Config.MaxScaleDistance = 75.0 -- Distance for sync coverage (meters)
Config.StateBagEnabled = true -- Enable state bag synchronization system

---------------------------------------------
 -- SW - Ped Scale | Discord Settings
---------------------------------------------

Config.Discord = {
    enabled = true, -- Enable/disable Discord logging
    webhook = "", -- Your Discord webhook URL
    botName = "Ped Scale", -- Bot name that appears in Discord
    botAvatar = "", -- Bot avatar URL (optional)
    
    -- Discord Role Permission Settings
    rolePermission = {
        enabled = true, -- Enable/disable Discord role permission system
        guildId = GetConvar('discord_guild_id', ""), -- Your Discord server (guild) ID
        roleId = "1489351543919607888", -- Required role ID for scale menu access
        botToken = "" -- Bot token from server.cfg
    },
    
    logs = {
        scaleChange = true, -- Log when players change their scale
        adminActions = true, -- Log admin actions (givescale, checkscale)
        systemEvents = true -- Log system events (player join/leave with active scales)
    }
}

---------------------------------------------
 -- SW - Ped Scale | Permission / Check Scale UI Settings
---------------------------------------------

Config.Permissions = {
    enabled = true, 
    groups = {"owner", "manager"}, 
    identifiers = {} 
}

Config.GiveScaleMenu = {
    enabled = true, 
    command = "givescalemenu",
    description = "Open Ped Scale menu to player",
    group = "owner" 
}

Config.CheckScale = {
    enabled = true, 
    command = "checkscale", 
    description = "View and manage scale database records",
    group = "owner" 
}
