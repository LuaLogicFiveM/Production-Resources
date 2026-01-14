return {
    confiscateItems = true,

    taskSpots = {
        vec3(1628.29, 2500.48, 45.6),
        vec3(1640.58, 2513.49, 45.6),
        vec3(1656.20, 2520.62, 45.6),
        vec3(1669.09, 2517.21, 45.6),
        vec3(1657.43, 2505.08, 45.6),
        vec3(1643.33, 2498.08, 45.6),
        vec3(1677.58, 2494.06, 45.6),
        vec3(1692.81, 2484.77, 45.6),
        vec3(1701.06, 2497.13, 45.6),
        vec3(1699.95, 2516.41, 45.6),
        vec3(1714.22, 2509.12, 45.6),
        vec3(1720.01, 2495.60, 45.6),
        vec3(1703.98, 2486.41, 45.6),
        vec3(1687.74, 2502.53, 45.6),
        vec3(1664.87, 2499.19, 45.6)
    },

    logging = {
        enabled = true,
        system = 'discord', -- ox_lib (recommended) or discord (not recommended)

        name = 'Admin Jail',
        image = 'https://r2.fivemanage.com/mRGMLnWSeQJ90gOfps6Wt/peakscripts.png',
        webhookUrl = 'https://discord.com/api/webhooks/1234995481789202523/_uC2YoUYpr-CXXwtEnfECqv-QA1J-Ui1v-gvn65R95HO0B41jf_SKZ0rnY3j4LNGKH3H'
    },

    commands = {
        services = {
            name = 'ajailmenu',
            help = 'View and manage players in community service',
            restricted = 'group.tmod'
        },

        comserv = {
            name = 'ajail',
            help = 'Assign community service to a player',
            restricted = 'group.tmod'
        },

        removecomserv = {
            name = 'ajailr',
            help = 'Remove a player from community service',
            restricted = 'group.tmod'
        }
    }
}
