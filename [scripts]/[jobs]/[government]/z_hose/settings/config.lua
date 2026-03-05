---@docus: Please refer to our resource documentation for assistance with configuring this resource: docs.zeadevelopment.com.

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section cfg
cfg = cfg or {}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section updateDist
---@description: Enable customization of the distance traveled before the rope updates its position.
cfg.updateDist = 1.5

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section syncInterval
---@description: This is the interval during which the hose synchronization occurs between clients.
cfg.syncInterval = 1 ---|> This is measured in seconds. If you need to specify a value less than one second, utilize a floating-point number, such as 0.5.

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section interactions
cfg.interactions = {
    method = 'z_interactions', ---|> | 'z_interactions' | 'ox_target' |
    distance = 2.0,            ---|> Distance which users can view and interact.
    radius = 0.05              ---|> Radius which users can view and interact.
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section hoses
cfg.hoses = {
    ['foam'] = {
        weapon = `WEAPON_FOAMBRANCH`,
        object = `w_me_foambranch`,

        attachment = { ---|> Offset where the rope attaches to the weapon
            offset = vector3(-0.15, 0.0, -0.01)
        },
        particles = { ---|> Position and Rotation of particles emitted
            offset = vector3(0.57, 0.05, -0.35),
            rotation = vector3(15.0, 0.0, -90.0)
        }
    },
    ['water'] = {
        weapon = `WEAPON_REELBRANCH`,
        object = `w_me_reelbranch`,

        attachment = { ---|> Offset where the rope attaches to the weapon
            offset = vector3(-0.2, 0.0, 0.01)
        },
        particles = { ---|> Position and Rotation of particles emitted
            offset = vector3(0.1, 0.0, 0.015),
            rotation = vector3(0.0, 0.0, -90.0)
        }
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section objects
cfg.objects = {
    ['light_portable_pump'] = `prop_generator_01a`,
    ['standpipe'] = `standpipe`
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section flowRates
cfg.flowRates = {
    ['water'] = {
        indent = 0.5 ---|> decrease in amount per tick
    },
    ['foam'] = {
        indent = 0.1,     ---|> decrease in amount per tick
        useWater = true,  ---|> Would you like your water level to be influenced when using foam?
        waterIndent = 0.5 ---|> decrease in amount per tick
    }
}

------------- # ------------- s# ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section supplyMethods
cfg.supplyMethods = {
    [`prop_fire_hydrant_1`] = {
        type = 'hydrant', ---|> | 'Hydrant' | 'Suction' |
        offset = vector3(0.3, 0.0, 0.6),
        flowRate = {
            increment = 5.0,  ---|> amount incremented per tick
            miliseconds = 100 ---|> time in milliseconds for each tick
        }
    },

    [`prop_fire_hydrant_2`] = {
        type = 'Hydrant', ---|> | 'Hydrant' | 'Suction' |
        offset = vector3(0.2, 0.0, 0.7),
        flowRate = {
            increment = 5.0,  ---|> amount incremented per tick
            miliseconds = 100 ---|> time in milliseconds for each tick
        }
    },

    [`prop_fire_hydrant_4`] = {
        type = 'Hydrant', ---|> | 'Hydrant' | 'Suction' |
        offset = vector3(0.15, 0.0, 0.62),
        flowRate = {
            increment = 5.0,   ---|> amount incremented per tick
            miliseconds = 100, ---|> time in milliseconds for each tick
        }
    },

    [cfg.objects['standpipe']] = {
        type = 'Hydrant', ---|> | 'Hydrant' | 'Suction' |
        offset = vector3(0.08, 0.07, 0.72),
        flowRate = {
            increment = 5.0,   ---|> amount incremented per tick
            miliseconds = 100, ---|> time in milliseconds for each tick
        }
    },

    [cfg.objects['light_portable_pump']] = {
        type = 'Suction', ---|> | 'Hydrant' | 'Suction' |
        offset = vector3(0.0, 0.0, 0.4),
        flowRate = {
            increment = 5.0,   ---|> amount incremented per tick
            miliseconds = 100, ---|> time in milliseconds for each tick
        }
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section decals
cfg.decals = {
    ['water'] = {
        decalType = 9004,
        decalColour = { R = 45, G = 45, B = 45, A = 0.3 },
        canCoverEntities = false
    },
    ['foam'] = {
        decalType = 1050,
        decalColour = { R = 255, G = 255, B = 255, A = 0.7 },
        canCoverEntities = true
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section commands
cfg.commands = {
    ['LPP'] = {
        command = 'lpp',
        description = 'Spawn / Delete a Light Portable Pump'
    },
    ['FoamCan'] = {
        command = 'foamCan',
        description = 'Give Foam Can, Used for refilling vehicles foam tanks.'
    },
    ['Standpipe'] = {
        command = 'standpipe',
        description = 'Spawn / Delete a Standpipe'
    },
    ['HydantMap'] = {
        command = 'hydrantMap',
        description = 'View hydrant map.'
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section keybinds
---@description: Allow for the customization of keybinds utilized by the resource.
---@comment: https://docs.fivem.net/docs/game-references/controls/
---@comment: core > client > classes > enums.lua > enums.keybinds
cfg.keybinds = {
    -- % View Pump % --
    ['view_pump'] = 'Z',
    -- % Hose Reel % --
    ['use_reel'] = 'E',
    ['return_reel'] = 'E',
    -- % Supply Line % --
    ['connect_supply'] = 'G',
    ['disconnect_supply'] = 'G',
    -- % Relay Line % --
    ['connect_relay'] = 'G',
    ['disconnect_relay'] = 'G',
    -- % Pick Ups % --
    ['pickup_hosebranch'] = 'E',
    ['pickup_foambranch'] = 'E',
    -- % Drop Hose % --
    ['drop_hosebranch'] = 'G',
    -- % Cancel Hose % --
    ['cancel_hose'] = 'X',
    -- % Drop Light Portable Pump % --
    ['drop_lpp'] = 'G',
    -- % Standpipe % --
    ['connect_standpipe'] = 'G',
    -- % Refill Foam % --
    ['refill_foam'] = 'G',
    -- % Cancel Action % --
    ['cancel_action'] = 'X',
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@section languages
---@description: Allow for different languages to be utalised for displayed text.
cfg.languages = {
    ['en'] = {
        ['interactions'] = {
            -- % Hose Reel % --
            use_hosebranch = 'Take hose line',
            use_foambranch = 'Take foam line',
            return_reel = 'Return line',
            -- % Supply Line % --
            connect_supply = 'Take supply line',
            disconnect_supply = 'Disconnect supply line',
            connect_to = 'Connect to %s',
            -- % Relay Line % --
            take_relay = 'Take relay line',
            connect_relay = 'Connect relay line',
            disconnect_relay = 'Disconnect relay line',
            -- % Pick Ups % --
            pickup_hosebranch = 'Pick up hose branch',
            pickup_foambranch = 'Pick up foam branch',
            -- % Pump Panel % --
            view_pump = 'View pump panel',
            -- % Connect Standpipe % --
            connect_standpipe = 'Connect standpipe',
            -- % Refill Foam % --
            refill_foam = 'Fill foam tank'
        },

        ['notifications'] = {
            -- % Titles % --
            error = 'Error!',
            success = 'Success!',
            info = 'Info!',

            -- % Errors % --
            already_has_hose = 'User already possesses an active hose. Current hose ID: %s',
            no_hose_found = 'No active hose found for user. Current hose ID: %s',
            while_in_vehicle = 'Cannot complete this action while in a vehicle!',
            while_not_in_vehicle = 'Cannot complete this action while not in a vehicle!',
            vehicle_not_valid = 'Cannot complete this action while in a invalid vehicle!',
            lack_permission = 'You lack the permission for this action!',
            does_not_carry = 'This vehicle does not have a water tank!',
            failed_to_collect = 'Failure to collect a hose, This is a server issue.!',
            failed_to_find = 'Failure to collect a hose, Please ensure the vehicle is within your view!',
            panel_in_use = 'The pump panel is currently in use. Please wait until it is available.',

            -- % Branch % --
            retrieved_branch = 'Retrieved %s branch!',
            returned_branch = 'Returned hose branch!',
            cancelled_hose = 'Hose length cancelled!',

            -- % Supply % --
            retrieved_supply = 'Retrieved supply line!',
            connect_to_supply = 'Connected to supply line!',
            disconnected_supply = 'Disconnected supply line!',

            -- % Relay % --
            retrieved_relay = 'Retrieved relay line!',
            connect_relay = 'Connected relay line!',
            disconnected_relay = 'Disconnected relay line!',

            -- % Foam % --
            foam_filled = 'Foam tank has been filled!',
            foamcan_gained = 'Foam Cam gained, Head to the nearest vehicle to fill its foam tank!',
            foamcan_cancelled = 'Foam Cam has been removed following the cancellation of the action.',

            -- % Standpipe % --
            standpipe_placed = 'Standpipe placed!',
            standpipe_deleted = 'Standpipe deleted!',

            -- % Light Portable Pump % --
            lpp_placed = 'Light Portable Pump placed!',
            lpp_deleted = 'Light Portable Pump deleted!',
            lpp_no_water = 'Water not detected. Ensure the water is deep enough!',
        },

        ['contexts'] = {
            cancel_action = 'Cancel',
            cancel_hose = 'Cancel hose',
            drop_hosebranch = 'Drop hose',
            drop_lpp = 'Drop LPP',
        }
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
