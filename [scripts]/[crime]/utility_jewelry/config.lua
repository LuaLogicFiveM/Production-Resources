Config = {}

Config.Target = true
Config.CustomTargetResource = "" -- if you have a custom target resource name set it here

Config.Debug = false

Config.BankResetTime = 5 -- (m) time the bank need to be empty to reset the robbery
Config.AlarmTriggerTime = 30 -- (s)

Config.Cameras = {
    Outline = {
        enabled = true, -- Outlines cameras on robbery start
        marker = false, -- Use the markers to highlight the cctvs
        color = vec4(240, 200, 80, 40), -- RGBA (0-255)
    },
    Reward = 5, -- (s) this is the amount of time the camera will reward if broken
}

Config.Shutters = {
    closed = false, -- If true the shutters will be closed by default, this will also turn off the lights (can be opened only by the electric box outside of the store)

    item = "screwdriver_jewelry", -- This will require ESX or QBCore. Set to nil or an empty to string to disable it
    command = "shutters_jewelry", -- This will be a restricted command, so make sure to give ACE permissions to a group/identifier that can use it
    distance = 30.0,

    -- You can also add a list of jobs that can open the shutters using the item/command (ESX or QBCore required)
    jobs = {
        -- ["police"] = 1,
        --
        -- OR
        -- 
        "bcso",
        "sasp",
        "gov"
    }
}

-- TODO: Add localazy
Config.Translations = {
    ["vault_minigame_help"] = "~INPUT_FRONTEND_PAUSE_ALTERNATE~ / ~INPUT_AIM~ Confirm combination.",

    ["shutters_toggling"] = "Toggling shutters in the nearest Jewelry.",
    ["shutters_no_near"] = "~r~There is no jewelry near you.",
    ["no_auth"] = "~r~You are not authorized to use this.",

    ["electric_help_toggle"] = "Toggle puzzle",
    ["electric_help_rotate"] = "Rotate connector",

    ["robbery_cant_start_notify"] = "~r~You cannot start a robbery here."
}

Config.Bars = {
    -- Offsets for text and bar
    -- Text offset is relative to the bar (so 0.0 is the default position, - is left and + is right)

    -- values: 0.0 to 1.0
    -- x axis: left to right
    -- y axis: top to bottom
    barOffset = vec2(0.85, 0.938),
    textOffset = vec2(0.0, 0.0)
}

Config.Blips = {
    Robbery = {
        name = "Jewelry Robbery",
        sprite = 586,
        color = 1,
        scale = 1.0,
    
        duration = 30000 -- If the player does not approach the blip after this time it will be eliminated, set to -1 to disable
    }
}

Config.Interactions = {
    hackElectricBox = {
        label = "Hack electric box",
        icon = "fas fa-power-off",
        distance = 2.0,

        notify = "Press {E} to hack the electric box.",
    },
    enterVaultMinigame = {
        label = "Start vault minigame",
        icon = "fas fa-vault",
        distance = 5.0,

        notify = "Press {E} to start the vault minigame.",
    },
    lootStand = {
        label = "Loot",
        icon = "fa-regular fa-gem",
        distance = 2.0,

        notify = "Press {E} to loot the stand.",
    },
    lootItem = {
        label = "Loot",
        icon = "fa-regular fa-gem",
        distance = 2.0,

        notify = "Press {E} to loot the artifact.",
    },
    cuttGlass = {
        label = "Cut glass",
        icon = "fas fa-magnifying-glass",
        distance = 2.0,

        notify = "Press {E} to cut the glass.",
    },
    riffleButt = {
        label = "Smash glass",
        icon = "fas fa-person-rifle",
        distance = 2.0,

        notify = "Press {E} to smash the glass.",

        weaponGroups = {`GROUP_RIFLE`, `GROUP_SMG`}, -- allowed weapon groups, https://docs.fivem.net/natives/?_0xC3287EE3050FB74C
        fast = true -- If true it will not move the player at the correct position (this can be faster but less precise)
    }
}

-- Stands can have up to 1000 health, more health means more bullets to break it
Config.StandsLife = 100
Config.StandsDontBreakWithDamage = false -- If true it will not break the stands when they take damage (from any source)

-- How much every stands will drop (look at Config.Items for values)
Config.Stands = {
    [`mxc_jewelry_props_littletray_01_a`] = "small",
    [`mxc_jewelry_props_littletray_02_a`] = "medium",
    [`mxc_jewelry_props_littletray_03_a`] = "big",
    [`mxc_jewelry_props_littletray_04_a`] = "small",
    [`mxc_jewelry_props_littletray_05_a`] = "medium",
    [`mxc_jewelry_props_littletray_06_a`] = "medium",
    [`mxc_jewelry_props_littletray_07_a`] = "medium",

    [`mxc_jewelry_props_roundtray_01_a`] = "medium",
    [`mxc_jewelry_props_roundtray_02_a`] = "medium",
    [`mxc_jewelry_props_roundtray_03_a`] = "medium",
    [`mxc_jewelry_props_roundtray_04_a`] = "medium",

    [`mxc_jewelry_props_singletray_01_a`] = "small",
    [`mxc_jewelry_props_singletray_02_a`] = "small",
    [`mxc_jewelry_props_singletray_03_a`] = "small",

    [`mxc_jewelry_props_viptray_01_a`] = "medium",
    [`mxc_jewelry_props_viptray_02_a`] = "medium",
    [`mxc_jewelry_props_viptray_03_a`] = "medium",
    [`mxc_jewelry_props_viptray_04_a`] = "medium",
    [`mxc_jewelry_props_viptray_05_a`] = "medium",
}

Config.Items = {
    enabled = true, -- Enable all items drop/requirement (ESX or QBCore required)

    stands = {
        small = {1, 5}, -- Amount of jewels to drop (min, max)
        medium = {5, 10},
        big = {10, 20},
    },

    -- Artifacts (vault room)
    panther = "panther",
    ruby = "ruby",
    ruby_necklace = "ruby_necklace",
    emerald = "emerald",
    golden_banana = "golden_banana",
    
    jewels = "jewels", -- Hint: you can also provide a table of items to drop (the item will be randomly selected from the table)
    
    -- Minigames
    electric_box = "cable_cutter", -- Item required to hack the electric box (empty = no requirement)
    glass_cut = "glass_cutter" -- Item required to cut the glass (empty = no requirement)
}

Config.Cops = {
    required = 3, -- Number of cops required

    jobs = {
        esx = {"bcso", "sasp", "gov"}, -- job.name
        qbcore = {"leo"}, -- job.type
    }
}