SmugglingMission = {}

SmugglingMission.StartingNpc = {
    models = { `IG_IslDJ_01` },
    randomLocation = false,
    scenario = 'WORLD_HUMAN_CLIPBOARD',
    locations = {
        vector4(1445.4951, 1153.1039, 113.3341, 256.4811),
    }
}

SmugglingMission.startItem = "ocean_run_entry"
SmugglingMission.queueName = "ocean-run"                -- The name of the queue
SmugglingMission.activityGroupId = "ocean-run"          -- The name of the queue
SmugglingMission.policeRequired = Config.Debug and 0 or 4                     -- The amount of police required to start the smugglingMission
SmugglingMission.minGroupSize = Config.Debug and 1 or 4                                                       -- The minimum amount of players required to start the smugglingMission
SmugglingMission.timeToFinish = 60                      -- The time in minutes to finish the smugglingMission
SmugglingMission.concurrentJobs = 1                     -- The amount of concurrent jobs allowed
SmugglingMission.cooldown = 120                         -- The amount of time in minutes to wait before being able to start the smugglingMission again

SmugglingMission.loot = {
    rolls = 12,
    table = {
        COMMON = {
            { name = "metalscrap",     min = 2, max = 5 },
            { name = "plastic",        min = 2, max = 4 },
            { name = "moneyband",      min = 3, max = 8 },
            { name = "ar_pendrive_b",  min = 1, max = 1 },
            { name = "lockpick",       min = 1, max = 3 },
        },
        RARE = {
            { name = "ocean_run_entry",  min = 1, max = 1 },
            { name = "iron",             min = 1, max = 3 },
            { name = "copper",           min = 1, max = 3 },
            { name = "steel",            min = 1, max = 2 },
            { name = "heavyarmor",       min = 1, max = 2 },
            { name = "electronickit",    min = 1, max = 2 },
            { name = "repairkit",        min = 1, max = 1 },
            { name = "ar_pendrive_b",    min = 1, max = 1 },
            { name = "advancedlockpick", min = 1, max = 1 },
            { name = "cleaningkit",      min = 1, max = 1 },
            { name = "radio",            min = 1, max = 1 },
            { name = "screwdriverset",   min = 1, max = 2 },
        },
        EPIC = {
            { name = "thermite",     min = 1, max = 2 },
            { name = "drill",        min = 1, max = 1 },
            { name = "cryptostick",  min = 1, max = 1 },
            { name = "trojan_usb",   min = 1, max = 1 },
            { name = "goldchain",    min = 1, max = 1 },
            { name = "diamond_ring", min = 1, max = 1 },
            { name = "armour",       min = 1, max = 1 },
            { name = "binoculars",   min = 1, max = 2 },
        },
        LEGENDARY = {
            { name = "moneyband", min = 34, max = 54 },
            { name = "goldbar",   min = 1,  max = 1 },
            { name = "rolex",     min = 1,  max = 1 },
            { name = "laptop",    min = 1,  max = 1 },
            { name = "diamond",   min = 1,  max = 1 },
            { name = "gold",      min = 1,  max = 1 },
        }
    },
    guaranteedRarities = {
        RARE = 1,
        EPIC = 1,
    }
}

SmugglingMission.UplinkTime = 5 -- Minutes

SmugglingMission.TestCommand = {
    enabled = false,
    name = 'test_smuggling',
    restricted = 'group.owner'
}

SmugglingMission.BoatModel = `dinghy4`
SmugglingMission.TruckModel = `squaddie`
SmugglingMission.DirtBikeModel = `manchez3`

SmugglingMission.Phone = {
    number = "133-374-300",
}

SmugglingMission.WEAPON_HASHES = {
    `WEAPON_PISTOL`,
    `WEAPON_ASSAULTRIFLE`,
    `WEAPON_SMG`,
    `WEAPON_CARBINERIFLE`
}

SmugglingMission.Other = {
    Items = {
        nas = "smuggling_nas",
        hdd = "smuggling_hdd",
        requiredHDDs = 4,
    },
    GUARD_MODEL = `CSB_MWeather`,
    BOAT_GUARD_MODEL = `IG_IslDJ_01`,

    NAS_ZONES = {
        {
            coords = vec3(5477.06, -5852.12, 20.45),
            size = vec3(2.5, 1.15, 1.6),
            rotation = 0.0,

            -- debug = false
        },
        {
            coords = vec3(5477.06 + 3.08, -5852.12, 20.45),
            size = vec3(2.5, 1.15, 1.6),
            rotation = 0.0,

            -- debug = false
        }
    },
    LOOT = {
        MODEL = `reck_lootbox_a`,

        POSITION = vec3(5475.10, -5847.27, 19.02),
        ROTATION = vec3(0.00, 0.00, 90.00),

        ANIMATIONS = {
            DICT = "reck@lootbox@a",
            OPEN = "opening"
        }
    },

    NAS = {
        MODEL = `tr_prop_tr_ser_storage_01a`,

        DRIVE = `prop_cs_server_drive`,

        ANIMATIONS = {
            DICT = "anim@scripted@player@mission@tunf_bunk_ig2_hdd_nas@male@",

            PLAYER = "player_pluging_in",

            NAS = "player_pluging_in_nas",

            DRIVE_1 = "player_pluging_in_drive_1",
            DRIVE_2 = "player_pluging_in_drive_2",
            DRIVE_3 = "player_pluging_in_drive_3",
            DRIVE_4 = "player_pluging_in_drive_4",
        }
    },

    SERVER_RACK = {
        DRIVE = `prop_cs_server_drive`,

        ANIMATIONS = {
            DICT = "anim@scripted@player@mission@tun_bunk_ig1_hdd_server@male@",

            PLAYER = "action",
            DRIVE = "action_drive"
        }
    },

    SERVER_RACKS = {
        {
            POSITION = vec3(5474.197265625, -5852.06298828125, 20.24762535095215),
            MODEL = `ook3d_server_1`
        },
        {
            POSITION = vec3(5474.19287109375, -5851.12060546875, 20.26948928833007),
            MODEL = `ook3d_server_2`
        },
        {
            POSITION = vec3(5474.18408203125, -5849.2587890625, 20.12475776672363),
            MODEL = `ook3d_server_1`
        },
        {
            POSITION = vec3(5482.89990234375, -5849.10205078125, 20.20925521850586),
            MODEL = `ook3d_server_1`
        },
        {
            POSITION = vec3(5482.904296875, -5850.1337890625, 20.27538299560547),
            MODEL = `ook3d_server_2`
        },
        {
            POSITION = vec3(5482.9091796875, -5851.0126953125, 20.16505050659179),
            MODEL = `ook3d_server_1`
        },
        {
            POSITION = vec3(5482.91357421875, -5852.03369140625, 20.09422874450683),
            MODEL = `ook3d_server_1`
        }
    }
}

SmugglingMission.Locations = {
    {
        boat = vector4(650.769, -1839.121, 8.077, 173.455),

        truck = vector4(4978.276, -5173.507, 2.466, 250.256),
        dirtBikes = {
            vector4(4978.682, -5170.498, 2.452, 245.450),
            vector4(4977.607, -5177.190, 2.473, 247.784)
        },

        boatGuards = {
            vector4(673.299, -1741.635, 8.658, 174.231),
            vector4(657.315, -2121.369, 0.125, 152.965),
            vector4(604.589, -2168.050, 0.120, 223.450)
        },
        guards = {
            vector4(5482.380, -5737.663, 24.652, 176.911),
            vector4(5475.117, -5731.729, 26.536, 182.533),
            vector4(5443.228, -5748.282, 29.882, 201.125),
            vector4(5432.568, -5754.889, 31.836, 213.671),
            vector4(5417.802, -5758.148, 33.921, 202.469),
            vector4(5417.802, -5758.148, 33.921, 202.469),
            vector4(5423.334, -5794.188, 31.407, 224.156)
        },
        islandGuards = {
            vector4(4953.790, -5183.536, 4.694, 20.325),
            vector4(4960.345, -5133.594, 2.545, 110.678),
            vector4(4953.598, -5151.232, 2.439, 116.342),
            vector4(4984.726, -5166.194, 2.514, 91.527),
            vector4(4985.658, -5184.467, 2.497, 49.480),
            vector4(4997.323, -5204.987, 13.654, 50.328),
            vector4(4992.669, -5144.120, 2.366, 122.029),
            vector4(5015.485, -5200.917, 2.487, 48.627)
        }
    }
}

SmugglingMission.DropOff = vector3(5478.159, -5842.565, 19.833)
