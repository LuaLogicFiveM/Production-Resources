svConfig = {}

svConfig.interiors = {
    {
        key = "warehouse_1",
        enter = vector4(1447.613, -1412.612, -25.911, 183.480),
        exit = {
            {
                coords = vec3(1447.55, -1411.4, -25.75),
                size = vec3(1.5, 0.75, 2.5),
                rotation = 0.0,
            },
        },
        interiorCoords = vector3(1423.319, -1453.790, -25.911),
    },
}

Mission = {}

Mission.StartingNpc = {
    models = { `CSB_MWeather` },
    randomLocation = false,
    scenario = 'WORLD_HUMAN_CLIPBOARD',
    locations = {
        vector4(2667.2937, 1455.6952, 19.8223, 90.0127),
    }
}

Mission.startItem = "warehouse_entry"
Mission.queueName = "warehouse-robbery"       -- The name of the queue
Mission.policeRequired = Config.Debug and 0 or 4                    -- The amount of police required to start the mission
Mission.minGroupSize = Config.Debug and 1 or 4-- The minimum amount of players required to start the mission
Mission.timeToFinish = 60          -- The time in minutes to finish the mission
Mission.concurrentJobs = 2         -- The amount of concurrent jobs allowed
Mission.cooldown = 1.5            -- The amount of time in hours to wait before being able to start the mission again
Mission.forceEntitySet = nil -- The entity set to force, nil for random

Mission.Phone = {
    number = "133-374-200",
}

Mission.Alert = {
    chance = 30,
    code = "10-90",
    jobs = {"gsp"},
    blip = {
        icon = 473,
        size = 1.2,
        color = 48,
        duration = 10 * 60,
        flashing = true,
    },
}

Mission.BaseItemsInSafeStash = {
    { "bandage", math.random(18, 25) }
}

Mission.Other = {
    Items = {
        fuse = "warehouse_fuse",
        bomb = "warehouse_bomb",
        requiredFuses = 4,
    },

    CASE_MODEL = `tr_prop_tr_adv_case_01a`,

    BOX_MODEL = `m23_2_prop_m32_cbcrate_01a`,
    BOX_OPEN_MODEL = `m23_2_prop_m32_cbcrate_01b`,

    ELECTRICITY_MODEL = `reh_prop_reh_b_computer_04a`,

    FUSE_MODEL = `reh_prop_reh_fuse_01a`,

    OPEN_BOX = {
        CROWBAR_MODEL = `w_me_crowbar`,
        DRUG_BAG_MODEL = `m23_2_prop_m32_cokebag_01a`,

        ANIM_DICT = "anim@scripted@player@mission@trn_ig1_loot@male@",
        ANIM_CLIPS = {
            PED = "loot",
            CRATE = "loot_crate",
            CROWBAR = "loot_crowbar",
            BAG = "loot_can",
        }
    },
    OPEN_CASE = {
        CARRY_MODEL = `tr_prop_tr_carry_box_01a`,

        ANIM_DICT = "anim@scripted@player@mission@tunf_conv_ig1_monyplate@male@",
        ANIM_CLIPS = {
            PED = "action",
            CASE = "action_case",
            CARRY = "action_carry_box",
        }
    },
    OPEN_ELECTRICITY = {
        OLD_FUSE = `reh_prop_reh_fuse_01b`,
        FRESH_FUSE = `reh_prop_reh_fuse_01a`,

        ANIM_DICT = "anim@scripted@ulp_missions@fuse@male@",
        ANIM_CLIPS = {
            PED = "enter",
            FUSEBOX = "enter_fusebox",
        }
    },

    GUARDS = {
        MODELS = {
            `CSB_MWeather`
        },

        WEAPONS = {
            `weapon_assaultrifle`,
            `weapon_carbinerifle`,
            `weapon_combatpdw`,
            `weapon_heavypistol`,
            `weapon_smg`,
        }
    },

    SAFE = {
        ANIM_DICT = "anim@scripted@player@freemode@ig5_safe_crack@male@",

        MODEL = `h4_prop_h4_safe_01a`,

        SCALEFORM = {
            DICT = "safe_01a",
            NAME = "DIGITAL_SAFE_DISPLAY"
        }
    }
}
