while not Config.Items do
    Wait(100)
end

SvConfig = {}

SvConfig.Logs = {
     -- logs regarding open world drug farming
    pots = {
        placedPot = true,
        pickupPot = true,
        waterPot = true,
        fertilizePot = true,
        harvestCrops = true,
        removeDeadCrops = true,
        seedPlanted = true,
        webhook = ""
    },
     -- logs regarding dry racks placement & deletion
    cocaineRacks = {
        create = true,
        pickup = true,
        webhook = ""
    },
     -- logs regarding smelting furnance placement & deletion
    cocaineSmelters = {
        create = true,
        pickup = true,
        ignition = true,
        webhook = ""
    },
    meth = {
        createMethKit = true,
        removeMethKit = true,
        placeCooker = true,
        pickupCooker = true,
        startCooking = true,
        cookInsideExploit = true,
        tweakedCookUsage = true,
        stabilizeCookTemp = true,
        sabotagedCooker = true,
        placeAmmonia = true,
        pickupAmmonia = true,
        webhook = ""
    }
}

SvConfig.Pots = {
    tpCommand = {
        name = "drugZone",
        permission = "group.owner"
    },

    jointCrafting = {
        enabled = true, -- handle joint crafting in this script
        requiredAdditionalItems = {
            [Config.Items.rollingPaper] = 1
        },
    }
}

SvConfig.Cocaine = {
    dryingRacks = {
        leafDryInterval = 4, -- [[ seconds ]] | how often leaf drying ticks
        dryTimePerPercentage = 0.5, -- [[ seconds ]]
        stashSlots = 100, -- how many slots each cocaine dry rack can carry
        stashMaxWeight = 100000, -- how much weight each cocaine dry rack can carry
        modelUpdateRate = 500, -- [[ milliseconds ]] | how often after filling dry rack stash it updates the model
        placementProp = `pr_cokedry_01`, -- initial prop used for placing object down
        propThresholds = {
            {
                threshold = 90,
                prop = `pr_cokedry_03`
            },
            {
                threshold = 50,
                prop = `pr_cokedry_02`
            },
            {
                threshold = 0,
                prop = `pr_cokedry_01`
            }
        }
    },
    mixingContainer = {
        maxShakes = 10, -- how many shakes until a container is broken
        -- which items are required in order to get the output item
        itemRequired = {
            cocaine_leaf = { count = 10, requiredDurability = 100 },
            cocaine_solvent = { count = 2 },
            limestone_dust = { count = 1 }
        },

        stashSlots = 100, -- how many slots each cocaine mixing container can carry
        stashMaxWeight = 5000, -- how much weight each cocaine mixing container can carry

        rewardItem = Config.Items.cocainePaste,
        rewardCount = 2
    },
    smeltingFurnace = {
        smeltInterval = 2, -- [[ seconds ]]
        smeltTime = 1, -- [[ seconds ]]
        smeltAmount = 5, -- how many products that will be produced every smeltTime
        logRemovalChance = 5, -- how likely it is that a log will be removed after smelting
        stashSlots = 100, -- how many slots each smelter can carry
        stashMaxWeight = 100000, -- how much weight each cocaine smelter can carry
        modelUpdateRate = 500, -- [[ milliseconds ]] | how often after filling smelter stash it updates the model
        initialProp = `cocaine_smelting_01a`,
        propThresholds = {
            {
                threshold = 20,
                prop = `cocaine_smelting_01e`
            },
            {
                threshold = 10,
                prop = `cocaine_smelting_01d`
            },
            {
                threshold = 5,
                prop = `cocaine_smelting_01c`
            },
            {
                threshold = 0,
                prop = `cocaine_smelting_01b`
            }
        },
        allowedItems = {
            Config.Items.woodLog,
            Config.Items.woodPlank,
            Config.Items.cocainePowder,
            Config.Items.cocainePaste
        },
        -- what items are classified as fuel for the coke furnace
        fuelItems = {
            Config.Items.woodLog,
            Config.Items.woodPlank,
        }
    },
    brick = {
        wrapping = {
            -- what items are required in order to wrap a brick
            requiredItems = {
                [Config.Items.cocainePowder] = 20,
                [Config.Items.plastic] = 20
            },
            progress = {
                text = locale("cocaine.brick.progress.wrapping"),
                duration = 2500, -- [[ milliseconds ]]
                disable = { disableMovement = true, disableCarMovement = true },
                anim = {
                    dict = 'anim@mp_player_intuppersalsa_roll',
                    clip = 'idle_a',
                    flag = 49
                },
            }
        }
    },
    bag = {
        use = {
            -- uses `bridge.fw.setMetadata` to set player metadata
            metaChange = {
                addiction = {
                    type = "add",
                    value = 5
                }
            },
        },
        progress = {
            snorting = {
                text = locale("cocaine.bag.progress.snorting"),
                duration = 2800, -- [[ milliseconds ]]
                disable = { disableCarMovement = true },
                anim = {
                    dict = "reck@crime@snortingdrug",
                    clip = "snortingdrug",
                    flag = 49
                },
            }
        }
    }
}

SvConfig.Meth = {
    commands = {
        menu = {
            name = "methadmin",
            permission = "group.owner"
        },
        yield = {
            name = "triggermethyield",
            permission = "group.owner"
        },
        temp = {
            name = "triggermethtemperature",
            permission = "group.owner"
        }
    },
    -- how often the cooker temp ticks should occur
    cookerTempInterval = 60, -- [[ seconds ]]
    -- how often the cooker yield ticks should occur
    cookerYieldInterval = 1, -- [[ seconds ]]
    stabilizeMinigame = {
        gameOptions = { time = 30000, spawnRate = 1500, winThreshold = 0.3 },
        otherOptions = {
            animation = {
                dict = 'reck@meth@cookingmeth',
                name = 'cookingmeth',
            }
        }
    },
    explosion = {
        -- the type of explosion to occur
        type = 9,
        -- the model to change to after the explosion
        model = `pr_methcooker_02`
    },
    vehicleModels = {
        [`journey`] = true,
        [`journey2`] = true,
        [`camper`] = true,
    },
    cookerTypes = {
        meth_cooker_low = {
            model = `pr_methcooker_01`,
            cyclesRequired = 4,
            -- how many minutes between each temperature stabilize
            stabilizeTempIn = 20,
            -- how many minutes until it explodes after temp has not been stabilized
            explodeIn = 1,
            canExplode = true,
            ammoniaBurnRate = 30,
            -- how many meth per one successful cycle (cycleTimer * cookerType.cylcesRequired)
            methPerCycle = 20,
        },
        meth_cooker_mid = {
            model = `reck_meth_cooker1`,
            cyclesRequired = 3,
            stabilizeTempIn = 30,
            explodeIn = 1,
            canExplode = true,
            ammoniaBurnRate = 20,
            methPerCycle = 25,
        },
        meth_cooker_high = {
            model = `pr_methcooker_01`,
            cyclesRequired = 2,
            stabilizeTempIn = 30,
            explodeIn = 1,
            canExplode = true,
            ammoniaBurnRate = 10,
            methPerCycle = 30,
        },
    },
    coolerTypes = {
        meth_cooler_low = {
            extraMinutes = 10,
        },
        meth_cooler_mid = {
            extraMinutes = 20,
        },
        meth_cooler_high = {
            extraMinutes = 30,
        },
    },
    ammonia = {
        model = `prop_barrel_01a`,
        initialAmount = 1000,
    },
    stashes = {
        cooker = { maxSlots  = 4, maxWeight = 50000 },
        cooler = { maxSlots  = 1, maxWeight = 5000 }
    },
    methZoneRadius = 70.0,
    maxCookersPerZone = 4,
     -- how many minutes per each cycle
    cycleTimer = 10, -- [[ minutes ]]

    -- A higher weight will hurt the output more than a lower one
    -- Weights guide:
    --  0.5	  This variable barely affects the yield.
    --  1.0	  Neutral/standard weight.
    --  10	  Small mistakes in this variable cause big yield drops.
    -- Changing this could make the playing field *unfair* for existing players who haven't figured out there the *optimal* formula
    formulaWeightLimits = { min = 0.8, max = 1.2 },

    labCookedMultipler = 0.4, -- multiplier for cooking with lab increasing meth output

    tiers = {
        low = {2, 24},
        lowmid = {25, 49},
        mid = {50, 74},
        high = {75, 99},
        max = {100, 1000},
        dead = {0, 1},
    },

    -- uses `methTiers` key as effect key
    effects = {
        low = {
            stress = {
                type = "add",
                value = 5
            },
            addiction = {
                type = "add",
                value = 5
            },
            vfx = {
                effect = "DMT_flight",
                duration = 30, -- [[ seconds ]]
                looped = false
            }
        },
        lowmid = {
            stress = {
                type = "add",
                value = 5
            },
            addiction = {
                type = "add",
                value = 5
            },
            vfx = {
                effect = "DMT_flight",
                duration = 30, -- [[ seconds ]]
                looped = false
            }
        },
        mid = {
            stress = {
                type = "add",
                value = 5
            },
            addiction = {
                type = "add",
                value = 5
            },
            vfx = {
                effect = "FocusIn",
                duration = 30, -- [[ seconds ]]
                looped = false
            }
        },
        high = {
            stress = {
                type = "add",
                value = 5
            },
            addiction = {
                type = "add",
                value = 5
            },
        },
        max = {
            stress = {
                type = "add",
                value = 5
            },
            addiction = {
                type = "add",
                value = 5
            },
        },
        dead = {
            stress = {
                type = "add",
                value = 5
            },
            addiction = {
                type = "add",
                value = 5
            },
            vfx = {
                effect = "DMT_flight",
                duration = 30, -- [[ seconds ]]
                looped = false
            }
        }
    },

    lab = {
        zone = {
            points = {
                vec3(893.32135009766, -2122.080078125, 29.073),
                vec3(915.38568115234, -2123.955078125, 29.073),
                vec3(916.68206787109, -2106.2126464844, 29.073),
                vec3(895.01336669922, -2104.4953613281, 29.073),
            },
            thickness = 6.5
        }
    },

    progress = {
        attachKit = {
            text = locale("ATTACH_KIT_TITLE"),
            duration = 10000, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            canCancel = true,
            anim = {
                dict = 'reck@meth@methkitattaching',
                clip = 'methkitattaching',
            },
        },
        detachKit = {
            text = locale("DETACH_KIT_TITLE"),
            duration = 10000, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            canCancel = true,
            anim = {
                dict = 'reck@meth@methkitdetaching',
                clip = 'methkitdetaching',
            },
        },
        placeCookerProgressBar = {
            text = locale("PLACE_COOKER_TITLE"),
            duration = 5000, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            canCancel = true,
            anim = {
                dict = 'reck@meth@placingcooker',
                clip = 'placingcooker',
            },
        },
        placeAmmoniaProgressBar = {
            text = locale("PLACE_AMMONIA_TITLE"),
            duration = 5000, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            canCancel = true,
            anim = {
                dict = 'reck@meth@placebarrel',
                clip = 'placebarrel',
            },
        },
        startCookingProgressBar = {
            text = locale("START_COOKING_TITLE"),
            duration = 5000, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            anim = {
                dict = 'reck@meth@cookingmeth',
                clip = 'cookingmeth',
            },
        },
        sabotageProgressBar = {
            text = locale("SABOTAGE_TITLE"),
            duration = 5000, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            canCancel = true,
            anim = {
                dict = 'reck@meth@cookingmeth',
                clip = 'cookingmeth',
            },
        },
        pickupCookerProgressBar = {
            text = locale("PICKUP_COOKER_TITLE"),
            duration = 5000, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            canCancel = true,
            anim = {
                dict = 'reck@meth@removingcooker',
                clip = 'removingcooker',
            },
        },
        tweakBurnRatesProgressBar = {
            text = locale("TWEAK_BURN_RATES_TITLE"),
            duration = 5000, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            canCancel = true,
            anim = {
                dict = 'reck@meth@cookingmeth',
                clip = 'cookingmeth',
            },
        },
        stabilizeProgressBar = {
            text = locale("STABILIZE_TITLE"),
            duration = 5000, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            canCancel = true,
            anim = {
                dict = 'reck@meth@cookingmeth',
                clip = 'cookingmeth',
            },
        },
        attachHoseProgressBar = {
            text = locale("ATTACH_HOSE_TITLE"),
            duration = 5000, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            canCancel = true,
            anim = {
                dict = 'reck@meth@connecthose',
                clip = 'connecthose',
            },
        },
        detachHoseProgressBar = {
            text = locale("DETACH_HOSE_TITLE"),
            duration = 5000, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            canCancel = true,
            anim = {
                dict = 'reck@meth@connecthose',
                clip = 'connecthose',
            },
        },
        pickupAmmoniaProgressBar = {
            text = locale("PICKUP_AMMONIA_TITLE"),
            duration = 5000, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            canCancel = true,
            anim = {
                dict = 'reck@meth@cookingmeth',
                clip = 'cookingmeth',
            },
        },
        useItem = {
            text = locale("USING_METH"),
            duration = 2800, -- [[ milliseconds ]
            canCancel = true,
            anim = {
                dict = 'mp_suicide',
                clip = 'pill',
                flag = 50
            },
        },
        labUnlocking = {
            text = locale("UNLOCKING"),
            duration = 3500, -- [[ milliseconds ]
            disable = {disableMovement = true, disableCarMovement = true},
            canCancel = true,
            anim = {
                dict = "anim@heists@keycard@",
                clip = "exit",
                flag = 49
            },
        }
    },

    -- Zones where meth kits are allowed to be attached to vehicles and where cooking can be started
    allowZones = {
        {
            points = {
                vector3(33.0, 2498.0, 87.0),
                vector3(67.0, 2597.0, 87.0),
                vector3(24.0, 2754.0, 87.0),
                vector3(-59.0, 3181.0, 87.0),
                vector3(96.0, 3410.0, 87.0),
                vector3(359.0, 3626.0, 87.0),
                vector3(1432.0, 3946.0, 87.0),
                vector3(2401.0, 4230.0, 87.0),
                vector3(2883.0, 3980.0, 87.0),
                vector3(2977.0, 3420.0, 87.0),
                vector3(2516.0, 2770.0, 87.0),
            },
        },
        {
            points = {
                vector3(-961.0, 5271.0, 100.0),
                vector3(-1106.0, 6399.0, 100.0),
                vector3(30.0, 7230.0, 100.0),
                vector3(551.0, 6722.0, 100.0),
                vector3(602.0, 6498.0, 100.0),
                vector3(368.0, 6310.0, 100.0),
            },
        },
        {
            points = {
                vector3(1606.0, 5098.0, 116.0),
                vector3(2317.0, 5324.0, 116.0),
                vector3(2418.0, 5175.0, 116.0),
                vector3(2640.0, 4814.0, 116.0),
                vector3(2988.0, 4513.0, 116.0),
                vector3(2909.0, 4300.0, 116.0),
                vector3(2691.0, 4014.0, 116.0),
                vector3(2426.0, 4044.0, 116.0),
                vector3(2146.0, 4080.0, 116.0),
            },
        },
    },
}
