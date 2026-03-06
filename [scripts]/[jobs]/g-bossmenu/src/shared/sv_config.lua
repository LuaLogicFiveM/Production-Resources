SV_CONFIG = {}

SV_CONFIG.DiscordLogs = {
    Logs = {
        -- Triggered when a player purchases a vehicle
        ['VEHICLE_PURCHASE'] = {
            ['bcso'] = {
                enable = true,
                webhook = "https://discord.com/api/webhooks/1479569429045186801/PqzGrxFP7UGmq6k-Ch6Jhvn9ehAlkiiSEsvFqrqRT9E0t6mqqToMnAVD7JJ66SbDDvd1",
            },
            ['sasp'] = {
                enable = true,
                webhook = "https://discord.com/api/webhooks/1479569429045186801/PqzGrxFP7UGmq6k-Ch6Jhvn9ehAlkiiSEsvFqrqRT9E0t6mqqToMnAVD7JJ66SbDDvd1",
            },
            ['safd'] = {
                enable = true,
                webhook = "https://discord.com/api/webhooks/1479569429045186801/PqzGrxFP7UGmq6k-Ch6Jhvn9ehAlkiiSEsvFqrqRT9E0t6mqqToMnAVD7JJ66SbDDvd1",
            },
        },
        -- withdraw and deposit logs
        ['TRANSACTIONS'] = {
            ['bcso'] = {
                enable = true,
                webhook = "https://discord.com/api/webhooks/1479569429045186801/PqzGrxFP7UGmq6k-Ch6Jhvn9ehAlkiiSEsvFqrqRT9E0t6mqqToMnAVD7JJ66SbDDvd1"
            },
            ['sasp'] = {
                enable = true,
                webhook = "https://discord.com/api/webhooks/1479569429045186801/PqzGrxFP7UGmq6k-Ch6Jhvn9ehAlkiiSEsvFqrqRT9E0t6mqqToMnAVD7JJ66SbDDvd1"
            },
            ['safd'] = {
                enable = true,
                webhook = "https://discord.com/api/webhooks/1479569429045186801/PqzGrxFP7UGmq6k-Ch6Jhvn9ehAlkiiSEsvFqrqRT9E0t6mqqToMnAVD7JJ66SbDDvd1",
            },
        },
        -- hire/fire/promote logs
        ['EMPLOYEE_ACTIONS'] = {
            ['bcso'] = {
                enable = true,
                webhook = "https://discord.com/api/webhooks/1479569429045186801/PqzGrxFP7UGmq6k-Ch6Jhvn9ehAlkiiSEsvFqrqRT9E0t6mqqToMnAVD7JJ66SbDDvd1"
            },
            ['sasp'] = {
                enable = true,
                webhook = "https://discord.com/api/webhooks/1479569429045186801/PqzGrxFP7UGmq6k-Ch6Jhvn9ehAlkiiSEsvFqrqRT9E0t6mqqToMnAVD7JJ66SbDDvd1"
            },
            ['safd'] = {
                enable = true,
                webhook = "https://discord.com/api/webhooks/1479569429045186801/PqzGrxFP7UGmq6k-Ch6Jhvn9ehAlkiiSEsvFqrqRT9E0t6mqqToMnAVD7JJ66SbDDvd1",
            },
        },

    }
}
