--- This file is loaded on the server side and cannot be accessed by cheaters
DiscordConfig = {
    Secret = {
        Token = GetConvar('discord_token', ""), --- Your bot token
        Guild = GetConvar('discord_guild_id', ""), --- Your server ID
    },

    Leaderboards = {
        Turfs = {
            Enabled = true, --- Enable turf war leaderboard?
            Channel = 1492005373266362489, --- Channel ID
            Color = 0xE74C3C, --- Color hash of the webhook
        },

        GangWars = {
            Enabled = true, --- Enable gang wars leaderboard?
            Channel = 1492005373266362489, --- Channel ID
            Color = 0x5865F2, --- Color hash of the webhook
        },

        GangSeason = {
            Enabled = true, --- Enable gang season leaderboard?
            Channel = 1492005373266362489, --- Channel ID
            Color = 0xF1B44F, --- Color has of the webhook
        }
    },

    Settings = {
        ServerName = "Leaned Out RP", --- Put your server name here
        ServerImg = "", --- Put your server image here
        Color = 0xE74C3C, --- Color theme of your server
    },

    Logs = {
        Turfs = {
            Enabled = true, --- Log all turf wins?
            Webhook = '',
        },

        Wars = {
            Enabled = true, --- Log gang wars information?
            Webhook = '',
        },

        Manager = {
            Enabled = true, --- Log gang management system?
            Webhook = '',
        },

        Admin = {
            Enabled = true, --- Long all gang admin information?
            Webhook = '',
        }
    }
}