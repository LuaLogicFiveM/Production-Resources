SV_CONFIG = {}

SV_CONFIG.DiscordLogs = {
    Logs = {
        -- Triggered when a player purchases a vehicle
        ['VEHICLE_PURCHASE'] = {
            ['bcso'] = {
                enable = true,
                webhook = "",
            },
            ['gsp'] = {
                enable = true,
                webhook = "",
            },
            ['safd'] = {
                enable = true,
                webhook = "",
            },
        },
        -- withdraw and deposit logs
        ['TRANSACTIONS'] = {
            ['bcso'] = {
                enable = true,
                webhook = ""
            },
            ['gsp'] = {
                enable = true,
                webhook = ""
            },
            ['safd'] = {
                enable = true,
                webhook = "",
            },
        },
        -- hire/fire/promote logs
        ['EMPLOYEE_ACTIONS'] = {
            ['bcso'] = {
                enable = true,
                webhook = ""
            },
            ['gsp'] = {
                enable = true,
                webhook = ""
            },
            ['safd'] = {
                enable = true,
                webhook = "",
            },
        },

    }
}
