Config = {}

Config.InventorySystem = 'auto' -- auto, ox, qb, quasar, core, codem, tgiann, origen
Config.TargetSystem = 'auto'    -- auto, ox, qb

Config.PlacementType = 'mouse'  -- mouse (new one), player (old one)

Config.OnlyAdminsCanPickUpEquipment = {
    enable = false,
    adminGroups = { 'admin', 'best' }
}

Config.DebugPrints = false

Config.UseDistanceSpawning = true -- if true script will despawn or spawn shop ped depend if you are near him

Config.CuttingDrugGive = {
    cokeLeafs = 5, -- you will receive 5 coke leafs after cutting coke pot
    weedBuds = 6,  -- you will receive 6 weed buds after cutting weed pot
}

Config.HighQualityDrugFertilizerLevel = 100 -- minimum percentage of fertilizer to get high quality weed/coke when cutting

Config.Bonus = {
    Water = 50,      -- one hydration gives you +50%
    Fertilizer = 50 -- one fertulizer gives you +100%
}

Config.GrowthTimePerStage = { -- how many points each stage level needs to upgrade (watch Config.PowerMultiplier)
    [1] = 10.0,               -- 10 points
    [2] = 20.0,
    [3] = 30.0,
    [4] = 40.0,
    [5] = 50.0,
    [6] = 50.0,
    [7] = 50.0,
}

Config.HydrationDecayRate = 1.0  -- -1% per minute
Config.MinHydrationForGrowth = 1 -- requires atleast 1% of hydration to grow

Config.PowerMultiplier = {
    [0] = 1.0, -- without lamp and fan plant pot grows with 1 points per minute
    [1] = 1.5, -- with one lamp or one fan nearby plant pot grows with 1.5 points  per minute
    [2] = 2.0, -- with atleast one lamp and one fan nearby plant pot grows with 2 points per minute
}

Config.MaximumLampAndFanDistanceFromPot = 3.0
Config.EnableForcedZones = true
Config.ForcedZones = {
    {
        coords = vec3(-1455.8318, 3923.1694, -19.6191), -- weed laboratory
        radius = 20.0,
        forceFan = true,                                -- plant pots in this area will have automatically full level of fan
        forceLamp = true,                               -- plant pots in this area will have automatically full level of lamps
    },
    {
        coords = vec3(-1064.5596, 3742.0662, -26.3797), -- coke laboratory
        radius = 20.0,
        forceFan = true,                                -- plant pots in this area will have automatically full level of fan
        forceLamp = true,                               -- plant pots in this area will have automatically full level of lamps
    },
    {
        coords = vec3(-1424.1506, 3874.5498, 73.0723), -- meth laboratory
        radius = 20.0,
        forceFan = true,                               -- plant pots in this area will have automatically full level of fan
        forceLamp = true,                              -- plant pots in this area will have automatically full level of lamps
    },
}

Config.DryingRack = {
    MaxCapacity = 20,
    DryableItems = {
        ['weed'] = {
            resultItem = 'dried_weed',
            duration = 30, -- 30 minutes to dry
        },
        ['high_quality_weed'] = {
            resultItem = 'dried_high_quality_weed',
            duration = 45,
        },
        ['coke_leaf'] = {
            resultItem = 'dried_coke_leaf',
            duration = 45,
        },
        ['high_quality_coke_leaf'] = {
            resultItem = 'dried_high_quality_coke_leaf',
            duration = 60,
        },
    }
}

Config.BrickPress = {
    { item = 'dried_weed',                     result = 'weed_brick' },
    { item = 'dried_high_quality_weed',        result = 'high_quality_weed_brick' },

    { item = 'dried_coke',                     result = 'coke_brick' },
    { item = 'dried_high_quality_coke',        result = 'high_quality_coke_brick' },

    { item = 'cooked_dried_coke',              result = 'cooked_coke_brick' },
    { item = 'cooked_dried_high_quality_coke', result = 'cooked_high_quality_coke_brick' },
}

Config.PackageableItems = { -- you will receive 'packaged_DRUGNAME' after packaged
    { name = 'weed' },
    { name = 'high_quality_weed' },
    { name = 'dried_weed' },
    { name = 'dried_high_quality_weed' },

    { name = 'coke' },
    { name = 'high_quality_coke' },
    { name = 'dried_coke' },
    { name = 'dried_high_quality_coke' },

    { name = 'cooked_coke' },
    { name = 'cooked_high_quality_coke' },
    { name = 'cooked_dried_coke' },
    { name = 'cooked_dried_high_quality_coke' },

    { name = 'gingeritis_weed' },
    { name = 'energizing_dried_weed' },

    { name = 'default_meth' },

    { name = 'baggy' } -- please do not change it
}

Config.MixerTime = 10 -- 10 seconds
Config.MixerRecipes = {
    {
        baseDrug = 'weed',
        baseDrugProp = `dl_weetbud_green_01`,
        ingredient = 'banana',
        ingredientProp = `v_res_tre_banana`,
        resultDrug = 'gingeritis_weed',
    },
    {
        baseDrug = 'dried_weed',
        baseDrugProp = `dl_bud_green_01`,
        ingredient = 'ecola',
        ingredientProp = `prop_ecola_can`,
        resultDrug = 'energizing_dried_weed',
    },
}

Config.CauldronTime = 10 -- 10 seconds
Config.Cauldron = {
    {
        baseDrug = 'coke_leaf',
        gasoline = 'gasoline',
        gasolineProp = `prop_oilcan_02a`,
        acetone = 'acetone',
        acetoneProp = `xm3_prop_xm3_lsd_bottle_03a`,
        resultDrug = 'coke',
        resultDivider = 2, -- you will receive 5 coke out of 10 coke leaf
    },
    {
        baseDrug = 'high_quality_coke_leaf',
        gasoline = 'gasoline',
        gasolineProp = `prop_oilcan_02a`,
        acetone = 'acetone',
        acetoneProp = `xm3_prop_xm3_lsd_bottle_03a`,
        resultDrug = 'high_quality_coke',
        resultDivider = 2,
    },
    {
        baseDrug = 'dried_coke_leaf',
        gasoline = 'gasoline',
        gasolineProp = `prop_oilcan_02a`,
        acetone = 'acetone',
        acetoneProp = `xm3_prop_xm3_lsd_bottle_03a`,
        resultDrug = 'dried_coke',
        resultDivider = 2,
    },
    {
        baseDrug = 'dried_high_quality_coke_leaf',
        gasoline = 'gasoline',
        gasolineProp = `prop_oilcan_02a`,
        acetone = 'acetone',
        acetoneProp = `xm3_prop_xm3_lsd_bottle_03a`,
        resultDrug = 'dried_high_quality_coke',
        resultDivider = 2,
    },
}

Config.DrugOvenTime = 10 -- 10 seconds
Config.DrugOvenRecipes = {
    { item = 'coke',                    resultDrug = 'cooked_coke',                    amountToGive = 10 },
    { item = 'high_quality_coke',       resultDrug = 'cooked_high_quality_coke',       amountToGive = 10 },
    { item = 'dried_coke',              resultDrug = 'cooked_dried_coke',              amountToGive = 10 },
    { item = 'dried_high_quality_coke', resultDrug = 'cooked_dried_high_quality_coke', amountToGive = 10 },

    { item = 'liquid_meth',             resultDrug = 'default_meth',                   amountToGive = 10 },
}

Config.ChemistryStationTime = 10
Config.ChemistryStation = {
    {
        pseudo = 'pills',
        pseudoProp = `xm3_prop_xm3_pill_01a`,
        acetone = 'acetone',
        acetoneProp = `xm3_prop_xm3_lsd_bottle_03a`,
        phosphorus = 'phosphorus',
        phosphorusProp = `p_cs_script_bottle_s`,
        resultDrug = 'liquid_meth',
    }
}

Config.CuttingMiniGame = { -- Settings for cutting minigame for coke/weed
    MovementRadius = 4.5,
    KeySensitivity = 0.05,
    ScrollSensitivity = 0.02,
    CutDistance = 0.2
}

Config.ItemsForMiniGames = {                                 -- you can add additional required items for each minigame
    { minigame = 'DrugOven',         items = { 'hammer' } }, -- DO NOT CHANGE 'minigame' you can add as many items as you want or leave it blank
    { minigame = 'ChemistryStation', items = {} },
    { minigame = 'PackagingStation', items = {} },
    { minigame = 'Mixer',            items = {} },
    { minigame = 'Cauldron',         items = {} },
    { minigame = 'BrickPress',       items = {} },
}

Config.DrugEffects = {
    -- {
    --     item = 'dried_weed',
    --     effect = {
    --         chance = 100, -- chance for getting the effect
    --         duration = 400, -- duration for effect (in seconds)
    --         type = 'DaxTrip02', -- effect, https://wiki.rage.mp/wiki/Timecycle_Modifiers
    --         movementSpeed = 0.90,
    --         exploseChance = 5, in percentage (5%)
    --         animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
    --         animClip = 'idle_c',
    --         animTime = 14 -- animation time in seconds
    --     }
    -- },

    -- WEED
    {
        item = 'weed',
        effect = {
            chance = 100,
            duration = 200,
            type = 'DaxTrip01',
            movementSpeed = 0.95,
            exploseChance = 15,
            animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
            animClip = 'idle_c',
            animTime = 14
        }
    },
    {
        item = 'packaged_weed',
        effect = {
            chance = 100,
            duration = 200,
            type = 'DaxTrip01',
            movementSpeed = 0.95,
            exploseChance = 15,
            animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
            animClip = 'idle_c',
            animTime = 14
        }
    },
    {
        item = 'high_quality_weed',
        effect = {
            chance = 100,
            duration = 250,
            type = 'DaxTrip01',
            movementSpeed = 0.90,
            exploseChance = 12,
            animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
            animClip = 'idle_c',
            animTime = 14
        }
    },
    {
        item = 'packaged_high_quality_weed',
        effect = {
            chance = 100,
            duration = 250,
            type = 'DaxTrip01',
            movementSpeed = 0.90,
            exploseChance = 12,
            animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
            animClip = 'idle_c',
            animTime = 14
        }
    },
    {
        item = 'dried_weed',
        effect = {
            chance = 100,
            duration = 400,
            type = 'DaxTrip02',
            movementSpeed = 0.90,
            exploseChance = 5,
            animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
            animClip = 'idle_c',
            animTime = 14
        }
    },
    {
        item = 'packaged_dried_weed',
        effect = {
            chance = 100,
            duration = 400,
            type = 'DaxTrip02',
            movementSpeed = 0.90,
            exploseChance = 5,
            animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
            animClip = 'idle_c',
            animTime = 14
        }
    },
    {
        item = 'dried_high_quality_weed',
        effect = {
            chance = 100,
            duration = 600,
            type = 'DaxTrip02',
            movementSpeed = 0.85,
            exploseChance = 2,
            animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
            animClip = 'idle_c',
            animTime = 14
        }
    },
    {
        item = 'packaged_dried_high_quality_weed',
        effect = {
            chance = 100,
            duration = 600,
            type = 'DaxTrip02',
            movementSpeed = 0.85,
            exploseChance = 2,
            animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
            animClip = 'idle_c',
            animTime = 14
        }
    },
    {
        item = 'energizing_dried_weed',
        effect = {
            chance = 100,
            duration = 300,
            type = 'PlayerSwitchPulse',
            movementSpeed = 1.05,
            exploseChance = 15,
            animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
            animClip = 'idle_c',
            animTime = 14
        }
    },
    {
        item = 'packaged_energizing_dried_weed',
        effect = {
            chance = 100,
            duration = 300,
            type = 'PlayerSwitchPulse',
            movementSpeed = 1.05,
            exploseChance = 15,
            animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
            animClip = 'idle_c',
            animTime = 14
        }
    },
    {
        item = 'gingeritis_weed',
        effect = {
            chance = 100,
            duration = 450,
            type = 'DaxTrip02',
            movementSpeed = 0.95,
            exploseChance = 8,
            animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
            animClip = 'idle_c',
            animTime = 14
        }
    },
    {
        item = 'packaged_gingeritis_weed',
        effect = {
            chance = 100,
            duration = 450,
            type = 'DaxTrip02',
            movementSpeed = 0.95,
            exploseChance = 8,
            animDict = 'amb@code_human_in_car_mp_actions@first_person@smoke@std@ps@base',
            animClip = 'idle_c',
            animTime = 14
        }
    },

    -- COKE
    {
        item = 'coke',
        effect = {
            chance = 100,
            duration = 40,
            type = 'Drunk',
            movementSpeed = 1.10,
            exploseChance = 60,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'packaged_coke',
        effect = {
            chance = 100,
            duration = 40,
            type = 'Drunk',
            movementSpeed = 1.10,
            exploseChance = 60,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'high_quality_coke',
        effect = {
            chance = 100,
            duration = 50,
            type = 'Drunk',
            movementSpeed = 1.15,
            exploseChance = 55,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'packaged_high_quality_coke',
        effect = {
            chance = 100,
            duration = 50,
            type = 'Drunk',
            movementSpeed = 1.15,
            exploseChance = 55,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'dried_coke',
        effect = {
            chance = 100,
            duration = 180,
            type = 'PlayerSwitchPulse',
            movementSpeed = 1.15,
            exploseChance = 20,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'packaged_dried_coke',
        effect = {
            chance = 100,
            duration = 180,
            type = 'PlayerSwitchPulse',
            movementSpeed = 1.15,
            exploseChance = 20,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'dried_high_quality_coke',
        effect = {
            chance = 100,
            duration = 220,
            type = 'PlayerSwitchPulse',
            movementSpeed = 1.20,
            exploseChance = 15,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'packaged_dried_high_quality_coke',
        effect = {
            chance = 100,
            duration = 220,
            type = 'PlayerSwitchPulse',
            movementSpeed = 1.20,
            exploseChance = 15,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'cooked_coke',
        effect = {
            chance = 100,
            duration = 90,
            type = 'Drunk',
            movementSpeed = 1.20,
            exploseChance = 40,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'packaged_cooked_coke',
        effect = {
            chance = 100,
            duration = 90,
            type = 'Drunk',
            movementSpeed = 1.20,
            exploseChance = 40,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'cooked_high_quality_coke',
        effect = {
            chance = 100,
            duration = 120,
            type = 'Drunk',
            movementSpeed = 1.25,
            exploseChance = 35,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'packaged_cooked_high_quality_coke',
        effect = {
            chance = 100,
            duration = 120,
            type = 'Drunk',
            movementSpeed = 1.25,
            exploseChance = 35,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'cooked_dried_coke',
        effect = {
            chance = 100,
            duration = 280,
            type = 'PlayerSwitchPulse',
            movementSpeed = 1.25,
            exploseChance = 10,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'packaged_cooked_dried_coke',
        effect = {
            chance = 100,
            duration = 280,
            type = 'PlayerSwitchPulse',
            movementSpeed = 1.25,
            exploseChance = 10,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'cooked_dried_high_quality_coke',
        effect = {
            chance = 100,
            duration = 360,
            type = 'PlayerSwitchPulse',
            movementSpeed = 1.30,
            exploseChance = 5,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },
    {
        item = 'packaged_cooked_dried_high_quality_coke',
        effect = {
            chance = 100,
            duration = 360,
            type = 'PlayerSwitchPulse',
            movementSpeed = 1.30,
            exploseChance = 5,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 3
        }
    },

    -- METH
    {
        item = 'default_meth',
        effect = {
            chance = 100,
            duration = 700,
            type = 'MP_Arena_theme_atlantis',
            movementSpeed = 1.40,
            exploseChance = 45,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 6
        }
    },
    {
        item = 'packaged_default_meth',
        effect = {
            chance = 100,
            duration = 700,
            type = 'MP_Arena_theme_atlantis',
            movementSpeed = 1.40,
            exploseChance = 45,
            animDict = 'misstrevor3leadinout',
            animClip = 'trv_dri_ext_meth_leadin',
            animTime = 6
        }
    },
    {
        item = 'liquid_meth',
        effect = {
            chance = 100,
            duration = 900,
            type = 'DRUG_gas_huffin',
            movementSpeed = 1.35,
            exploseChance = 60,
            animDict = 'mp_suicide',
            animClip = 'pill',
            animTime = 3
        }
    }
}

Config.DrugEffectExplosion = { -- native: https://docs.fivem.net/natives/?_0xE3AD2BDBAEE269AC
    ExplosionType = 0,
    ExplosionScale = 1.0,
    IsAudible = true,
    IsInvisible = false,
    CameraShake = true,
}

Config.DrugEffectClear = {
    CommandName = 'cleardrugeffect'
}

Config.DisabledAreas = { -- disable some area from placing props
    { coords = vec3(-793.5667, 327.4127, 230.6369), radius = 2.0 }
}

Config.Laboratories = {
    Weed = {
        LaboratoryCoords = vec3(-1455.8318, 3923.1694, -19.6191)
    },
    Coke = {
        LaboratoryCoords = vec3(-1064.5596, 3742.0662, -26.3797)
    },
    Meth = {
        LaboratoryCoords = vec3(-1424.1506, 3874.5498, 73.0723)
    }
}

Config.Knocking = {
    Time = 3, -- 3 seconds
    AnimDict = 'timetable@jimmy@doorknock@',
    AnimClip = 'knockdoor_idle',
}

Config.Blips = {
    Enabled = true,

    ForSale = {
        Weed = {
            Label = 'Weed Lab for sale #%s',
            Sprite = 496,
            Color = 52, -- Green
            Scale = 0.8,
            Display = 4,
            ShortRange = true,
        },
        Coke = {
            Label = 'Coke Lab for sale #%s',
            Sprite = 501,
            Color = 64, -- Orange
            Scale = 0.8,
            Display = 4,
            ShortRange = true,
        },
        Meth = {
            Label = 'Meth Lab for sale #%s',
            Sprite = 499,
            Color = 63, -- Blue
            Scale = 0.8,
            Display = 4,
            ShortRange = true,
        }
    },

    Owned = {
        Weed = {
            Label = 'Your Weed Lab #%s',
            Sprite = 496,
            Color = 69, -- Darker Green
            Scale = 0.9,
            Display = 4,
            ShortRange = true,
        },
        Coke = {
            Label = 'Your Coke Lab #%s',
            Sprite = 501,
            Color = 47, -- Darker Orange/Yellow
            Scale = 0.9,
            Display = 4,
            ShortRange = true,
        },
        Meth = {
            Label = 'Your Meth Lab #%s',
            Sprite = 499,
            Color = 3, -- Darker Blue
            Scale = 0.9,
            Display = 4,
            ShortRange = true,
        }
    },

    Public = {
        Weed = {
            Label = 'Public Weed Lab #%s',
            Sprite = 496,
            Color = 2, -- Lighter Green
            Scale = 0.8,
            Display = 4,
            ShortRange = true,
        },
        Coke = {
            Label = 'Public Coke Labe #%s',
            Sprite = 501,
            Color = 81, -- Yellow
            Scale = 0.8,
            Display = 4,
            ShortRange = true,
        },
        Meth = {
            Label = 'Public Meth Lab #%s',
            Sprite = 499,
            Color = 26, -- Lighter Blue
            Scale = 0.8,
            Display = 4,
            ShortRange = true,
        }
    }
}

Config.Labs = {
    PrimaryOwnerOnlyCanGiveKeys = true, -- if true, only player that bought a LAB can give keys to others, if false everyone who has keys can give keys to another
    LabCreateCommand = 'lab_create',
    LabDeleteCommand = 'lab_delete',
    LabKeysCommand = 'lab_givekeys',
    LabRevokeKeysCommand = 'lab_delkeys',
}

Config.Camera = {
    InvisibleLocally = false,
    Invicible = false,
    DisableCollisions = true,
    Freezed = false,
}

Config.Shops = {
    {
        coords = vec4(65.3302, -1923.4370, 21.4997, 324.0653),
        pedModel = 'g_m_y_salvagoon_01',
        label = 'Plant Dealer',
        icon = 'fas fa-cannabis',
        items = {
            { name = 'weed_seed',      label = 'Weed Seed',      price = 50 },
            { name = 'coke_seed',      label = 'Coke Seed',      price = 50 },
            { name = 'fertilizer',     label = 'Fertilizer',     price = 100 },
            { name = 'baggy',          label = 'Empty Baggy',    price = 2 },
            { name = 'plant_pot',      label = 'Plant Pot',      price = 250 },
            { name = 'default_soil',   label = 'Soil',           price = 50 },
            { name = 'watering_can',   label = 'Watering Can',   price = 20 },
            { name = 'plant_trimmers', label = 'Plant Trimmers', price = 10 },
            { name = 'banana',         label = 'Banana',         price = 5 },
            { name = 'ecola',          label = 'E-Cola',         price = 5 },
        }
    },
    {
        coords = vec4(558.6177, -1563.3618, 29.2822, 351.3123),
        pedModel = 'g_m_y_salvagoon_01',
        label = 'Equipment Dealer',
        icon = 'fas fa-cannabis',
        items = {
            { name = 'drug_mixer',          label = 'Mixer',             price = 500 },
            { name = 'chemistry_station',   label = 'Chemistry Station', price = 700 },
            { name = 'packaging_station',   label = 'Packaging Station', price = 400 },
            { name = 'drying_rack',         label = 'Drying Rack',       price = 450 },
            { name = 'default_brick_press', label = 'Brick Press',       price = 550 },
            { name = 'drug_cauldron',       label = 'Cauldron',          price = 650 },
            { name = 'drug_oven',           label = 'Drug Oven',         price = 850 },
            { name = 'default_lamp',        label = 'Lamp',              price = 100 },
            { name = 'default_fan',         label = 'Fan',               price = 100 },
        }
    },
    {
        coords = vec4(-762.7604, -633.5540, 30.2763, 227.1456),
        pedModel = 'g_m_y_salvagoon_01',
        label = 'Meth Dealer',
        icon = 'fas fa-cannabis',
        items = {
            { name = 'phosphorus', label = 'Phosphorus', price = 100 },
            { name = 'pills',      label = 'Pills',      price = 70 },
            { name = 'acetone',    label = 'Acetone',    price = 80 },
            { name = 'hammer',     label = 'Hammer',     price = 30 },
            { name = 'gasoline',   label = 'Gasoline',   price = 40 },
        }
    },
}

Config.Translations = {
    Interact = 'Interact',
    Delete = 'Delete',
    TakingOut = 'Taking out...',
    Title = 'Drug System',
    DontHaveDirt = 'You do not have soil',
    CutWeed = 'Cut Weed Buds',
    CutCoke = 'Cut Coke Leafs',
    DryingRack = 'Open Drying Rack Menu',
    BrickPress = 'Open Brick Press Menu',
    PackagingStation = 'Open Packaging Station Menu',
    DrugMixer = 'Open Mixer Menu',
    DrugCauldron = 'Open Cauldron Menu',
    DrugOven = 'Open Drug Oven',
    ChemistryStation = 'Open Chemistry Station',
    DontHaveItem = 'You do not have required item',
    CuttingMovement = '[SCROLL] to adjust height | [E] to cut',
    DontHaveSoil = 'You do not have soil',
    PackagingStationError = 'This packaging station does not exists anymore...',
    DrugMixerError = 'This drug mixer does not exists anymore...',
    DrugOvenError = 'This drug oven does not exists anymore...',
    ChemistryStationError = 'This chemistry station does not exists anymore...',
    BrickPressError = 'This Brick Press does not exists anymore...',
    BrickPressError2 = 'Wrong weed name...',
    DrugCauldronError = 'This Drug Cauldron does not exists anymore...',
    WeedError = 'This Pot Plant does not exists anymore...',
    WeedError2 = 'This Pot is already planted',
    ItemError = 'You do not have required item to do that!',
    Processing = 'Processing',
    DisabledArea = 'You are in disabled area. Cannot do that here!',
    ScrollDown = 'Press [Scroll Down] to interact',
    PressEnter = 'Press [Enter] to interact',
    PressEnterAndX = 'Press [Enter] to interact, [X] to cancel, [SCROLL] to adjust heading',

    LabHelpText = 'Setup a new laboratory',
    LabHelpTextPrice = 'Price',
    LabHelpTextPrice2 = '1000',
    LabHelpTextType = 'Type',
    LabHelpTextType2 = 'weed/coke/meth',
    LabHelpTextRestricted = 'Restricted',
    LabHelpTextRestricted2 = 'true/false',
    EnterHideOut = 'Enter #%d lab',
    ExitHideOut = 'Exit lab',
    Knock = 'Knock at #%d lab',
    BuyLaboratory = 'Buy #%d laboratory for: $%s',
    DontHaveMoney = 'You do not have enough money for that!',
    BoughtLaboratory = 'You bought a new lab!',
    Knocking = 'Knocking...',
    KnockingNotification = 'Someone is knocking to your laboratory: #%s',
    LabCreated = 'You created a new lab!',
    LabHelpDelText = 'Delete a laboratory',
    LabHelpIdDelText = 'Lab ID',
    LabHelpIdDelText2 = '20',
    LabDeleted = 'You just deleted a lab: #%s',
    NoSuchLab = 'There is no laboratory with this ID: #%s',
    DoorsLocked = 'Laboratory #%s doors locked',
    DoorsUnlocked = 'Laboratory #%s doors unlocked',
    LockDoor = 'Close doors #%s',
    UnlockDoor = 'Open doors #%s',
    LabIsLocked = 'This lab is locked',
    NotOwner = 'You are NOT the owner of this laboratory',
    PlayerNotFound = "This player ID is not online!",
    LabNotFound = "This lab does not exists",
    TargetAlreadyOwner = "This player is already a owner of this lab",
    NotPrimaryOwner = "Only original owner can give keys",
    GiveKeysSuccess = "You gave keys to lab: #%s for: %s",
    ReceiveKeysSuccess = "You received a keys to #%s lab from: %s",

    LabHelpKeysText = 'Give a keys to player to your lab',
    LabHelpKeysPlayerIdText = 'Player ID',
    LabHelpKeysPlayerIdText2 = '11',
    LabCommandError = 'Lab type should be weed/coke/meth',

    LabHelpRevokedKeysText = 'Revoke keys from player to your lab',

    Canceled = 'Canceled!',

    ClearDrugEffect = 'Clear someones drug effect',
    ClearDrugEffectPlayerId = 'Player ID',
    ClearDrugEffectPlayerId2 = '2',
    NoPermission = 'You do not have permissions to do that!',
    ClearedDrugEffect = 'Your drug effect has been cleared!',

    Open = 'Open ',
    SuccessfullyBought = 'Successfully Bought: %s ',

    DoesntHaveKeys = 'This player does not have keys to this lab',
    CannotRemoveThisPlayerKeys = 'You cannot remove keys from this player',
    RevokeLabKeySuccess = 'You revoked keys to lab: #%d player: %d',
    RevokeLabKeySuccess2 = 'Your keys to lab: #%d has been revoked by: %d',
}

Config.GrowingInterval = 60000 -- do not change it unless you know what are you doing
Config.MoreExports = false     -- if you want more exports enable this option
