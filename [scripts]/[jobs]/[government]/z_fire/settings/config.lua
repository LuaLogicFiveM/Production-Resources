---@documentation: Please refer to our resource documentation for assistance with configuring this resource: docs.zeadevelopment.com.

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section cfg
cfg = cfg or {}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section smoulderTime
cfg.smoulderTime = 50 ---@comment: In seconds, the duration during which fires continue to smoulder after being extinguished. | This value will not exceed 200 |

---@section pedsFlee
cfg.pedsFlee = true ---@comment: if true AI peds will flee from fires. It is advised that this is set to true.

---@section ignoreResourceIntegration
cfg.ignoreResourceIntegration = false ---@comment: only set this to true if advised to by our support team. This will ignore automatic integration.

---@section ignoreResourceIntegration
cfg.ignoreSmokeInIncidents = false ---@comment: If true this will ignore smoke particles to class an ongoing incident as still in progress. This can be useful when you have no ability to disperse smokes.
------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section commands
---@description: This table facilitates the customization of commands utilized by the resource.
cfg.commands = {
    ---@comment: % Create Fire %
    ['createFire'] = {
        command = 'createfire',
        description = 'Create a new fire.',
        parameters = {
            ['size'] = {
                percentages = {
                    ['small'] = 25, ---@comment: Percentage Value / 25% of Max Flame
                    ['medium'] = 50, ---@comment: Percentage Value / 50% of Max Flame
                    ['large'] = 75, ---@comment: Percentage Value / 75% of Max Flame
                    ['extra large'] = 100 ---@comment: Percentage Value / 100% of Max Flame
                }
            },
        },
    },
    ---@comment: % Create Fire Manual %
    ['createFireManual'] = {
        command = 'createfire_cmd',
        description = 'Create a new fire through a command line.',
        parameters = {
            { id = "behaviourType", name = "Behaviour Type", help = "| vehicle | grass | prop | interior |" },
            { id = "effectType",    name = "Effect Type",    help = "| normal | normal2 | normal3 | normal4 | veh1 | grass1 | grass2 | chemical | electrical |" },
            { id = "burnoutTime",   name = "Burnout Time",   help = "| 0 - 1000 |" },
            { id = "spreadRadius",  name = "Spread Radius",  help = "| small | medium | large | extra large |" },
        }
    },
    ---@comment: % Delete Fire %
    ['deleteFire'] = {
        command = 'deletefire',
        description = 'Delete a existing fire.',
        parameters = {
            ['range'] = {
                name = "Range",
                help = "| 0 - 100 |"
            }
        },
    },
    ---@comment: % Create Smoke %
    ['createSmoke'] = {
        command = 'createsmoke',
        description = 'Create Smoke.',
    },
    ---@comment: % Delete Smoke %
    ['deleteSmoke'] = {
        command = 'deletesmoke',
        description = 'Delete a existing smoke.',
        parameters = {
            ['range'] = {
                name = "Range",
                help = "| 0 - 100 |"
            }
        },
    },
    ---@comment: % Book Duty %
    ['bookDuty'] = {
        command = 'bookduty',
        description = 'Set your duty',
    },
    ---@comment: % Particle Manager %
    ['particleManager'] = {
        command = 'particlemanager',
        description = 'Open the Particle Manager.',
    },
    ---@comment: % Force Incident %
    ['forceIncident'] = {
        command = 'force:incident',
        description = 'Force a new incident',
        parameters = {
            ['department'] = {
                percentages = {
                    name = "Department",
                    help = "| The departments abbreivation |"
                }
            }
        }

    },
    ---@comment: % Clear Incident %
    ['clearIncident'] = {
        command = 'clear:incident',
        description = 'Clear current incident',
        parameters = {
            ['department'] = {
                percentages = {
                    name = "Department",
                    help = "| The departments abbreivation |"
                }
            }
        }
    },
    ---@comment: % Incident Configurator %
    ['incidentConfigurator'] = {
        command = 'incidentconfigurator',
        description = 'Open the Incident Configurator.',
    },
    ---@comment: % Triggers an incident using an incidents ID %
    ['triggerIncident'] = {
        command = 'trigger:incident',
        description = 'Trigger an incident using an incidents ID.',
        parameters = {
            { id = "incidentID", name = "Incident ID", help = "| The ID of the incident you want to trigger |" }
        }
    },
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section permissions
---@description: This table provides support for integration with a variety of frameworks.
cfg.permissions = {
    ---@comment: % /createFire ~ /createSmoke %
    ['particle_creation'] = {
        ---@section: QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },

                permissionCheck = false,
                permissions = { 'admin' }
            }
        },
        ---@section: ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = { 'safd' }
            }
        },
        ---@section: QBX
        ['QBX'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },
            }
        },
        ---@section: TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },
            }
        },
        ---@section: Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'fire'
        },
    },
    ---@comment: % /deleteFire ~ /deleteSmoke %
    ['particle_deletion'] = {
        ---@section: QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },

                permissionCheck = false,
                permissions = { 'admin' }
            }
        },
        ---@section: ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = { 'safd' }
            }
        },
        ---@section: QBX
        ['QBX'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },
            }
        },
        ---@section: TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },
            }
        },
        ---@section: Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'fire'
        },
    },
    ---@comment: % /bookDuty ~ Receive incident notfications %
    ['book_duty'] = {
        ---@section: QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },

                permissionCheck = false,
                permissions = { 'admin' }
            }
        },
        ---@section: ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = { 'safd' }
            }
        },
        ---@section: QBX
        ['QBX'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },
            }
        },
        ---@section: TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },
            }
        },
        ---@section: Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'fire'
        },
    },
    ---@comment: % /particlemanager ~ Permission that binds opening the particle manager %
    ['particle_manager'] = {
        ---@section: QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },

                permissionCheck = false,
                permissions = { 'admin' }
            }
        },
        ---@section: ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = { 'safd' }
            }
        },
        ---@section: QBX
        ['QBX'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },
            }
        },
        ---@section: TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },
            }
        },
        ---@section: Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'fire'
        },
    },
    ---@comment: % Permission that binds teleporting to particles displayed in particle manager %
    ['teleport_particles'] = {
        ---@section: QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },

                permissionCheck = false,
                permissions = { 'admin' }
            }
        },
        ---@section: ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = { 'safd' }
            }
        },
        ---@section: QBX
        ['QBX'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },
            }
        },
        ---@section: TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'fire' },
            }
        },
        ---@section: Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'fire'
        },
    },
    ---@comment: % Permission that binds the use of the incident configurator and all of its functions.%
    ['incident_configurator'] = {
        ---@section: QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'dev' },

                permissionCheck = false,
                permissions = { 'dev' }
            }
        },
        ---@section: ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = { 'safd' }
            }
        },
        ---@section: QBX
        ['QBX'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'dev' },
            }
        },
        ---@section: TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'dev' },
            }
        },
        ---@section: Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'dev'
        },
    },
    ---@comment: % Permission that binds various developer commands %
    ['server_developer'] = {
        ---@section: QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'dev' },

                permissionCheck = false,
                permissions = { 'dev' }
            }
        },
        ---@section: ESX
        ['ESX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = { 'safd' }
            }
        },
        ---@section: QBX
        ['QBX'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'dev' },
            }
        },
        ---@section: TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'dev' },
            }
        },
        ---@section: Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'dev'
        },
    },

    ---@comment: % Permission that allow for incident maniupulation %
    ['incident_manager'] = {
        ---@section: QBCore
        ['QBCore'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'dev' },

                permissionCheck = false,
                permissions = { 'dev' }
            }
        },
        ---@section: ESX
        ['ESX'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'dev' }
            }
        },
        ---@section: QBX
        ['QBX'] = {
            enabled = true,

            usePermissions = {
                jobCheck = true,
                jobs = { 'safd' },
            }
        },
        ---@section: TMC
        ['TMC'] = {
            enabled = false,

            usePermissions = {
                jobCheck = false,
                jobs = { 'dev' },
            }
        },
        ---@section: Ace Permisions
        ['Ace'] = {
            enabled = false,
            usePermission = 'dev'
        },
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section behaviourTypes
---@description: Behavior Types enable users to generate fires that exhibit unique behaviors from one another.
cfg.behaviourTypes = {
    ---@comment: % Vehicle Fires %
    ['vehicle'] = {
        maxSpread = 25, ---@comment: The maximum amount of flames that this type of behavior can produce.
        spreadInterval = 10, ---@comment: The interval between the spreading of flames, measured in seconds.
        canSpreadToGrass = true, ---@comment: true | false

        explodeChance = { Min = 1, Max = 15 }, ---@comment: The likelihood of the vehicle exploding is determined by randomly selecting a number between the minimum and maximum values, and then comparing it.
        reignitionChance = { Min = 1, Max = 25 }, ---@comment: The chance of a flame reigniting after being extinguished, determined by selecting a random number between the minimum and maximum values and comparing it.

        ---@comment: https://docs.altv.mp/gta/articles/vehicle/classes.html
        blacklistedClasses = {
            'Trains',
            'Helicopters',
            'Cycles'
        }
    },
    ---@comment: % Grass Fires %
    ['grass'] = {
        maxSpread = 25, ---@comment: The maximum amount of flames that this type of behavior can produce.
        spreadInterval = 15, ---@comment: The interval between the spreading of flames, measured in seconds.

        reignitionChance = { Min = 1, Max = 25 }, ---@comment: The chance of a flame reigniting after being extinguished, determined by selecting a random number between the minimum and maximum values and comparing it.

        ---@comment: https://docs.zeadevelopment.com/our-resources/z_fires/materials-list
        flammableMaterials = {
            -- Vegetation
            'Grass',
            'GrassShort',
            'GrassLong',
            'Bushes',
            'Twigs',
            'Leaves',
            'Woodchips',
            'TreeBark',
            'Hay',
            'SandLoose',
            'SandDryDeep',
            'SandCompact',
            'SandWet',
            'SandTrack',
            'SandWetDeep',
            'GravelSmall',
            'GravelLarge',
            'GravelDeep',
            'GravelTrainTrack',
            'DirtTrack',
            'MudHard',
            'MudPothole',
            'MudSoft',
            'MudDeep',
            'Marsh',
            'MarshDeep',
            'Soil',
            'ClayHard',
            'ClaySoft',

            -- Woods
            'WoodSolidSmall',
            'WoodSolidMedium',
            'WoodSolidLarge',
            'WoodSolidPolished',
            'WoodFloorDusty',
            'WoodHollowSmall',
            'WoodHollowMedium',
            'WoodHollowLarge',
            'WoodChipboard',
            'WoodOldCreaky',
            'WoodHighDensity',
            'WoodLattice',
            'WoodHighFriction',

            -- Plastics
            'Tarpaulin',
            'Plastic',
            'PlasticHollow',
            'PlasticHighDensity',
            'PlasticClear',
            'PlasticHollowClear',

            -- Rubber
            'Rubber',
            'RubberHollow',

            -- Other
            'Cloth',
            'Paper',
            'CardboardSheet',
            'CardboardBox',
            'Petrol',
            'Oil',
            'Foam'
        }
    },
    ---@comment: % Prop Fires %
    ['prop'] = {
        maxSpread = 25, ---@comment: The maximum amount of flames that this type of behavior can produce.
        spreadInterval = 15, ---@comment: The interval between the spreading of flames, measured in seconds.
        canSpreadToGrass = true, ---@comment: true | false

        reignitionChance = { Min = 1, Max = 25 }, ---@comment: The chance of a flame reigniting after being extinguished, determined by selecting a random number between the minimum and maximum values and comparing it.

        ---@comment: https://forge.plebmasters.de/objects/
        allowedProps = {
            -- bbqs
            `prop_beach_bbq`,
            `prop_bbq_1`,
            `prop_bbq_5`,

            -- tires
            `prop_rub_pile_01`,
            `prop_rub_pile_02`,
            `prop_rub_pile_03`,

            -- skips
            `prop_skip_03`,
            `prop_skip_05a`,
            `prop_skip_04`,
            `prop_skip_02a`,
            `prop_skip_01a`,
            `prop_skip_01b`,
            `prop_skip_01c`,
            `prop_skip_01d`,
            `prop_skip_01e`,
            `prop_skip_01f`,
            `prop_skip_02b`,
            `prop_skip_02c`,
            `prop_skip_02d`,
            `prop_skip_03b`,
            `prop_skip_04b`,
            `prop_skip_05b`,
            `prop_dumpster_01a`,
            `prop_dumpster_02a`,
            `prop_dumpster_02b`,
            `prop_dumpster_4b`,
            `prop_dumpster_3a`,
            `prop_dumpster_4a`,
            `prop_dumpster_01b`,
            `prop_dumpster_02c`,
            `prop_dumpster_02d`,

            -- homeless
            `prop_homeles_shelter_01`,
            `prop_homeles_shelter_02`,
            `prop_skid_trolley_1`,
            `prop_skid_trolley_2`,

            -- bins
            `prop_cs_bin_03`,
            `prop_bin_14a`,
            `prop_dumpster_3a`,
            `prop_bin_04a`,
            `prop_bin_05a`,
            `prop_bin_06a`,
            `prop_bin_07a`,
            `prop_bin_09a`,
            `prop_bin_10a`,
            `prop_bin_10b`,
            `prop_bin_11a`,
            `prop_bin_11b`,
            `prop_bin_12a`,
            `prop_bin_13a`,
            `prop_bin_14a`,
            `prop_bin_14b`,
            `prop_bin_beach_01d`,
            `prop_bin_delpiero`,
            `prop_bin_delpiero_b`,
        }
    },
    ---@comment: % Interior Fires %
    ['interior'] = {
        maxSpread = 25, ---@comment: The maximum amount of flames that this type of behavior can produce.
        spreadInterval = 10, ---@comment: The interval between the spreading of flames, measured in seconds.

        reignitionChance = { Min = 1, Max = 25 }, ---@comment: The chance of a flame reigniting after being extinguished, determined by selecting a random number between the minimum and maximum values and comparing it.

        ---@comment: https://docs.zeadevelopment.com/our-resources/z_fires/materials-list
        flammableMaterials = {
            'CarpetFloorboard',
            'CarpetSolid',
            'CarpetSolidDusty',
            'RoofTile',
            'RoofFelt',
            'FeatherPillow',
            'Leather',
            'TvScreen',
            'SlattedBlinds',
            'Petrol',
            'Oil',
            'WoodSolidSmall',
            'WoodSolidMedium',
            'WoodSolidLarge',
            'WoodSolidPolished',
            'WoodFloorDusty',
            'WoodHollowSmall',
            'WoodHollowMedium',
            'WoodHollowLarge',
            'WoodChipboard',
            'WoodOldCreaky',
            'WoodHighDensity',
            'WoodLattice',
            'WoodHighFriction',
            'Tarpaulin',
            'Plastic',
            'PlasticHollow',
            'PlasticHighDensity',
            'PlasticClear',
            'PlasticHollowClear',
            'Rubber',
            'RubberHollow',
            'Cloth',
            'Paper',
            'CardboardSheet',
            'CardboardBox',
            'Foam'
        }
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section fireTypes
---@description: Fire types allow the user to generate fires utalising different particles to suit the situation and enviroment.
cfg.fireTypes = {
    -- % Type Start % --
    ['normal'] = {
        fxDict = 'scr_exile2',
        fxName = 'scr_ex2_jeep_engine_fire',
        fxScale = { Min = 0.5, Max = 2.0 },

        attachedFx = {
            allow = true,

            effectType = 'plume2',
            spawnChance = { Min = 1, Max = 5 },
        },

        extinguishMethods = {
            [`weapon_hose`] = { impact = 0.005 },
            [`weapon_reelbranch`] = { impact = 0.005 },
            [`weapon_firehose`] = { impact = 0.005 },
            ['vehicle_deckgun'] = { impact = 0.005 }
        }
    },
    -- % Type End % --
    -- % Type Start % --
    ['normal2'] = {
        fxDict = 'scr_exile1',
        fxName = 'cs_ex1_cargo_fire',
        fxScale = { Min = 0.5, Max = 2.0 },

        attachedFx = {
            allow = true,

            effectType = 'plume2',
            spawnChance = { Min = 1, Max = 5 },
        },

        extinguishMethods = {
            [`weapon_hose`] = { impact = 0.005 },
            [`weapon_reelbranch`] = { impact = 0.005 },
            [`weapon_firehose`] = { impact = 0.005 },
            ['vehicle_deckgun'] = { impact = 0.005 }
        }
    },
    -- % Type End % --
    -- % Type Start % --
    ['normal3'] = {
        fxDict = 'core',
        fxName = 'ent_amb_fbi_fire_lg',
        fxScale = { Min = 0.5, Max = 2.0 },

        attachedFx = {
            allow = true,

            effectType = 'plume2',
            spawnChance = { Min = 1, Max = 5 },
        },

        extinguishMethods = {
            [`weapon_hose`] = { impact = 0.005 },
            [`weapon_reelbranch`] = { impact = 0.005 },
            [`weapon_firehose`] = { impact = 0.005 },
            ['vehicle_deckgun'] = { impact = 0.005 }
        }
    },
    -- % Type End % --
    -- % Type Start %
    ['normal4'] = {
        fxDict = 'core',
        fxName = 'ent_ray_heli_aprtmnt_s_fire',
        fxScale = { Min = 0.5, Max = 2.0 },

        attachedFx = {
            allow = true,

            effectType = 'plume2',
            spawnChance = { Min = 1, Max = 5 },
        },

        extinguishMethods = {
            [`weapon_hose`] = { impact = 0.005 },
            [`weapon_reelbranch`] = { impact = 0.005 },
            [`weapon_firehose`] = { impact = 0.005 },
            ['vehicle_deckgun'] = { impact = 0.005 }
        }
    },
    -- % Type End % --
    -- % Type Start % --
    ['veh1'] = {
        fxDict = 'cut_exile2',
        fxName = 'scr_ex2_jeep_engine_fire',
        fxScale = { Min = 0.5, Max = 2.0 },

        attachedFx = {
            allow = true,

            effectType = 'plume2',
            spawnChance = { Min = 1, Max = 5 },
        },

        extinguishMethods = {
            [`weapon_hose`] = { impact = 0.005 },
            [`weapon_reelbranch`] = { impact = 0.005 },
            [`weapon_foambranch`] = { impact = 0.005 },
            [`weapon_firehose`] = { impact = 0.005 },
            ['vehicle_deckgun'] = { impact = 0.005 }
        }
    },
    -- % Type End % --
    -- % Type Start % --
    ['grass1'] = {
        fxDict = 'core',
        fxName = 'ent_ray_ch2_farm_fire_u_l',
        fxScale = { Min = 0.2, Max = 2.0 },

        attachedFx = {
            allow = true,

            effectType = 'plume2',
            spawnChance = { Min = 1, Max = 5 },
        },

        extinguishMethods = {
            [`weapon_fireextinguisher`] = { impact = 0.005 },
            [`weapon_hose`] = { impact = 0.005 },
            [`weapon_reelbranch`] = { impact = 0.005 },
            [`weapon_firehose`] = { impact = 0.005 },
            ['vehicle_deckgun'] = { impact = 0.005 }
        }
    },
    -- % Type End % --
    -- % Type Start % --
    ['grass2'] = {
        fxDict = 'scr_oddjobtraffickingair',
        fxName = 'scr_ojdg4_train_fire',
        fxScale = { Min = 0.2, Max = 2.0 },

        attachedFx = {
            allow = true,

            effectType = 'plume2',
            spawnChance = { Min = 1, Max = 5 },
        },

        extinguishMethods = {
            [`weapon_hose`] = { impact = 0.005 },
            [`weapon_fireextinguisher`] = { impact = 0.005 },
            [`weapon_reelbranch`] = { impact = 0.005 },
            [`weapon_firehose`] = { impact = 0.005 },
            ['vehicle_deckgun'] = { impact = 0.005 }
        }
    },
    -- % Type End % --
    -- % Type Start % --
    ['chemical'] = {
        fxDict = 'core',
        fxName = 'fire_petroltank_truck',
        fxScale = { Min = 0.2, Max = 2.0 },

        attachedFx = {
            allow = true,

            effectType = 'plume2',
            spawnChance = { Min = 1, Max = 5 },
        },

        extinguishMethods = {
            [`weapon_fireextinguisher`] = { impact = 0.06 },
            [`weapon_foambranch`] = { impact = 0.06 }
        }
    },
    -- % Type End % --
    -- % Type Start % --
    ['electrical'] = {
        fxDict = 'scr_carrier_heist',
        fxName = 'scr_heist_carrier_elec_fire',
        fxScale = { Min = 0.2, Max = 2.0 },

        attachedFx = {
            allow = true,

            effectType = 'sparks',
            spawnChance = { Min = 1, Max = 5 },
        },

        extinguishMethods = {
            [`weapon_fireextinguisher`] = { impact = 0.06 },
            [`weapon_foambranch`] = { impact = 0.06 }
        }
    },
    -- % Type End % --
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section smokeTypes
---@description: Smoke types allow the user to generate smoke utalising different particles to suit the situation and enviroment.
cfg.smokeTypes = {
    -- % Type Start % --
    ['normal'] = {
        fxDict = 'core',
        fxName = 'ent_amb_generator_smoke',
        fxScale = { Min = 0.2, Max = 2.0 },
    },
    -- % Type End % --
    -- % Type Start % --
    ['normal2'] = {
        fxDict = 'core',
        fxName = 'ent_amb_fbi_smoke_edge_lip',
        fxScale = { Min = 0.2, Max = 2.0 },
    },
    -- % Type End % --
    -- % Type Start % --
    ['linger1'] = {
        fxDict = 'core',
        fxName = 'ent_amb_fbi_smoke_linger_hvy',
        fxScale = { Min = 0.2, Max = 2.0 },
    },
    -- % Type End % --
    -- % Type Start % --
    ['linger2'] = {
        fxDict = 'core',
        fxName = 'ent_amb_fbi_smoke_stair_gather',
        fxScale = { Min = 0.2, Max = 7.0 },
    },
    -- % Type End % --
    -- % Type Start % --
    ['plume1'] = {
        fxDict = 'des_gas_station',
        fxName = 'ent_ray_paleto_gas_plume_L',
        fxScale = { Min = 0.2, Max = 2.0 },
    },
    -- % Type End % --
    -- % Type Start % --
    ['plume2'] = {
        fxDict = 'core',
        fxName = 'ent_amb_smoke_general',
        fxScale = { Min = 0.2, Max = 2.0 },
    },
    -- % Type End % --
    -- % Type Start % --
    ['sparks'] = {
        fxDict = 'scr_agencyheistb',
        fxName = 'ent_amb_fbi_live_wires',
        fxScale = { Min = 0.2, Max = 2.0 },
    }
    -- % Type End % --
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section userInterface
---@description: Enables the option to toggle on/off and customize map indicators for fires and smoke.
cfg.userInterface = {
    ['fire_indicators'] = {
        allow = true,
        img = 'indicator.png'
    },
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section extinguishMethods
---@description: Enables the customization and adjustment of fire extinguishing methods, including the addition and removal of options.
cfg.extinguishMethods = {
    -- % Method Start % --
    [`weapon_hose`] = {
        radius = 1.5,
        distance = 15.0
    },
    -- % Method End % --
    -- % Method Start % --
    [`weapon_reelbranch`] = {
        radius = 1.5,
        distance = 15.0
    },
    -- % Method End % --
    -- % Method Start % --
    [`weapon_foambranch`] = {
        radius = 1.5,
        distance = 15.0
    },
    -- % Method End % --
    -- % Method Start % --
    [`weapon_firehose`] = {
        radius = 1.5,
        distance = 15.0
    },
    -- % Method End % --
    -- % Method Start % --
    [`weapon_fireextinguisher`] = {
        radius = 1.0,
        distance = 7.0
    },
    -- % Method End % --
    -- % Method Start % --
    ['vehicle_deckgun'] = {
        radius = 3.0,
        distance = 25.0
    }
    -- % Method End % --
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section discordLog
---@description: Enables the tracking of different actions through a Discord channel.
cfg.discordLog = {
    communityName = 'My Community',
    communityLogo = 'https://i.imgur.com/hFTmhMq.png',

    logActions = {
        -- % Fire Logs % --
        ['fire_creation_manual'] = true,
        ['fire_creation_automatic'] = false,
        ['fire_deletion'] = false,
        -- % Smoke Logs % --
        ['smoke_creation_manual'] = false,
        ['smoke_creation_automatic'] = false,
        ['smoke_deletion'] = false,
        -- % Duty Logs % --
        ['duty_booking'] = false,
        -- % Incident Logs % --
        ['incident_generation'] = false,
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section autoIncidents
---@description: Enables the configuration of automated incidents.
cfg.autoIncidents = {
    cooldown = 240, ---@comment: Cooldown period between incidents, This is measured in seconds.
    allowDuty = true, ---@comment: Do you want in-game automated incidents to be generated?

    dutyAlerts = {
        allow = true, ---@comment: Do you want in-game incident notifications?
        type = 'nui', ---@comment: Type of notification to be displayed: nui - chat..
        maintainNotification = false, ---@comment: Do you want the notification to remain even if you have an integration enabled?

        ---@url: https://wiki.rage.mp/index.php?title=Sounds
        sound = {
            allow = true,
            soundName = "10_SEC_WARNING",
            soundSet = "HUD_MINI_GAME_SOUNDSET"
        },

        ---@url: https://docs.fivem.net/docs/game-references/blips/
        blip = {
            allow = true,
            sprite = 161,
            colour = 1,
            scale = 0.9,
            shortRange = true,
            drawRoute = true
        }
    },

    ---@comment: Do you want an alternative integration to notify users of incidents? This can be viewed in the server/classes/bridge.lua.
    integrations = {
        ['albosFMS'] = false, ---@url: https://albo1125.com/fms
        ['sonoranCAD'] = false, ---@url: https://sonorancad.com/
        ['infernoPager'] = false, ---@url: https://github.com/inferno-collection/Fire-EMS-Pager
        ['infernoStationAlert'] = false, ---@url: https://store.inferno-collection.com/category/sa
        ['emergencyDispatch'] = false, ---@url: https://love-rp.tebex.io/package/4887641
        ['cd_dispatch'] = true, ---@url: https://codesign.pro/package/4206357
        ['night_shifts'] = false, ---@url: https://store.nights-software.com/package/5667103
        ['commandControl'] = false, ---@url: https://discord.gg/P9FtqjkQYT
        ['lb-tablet'] = false, ---@url: https://store.lbscripts.com/category/2238536
        ['codem-dispatch'] = false, ---@url: https://docs.codesign.pro/paid-scripts/dispatch
        ['ps-dispatch'] = false ---@url: https://docs.projectsloth.org/ps/scripts/ps-dispatch
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section keybinds
---@description: Allow for the customization of keybinds utilized by the resource.
---@comment: https://docs.fivem.net/docs/game-references/controls/
---@comment: core > client > classes > enums.lua > enums.keybinds
cfg.keybinds = {
    place = 'LEFT_MOUSE_BUTTON',
    cancel = 'RIGHT_MOUSE_BUTTON',
    scale_increase = 'SCROLLWHEEL_UP',
    scale_decrease = 'SCROLLWHEEL_DOWN',
    focus_interface = 'ENTER',
    distance_increase = "Q",
    distance_decrease = "E",
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section languages
---@description: Allow for different languages to be utalised for displayed text.
cfg.languages = {
    ['en'] = {
        -- % Titles % --
        error = 'Error!',
        success = 'Success!',
        info = 'Info!',

        -- % Fire Incident Messages % --
        new_incident = 'Fire!',
        incident_description = 'Reported: %s fire!',

        -- % Fire Messages % --
        fire_created = 'Fire Created! Id: %s',
        fire_deleted = 'Fire Deleted!',
        fires_deleted = 'Fires Deleted! Count: %s',
        fire_notfound = 'No Fire found!',

        -- % Smoke Messages % --
        smoke_created = 'Smoke Created! Id: %s',
        smoke_deleted = 'Smoke Deleted!',
        smokes_deleted = 'Smoke Deleted! Count: %s',
        smoke_notfound = 'No Smoke found!',

        -- % Warning Messages % --
        missing_argument = 'Missing argument!',
        cancelled_creation = 'Cancelled placing!',
        warning_cooldown = 'This command has a cooldown period!',
        warning_invehicle = 'This command cannot be used while in a vehicle!',
        already_spooner = 'You are already in spooner mode!',
        invalid_feffect = 'Invalid fire effect type!',
        invalid_seffect = 'Invalid smoke effect type!',
        invalid_size = 'Invalid fire size!',
        invalid_type = 'Invalid Type!',
        invalid_spread = 'Invalid Spread Argument!',
        invalid_disperse = 'Invalid Disperse Argument!',
        invalid_department = 'Invalid Department Argument!',
        no_permission = 'You lack the permissions for this actions!',

        -- % Duty Messages % --
        booked_on = 'You have booked on duty with %s!',
        booked_off = 'You have booked off duty!',
        already_offduty = 'You are already booked off duty!',
        already_onduty = 'You are already booked on duty!',

        -- % Offset Messages % --
        vehicle_not_found = 'Vehicle not found!',
        placement_cancelled = 'Placement cancelled!',
        offset_saved = 'Offset saved!',
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
