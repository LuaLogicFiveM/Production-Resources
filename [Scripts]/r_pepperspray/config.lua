/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-pepper-spray
  % Support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Configuration ]]

Config = {
    -- General Settings
    Language = 'en', -- Script language ('en' for English, 'fr' for French). See Config.Languages to edit texts.
    UseOutdatedVersion = false, -- Set to true to suppress console alerts for using older versions.

    -- Framework Compatibility
    -- ESX instructions: https://docs.rytrak.fr/framework-compatibility/add-a-custom-weapon-on-esx
    -- QBCore instructions: https://docs.rytrak.fr/framework-compatibility/add-a-custom-weapon-on-qbcore
    -- OX Inventory instructions: https://docs.rytrak.fr/framework-compatibility/add-a-custom-weapon-on-ox-inventory
    UseFramework = true, -- Set to true if using a framework (removes command and uses inventory instead).

    -- Inventory Management
    AutoRemoveEmptyItems = { 
        enabled = true, -- Enable auto-removal of empty pepper spray or antidote items from inventory
        framework = { 
            ESX = false, 
            QBCore = false,
            OXInventory = true 
        }
    },

    -- Recharge Settings
    RechargeLocations = { 
        vector3(2809.5803, 4723.6118, 48.6273),
        vector3(458.1556, -998.3224, 30.7107)
    },
    RechargeRadius = 1.0, -- Radius around the recharge point where the player can refill their sprays

    -- Player Control Settings
    DisableControl = {
        Sprint = true, -- Disable sprinting when gassed
        EnterVehicle = true, -- Disable getting into a vehicle when gassed
        Fight = true, -- Disable fighting when gassed
    },
    
    -- Weapon Settings
    WeaponWheelName = {
        pepperspray = 'Pepper Spray', -- Name used for the Pepper Spray in the weapon wheel
        antidote = 'Antidote' -- Name used for the Antidote in the weapon wheel
    },

    CooldownDelay = 500, -- Cooldown delay to prevent spam of events
    
    -- Pepper Spray Configuration
    PepperSpray = { -- Here you can configure a new spray as many times as you want (see the documentation for more information)
    -- You can add as many pepper sprays as you want in this table!
        ['pepperspray'] = {
            weaponModel = 'WEAPON_PEPPERSPRAY', -- Model of the weapon for the spray

            sprayQuantity = 500, -- Total quantity of spray in the canister
            sprayDescentSpeed = 10, -- Rate at which spray quantity decreases (higher = slower)
            sprayRange = 4, -- Range of the pepper spray
            sprayDamageMultiplier = 1, -- 25*the multiplier (for the bar to be at 100, the multiplier must be at 4 the maximum of the multiplier) (by default the multiplier is set to 1 so the bar will rise in 25)

            gasDescentSpeed = 500, -- Rate at which the gas effect fades

            coughEnabled = true, -- Enable coughing when the player is affected by the gas.
            coughSound = true, -- Enable sound effect when the player coughs. (only if the cough system is enabled)

            spitEnabled = true, -- Allow player to spit out the gas
            spitDescentSpeed = 5, -- Rate at which the gas decreases when spitting
            spitTimeout = 10000, -- Cooldown between spits (in ms)

            rubbingEnabled = true, -- Allow player to rub their eyes to reduce the effect
            rubbingDescentSpeed = 2.0, -- Speed at which the gas decreases when rubbing the eyes

            selfDecontamination = true, -- Activate or not the player's self decontamination with a decontamination spray when you are gassed.

            -- Visual Effects when using Pepper Spray
            effect = {
                timecycle = { -- Visual effects when gassing (two effects maximum) (to disable an effect, simply delete the 'name' content) https://wiki.rage.mp/index.php?title=Timecycle_Modifiers
                    [1] = {
                        name = 'ufo',
                        opacity = 1.0
                    },
                    [2] = {
                        name = 'MP_death_grade_blend01',
                        opacity = 0.8
                    }
                },
                shakeCamera = { -- Screen shake (to disable, simply remove the 'name' content) https://pastebin.com/NdpyVNP0
                    name = 'DRUNK_SHAKE',
                    intensity = 3.0
                }
            },

            -- Particle Effects for Pepper Spray
            particle = {
                dict = 'core',
                particle = 'exp_sht_extinguisher',
                particleCoords = vector3(0.10, 0.0, 0.0),
                particleRotation = vector3(-80.0, 0.0, -90.0),
                particleSize = 0.5
            },

            -- Gas Mask Protection (no damage when wearing gas mask)
            gasMask = { -- Exeption of gas damage when you have one of the following masks (see the documentation for more information)
                [`mp_m_freemode_01`] = { -- Male
                    [1] = {}, -- example: {38, 39}
                    [2] = {}
                },
                [`mp_f_freemode_01`] = { -- Female
                    [1] = {},
                    [2] = {}
                }
            }
        }
    },

    -- Decontamination Spray Configuration
    Decontamination = {
        command = 'antidote', -- Command to recover the decontamination spray (you can modify the command from cl_utils.lua)
        weaponModel = 'WEAPON_ANTIDOTE', -- Weapon model for the decontamination spray

        decontaminationQuantity = 100, -- Total quantity of decontamination spray
        decontaminationDescent = 10, -- Time in milliseconds to lower the recovery rate (The higher the number, the longer the time)
        decontaminationCooldown = 2000, -- Time in miliseconds to use the decontamination spray

        decreaseLevel = 10, -- How much the effect decreases when using the decontamination spray

        -- Particle Effects for Decontamination Spray
        particle = {
            dict = 'scr_bike_business',
            particle = 'scr_bike_spraybottle_spray',
            particleCoords = vector3(0.30, 0.0, 0.0),
            particleRotation = vector3(-80.0, 0.0, -90.0),
            particleSize = 1.5,
        }
    }
}

Config.Design = {
    ProgressBar = {
        color = {52, 152, 219}, -- RGB color of the progress bar.
        text = 'RECOVERY' -- Max 8 caracters. (If you don't put anything here, the text will be deleted and the bar will become bigger)
    }
}

-- https://docs.fivem.net/docs/game-references/controls/
Config.Keys = {
    SpitKey = 47, -- Key to spit
    SpitKeyString = '~INPUT_DETONATE~', -- Key string to spit

    RubbingKey = 104, -- Key to rub the eyes
    RubbingKeyString = '~INPUT_VEH_SHUFFLE~', -- Key string to rub the eyes

    ReplaceKey = 47, -- Key to replace your pepper spray
    ReplaceKeyString = '~INPUT_DETONATE~' -- Key string to replace your pepper spray
}

-- Libraries of languages.
Config.Languages = {
    ['en'] = {
        ['quantity'] = 'You have ~b~{s}ml',
        ['spit'] = 'To spit press '..Config.Keys.SpitKeyString,
        ['rubbing'] = 'Rubbing the eyes press '..Config.Keys.RubbingKeyString,
        ['replacepepperspray'] = 'Replace your pepper spray press '..Config.Keys.ReplaceKeyString,
        ['replacedecontamination'] = 'Replace your decontamination spray press '..Config.Keys.ReplaceKeyString
    },
    ['fr'] = {
        ['quantity'] = 'Il vous reste ~b~{s}ml',
        ['spit'] = 'Pour cracher presse '..Config.Keys.SpitKeyString,
        ['rubbing'] = 'Pour se frotter les yeux presse '..Config.Keys.RubbingKeyString,
        ['replacepepperspray'] = 'Remplacer la gazeuse presse '..Config.Keys.ReplaceKeyString,
        ['replacedecontamination'] = 'Changer de décontaminant presse '..Config.Keys.ReplaceKeyString
    }
}