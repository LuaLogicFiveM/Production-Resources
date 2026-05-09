Config = {}

Config.Debug = false
Config.LogWebhook = ""

Config.Mission = {
    name = "gun_smuggling",
    label = "Gun Smuggling",
    description = "Smuggle guns for profit. Talk to the contact to get started.",
    phoneNumber = ("%d-%d-%d"):format(math.random(100, 999), math.random(100, 999), math.random(1000, 9999)),
    policeRequired = 0,
    concurrentMissions = 1,
    timeout = 60 * 25,
    groupMembers = {
        min = Config.Debug and 0 or 2,
        max = 4
    }
}

Config.BoatModel = `dinghy`

Config.ResetCommand = {
    enabled = true,
    command = "reset_smuggling",
    restriction = "group.manager"
}

Config.QueuePed = {
    model = "s_m_y_dealer_01",
    coords = vector4(2867.463, -1404.555, 2.390 - 1.0, 268.286)
}

Config.Timeout = 60 * 25                      -- 20 minutes for each stage until finished (win/fail depending on how long you got).
Config.RequiredMembers = Config.Debug and 0 or 1     -- 4 members required to start the smuggling mission.

Config.Timers = {
    CNC = Config.Debug and 20 or 60 * 5,
    Airfield = Config.Debug and 20 or 60 * 15
}

Config.Alert = {
    jobs = { 'gsp' },
    code = "10-90",
    title = "Gun Smuggling in Progress",
    description = "A truck has been reported transporting illegal firearms.",
    blip = {
        sprite = 110,
        size = 4,
        color = 3
    }
}

Config.GunCrateOffsets = {
    [`youga3`] = {
        vec3(0.0, -1.0, -0.25)
    }
}

Config.Scene = {
    ped = {
        model = `MP_M_WeapWork_01`,
        location = vector4(4814.146, -4315.390, 5.674 - 1.0, 337.013),

        animation = "WORLD_HUMAN_LEANING"
    },
    cnc = {
        location = vector3(4818.603, -4316.510, 5.696)
    },
}

Config.Items = {
    crate = "gun_smuggling_crate",
}

Config.AIRFIELDS = {
    {
        label = "Grapeseed Clothing Store",
        location = vector4(1702.201, 4819.906, 41.955 - 1.0, 277.053),
        truck = {
            model = `novak`,
            location = vector4(1705.540, 4830.030, 42.021 - 1.0, 359.714)
        }
    },
    {
        label = "Zancudo Clothing Store",
        location = vector4(-1127.508, 2696.811, 18.800 - 1.0, 132.523),
        truck = {
            model = `novak`,
            location = vector4(-1134.828, 2694.839, 18.970, 155.488)
        }
    },
    {
        label = "Paleto Clothing Store",
        location = vector4(10.880, 6506.912, 31.533 - 1.0, 223.214),
        truck = {
            model = `novak`,
            location = vector4(18.729, 6507.197, 31.660, 225.141)
        }
    }
}

Config.LOCATIONS = {
    {
        ped = vector4(2360.690, 6644.464, 2.028 - 1.0, 42.215),
        boat = vector4(2388.564, 6670.383, 1.269, 319.883),
        guards = {
            vector4(2344.223, 6743.344, -0.326, 345.511),
            vector4(2321.038, 6726.692, -0.039, 210.487),
            -- vector4(2378.019, 6746.740, 0.536, 192.925),
            -- vector4(2446.404, 6728.974, 0.888, 111.938)
        }
    },
    {
        ped = vector4(-2077.895, 2605.762, 2.030 - 1.0, 173.472),
        boat = vector4(-2076.023, 2594.570, -0.474 - 1.0, 199.764),
        guards = {
            vector4(-2027.319, 2545.809, 0.137, 55.970),
            vector4(-2058.189, 2549.565, 0.148, 62.973),
            -- vector4(-2188.984, 2552.240, 0.129, 26.830),
            -- vector4(-2171.927, 2561.011, 0.090, 20.215)
        }
    },
    {
        ped = vector4(848.332, -2599.145, 1.085 - 1.0, 138.387),
        boat = vector4(842.502, -2606.034, 0.395, 60.542),
        guards = {
            vector4(762.361, -2639.710, -0.345, 252.798),
            vector4(789.546, -2683.986, 0.496, 244.571),
            -- vector4(834.553, -2776.650, 0.450, 274.017),
            -- vector4(944.731, -2856.314, -0.417, 285.906)
        }
    }
}

Config.MISSIONS = {
    {
        label = locale("SMUGGLING_MISSION_SMG_LABEL"),
        description = locale("SMUGGLING_MISSION_SMG_DESC"),
        requiredContractItem = "gun_smuggling_contract_smg",

        items = {
            {
                name = "metalscrap",
                count = 10
            }
        },

        cnc = {
            {
                name = "gun_smuggling_crate",
                count = 1
            }
        },
    },
    {
        label = locale("SMUGGLING_MISSION_SMG_BIG_LABEL"),
        description = locale("SMUGGLING_MISSION_SMG_BIG_DESC"),
        requiredContractItem = "gun_smuggling_contract_smg_large",

        items = {
            {
                name = "metalscrap",
                count = 10
            }
        },

        cnc = {
            {
                name = "gun_smuggling_crate",
                count = 1
            }
        },
    },
    {
        label = locale("SMUGGLING_MISSION_RIFLE_LABEL"),
        description = locale("SMUGGLING_MISSION_RIFLE_DESC"),
        requiredContractItem = "gun_smuggling_contract_rifle",

        items = {
            {
                name = "metalscrap",
                count = 10
            }
        },

        cnc = {
            {
                name = "gun_smuggling_crate",
                count = 1
            }
        },
    },
    {
        label = locale("SMUGGLING_MISSION_CHAOS_LABEL"),
        description = locale("SMUGGLING_MISSION_CHAOS_DESC"),
        requiredContractItem = "gun_smuggling_contract_chaos",

        items = {
            {
                name = "metalscrap",
                count = 10
            }
        },

        cnc = {
            {
                name = "gun_smuggling_crate",
                count = 1
            }
        },
    }
}

Config.DROP_OFFS = {
    {
        center = vector3(4819.712, -4308.104, 5.451)
    }
}

Config.SafeHouses = {
    vector4(1134.6401, -323.1369, 67.1459 - 1.0, 8.9469),
    vector4(510.621, -1951.549, 24.985 - 1.0, 306.400),
    vector4(562.402, -3125.602, 18.769 - 1.0, 297.188),
    vector4(-691.069, -724.031, 28.681 - 1.0, 127.511)
}

Config.TruckTransport = {
    onlineMembers = debug and 0 or 3,     -- 3 members in the group to receive the notification of another truck mission.
    totalOrgs = debug and 9999 or 2,      -- 2 orgs to receive the notification of another truck mission.

    trackerTimeout = 60 * 10,             -- 10 minutes to disable the tracker.

    guaranteedRewards = {
        {     -- Regular SMGs
            {
                itemId = "metalscrap",
                count = 5,
            },
            {
                itemId = "iron",
                count = 3,
            },
            {
                itemId = "steel",
                count = 2,
            },
            {
                itemId = "electronickit",
                count = 2,
            },
            {
                itemId = "copper",
                count = 3,
            },
            {
                itemId = "repairkit",
                count = 1,
            },
            {
                itemId = "screwdriverset",
                count = 2,
            },
            {
                itemId = "plastic",
                count = 3,
            },
            {
                itemId = "lockpick",
                count = 2,
            },
            {
                itemId = "rubber",
                count = 2,
            },
            {
                itemId = "cleaningkit",
                count = 1,
            },
            {
                itemId = "thermite",
                count = 1,
            },
            {
                itemId = "glass",
                count = { 3, 5 },
            }
        },
        {     -- Larger SMGs
            {
                itemId = "steel",
                count = 3,
            },
            {
                itemId = "iron",
                count = 2,
            },
            {
                itemId = "copper",
                count = 3,
            },
            {
                itemId = "electronickit",
                count = 2,
            },
            {
                itemId = "advancedlockpick",
                count = 1,
            },
            {
                itemId = "repairkit",
                count = 2,
            },
            {
                itemId = "metalscrap",
                count = 4,
            },
            {
                itemId = "screwdriverset",
                count = 2,
            },
            {
                itemId = "plastic",
                count = 3,
            },
            {
                itemId = "rubber",
                count = 2,
            },
            {
                itemId = "drill",
                count = 1,
            },
            {
                itemId = "glass",
                count = { 3, 5 },
            }
        },
        {     -- Rifles
            {
                itemId = "steel",
                count = 3,
            },
            {
                itemId = "iron",
                count = 3,
            },
            {
                itemId = "copper",
                count = 2,
            },
            {
                itemId = "electronickit",
                count = 2,
            },
            {
                itemId = "advancedlockpick",
                count = 1,
            },
            {
                itemId = "cleaningkit",
                count = 1,
            },
            {
                itemId = "metalscrap",
                count = 4,
            },
            {
                itemId = "repairkit",
                count = 2,
            },
            {
                itemId = "thermite",
                count = 1,
            },
            {
                itemId = "screwdriverset",
                count = 2,
            },
            {
                itemId = "rubber",
                count = 2,
            },
            {
                itemId = "glass",
                count = { 3, 5 },
            }
        },
        {     -- Chaos
            {
                itemId = "steel",
                count = 4,
            },
            {
                itemId = "iron",
                count = 3,
            },
            {
                itemId = "copper",
                count = 3,
            },
            {
                itemId = "metalscrap",
                count = 5,
            },
            {
                itemId = "thermite",
                count = 2,
            },
            {
                itemId = "drill",
                count = 1,
            },
            {
                itemId = "electronickit",
                count = 2,
            },
            {
                itemId = "glass",
                count = { 4, 6 },
            }
        }
    },

    rewardCount = 2,
    rewards = {
        {   -- Regular SMGs
            COMMON = {
                { name = "lockpick",       min = 1, max = 3 },
                { name = "metalscrap",     min = 2, max = 5 },
            },
            RARE = {
                { name = "electronickit",    min = 1, max = 2 },
                { name = "advancedlockpick", min = 1, max = 1 },
            },
            EPIC = {
                { name = "cryptostick", min = 1, max = 1 },
            },
        },
        {   -- Larger SMGs
            COMMON = {
                { name = "plastic",  min = 2, max = 4 },
            },
            RARE = {
                { name = "repairkit", min = 1, max = 2 },
            },
            EPIC = {
                { name = "trojan_usb", min = 1, max = 1 },
            },
        },
        {   -- Rifles
            COMMON = {
                { name = "rubber",         min = 2, max = 4 },
                { name = "screwdriverset", min = 1, max = 2 },
            },
            RARE = {
                { name = "iron",  min = 1, max = 3 },
            },
            EPIC = {
                { name = "thermite", min = 1, max = 1 },
            },
        },
        {   -- Chaos
            COMMON = {
                { name = "steel",  min = 1, max = 3 },
                { name = "copper", min = 1, max = 3 },
            },
        },
    }
}
