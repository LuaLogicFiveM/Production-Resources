--- This file is loaded on the server side and cannot be accessed by cheaters
DiscordConfig = {
    Secret = {
        Token = 'MTQ1MjQwNDMzNzU1MTc0MDk1OA.G2wUUW.dXW6H6jqgDAgukpewXGed5R5EEllRygVWz9dik', --- Your bot token
        Guild = '1082486358028853338', --- Your server ID
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
            Webhook = 'https://discord.com/api/webhooks/1492005552186720256/NMEQVy9ZPZ2V1g0YeI675OcLFaUBaiV9Ifbkcs5J63FNEFIjqN0xpnDy7VhiorvGMKP0',
        },

        Wars = {
            Enabled = true, --- Log gang wars information?
            Webhook = 'https://discord.com/api/webhooks/1492005552186720256/NMEQVy9ZPZ2V1g0YeI675OcLFaUBaiV9Ifbkcs5J63FNEFIjqN0xpnDy7VhiorvGMKP0',
        },

        Manager = {
            Enabled = true, --- Log gang management system?
            Webhook = 'https://discord.com/api/webhooks/1492005552186720256/NMEQVy9ZPZ2V1g0YeI675OcLFaUBaiV9Ifbkcs5J63FNEFIjqN0xpnDy7VhiorvGMKP0',
        },

        Admin = {
            Enabled = true, --- Long all gang admin information?
            Webhook = 'https://discord.com/api/webhooks/1492005552186720256/NMEQVy9ZPZ2V1g0YeI675OcLFaUBaiV9Ifbkcs5J63FNEFIjqN0xpnDy7VhiorvGMKP0',
        }
    }
}