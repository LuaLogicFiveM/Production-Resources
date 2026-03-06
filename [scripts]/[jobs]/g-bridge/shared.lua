Config = Config or {}

Config.SystemSettings = {
    CheckForUpdates = true,
    Debug = true,
    Notifications = 'auto', -- auto, okokNotify, g-notifications, qbox, qb-notify, ox-lib, mythic_notify, esx, gta-default, lation_ui, wasabi_notify
    TextUi = 'auto', -- auto, ox_lib, okok, qbcore, esx, jg-textui, cd_drawtextui, lation_ui
}

Config.Resources = {
    Notifications = {
        [1] = { name = 'g-notifications', resource = 'g-notifications' },
        [2] = { name = 'okokNotify', resource = 'okokNotify' },
        [3] = { name = 'qbox', resource = 'qbox' },
        [4] = { name = 'qb-notify', resource = 'qb-notify' },
        [5] = { name = 'ox-lib', resource = 'ox_lib' },
        [6] = { name = 'mythic_notify', resource = 'mythic_notify' },
        [7] = { name = 'esx', resource = 'esx' },
        [8] = { name = 'gta-default', resource = 'gta_default' },
        [9] = { name = 'lation_ui', resource = 'lation_ui' },
        [10] = { name = 'wasabi_notify', resource = 'wasabi_notify' },
        -- add more notifications here
    },
    TextUi = {
        [1] = { name = 'ox_lib', resource = 'ox_lib' },
        [2] = { name = 'okok', resource = 'okok' },
        [4] = { name = 'esx', resource = 'es_extended' },
        [3] = { name = 'qbcore', resource = 'qb-core' },
        [5] = { name = 'jg-textui', resource = 'jg-textui' },
        [6] = { name = 'cd_drawtextui', resource = 'cd_drawtextui' },
        [7] = { name = 'lation_ui', resource = 'lation_ui' },
        -- add more text ui here
    },
}