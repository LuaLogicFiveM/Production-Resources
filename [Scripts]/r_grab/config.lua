/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-police-grab-ped
  % Support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Configuration File ]]

Config = {
    -- General Settings
    Language = 'en', -- Script language ('en' for English, 'fr' for French). See Config.Languages to edit texts.
    UseOutdatedVersion = false, -- Set to true to suppress console alerts for using older versions.

    -- Framework System Configuration
    Framework = {
        -- ESX Compatibility
        ESX = {
            enabled = true, -- Enable ESX compatibility.
            jobs = {'sheriff', 'sahp'}, -- Allowed jobs to use the grab ped feature.
            exceptionJobs = true -- If true, the listed jobs cannot be grabbed.
        },

        -- QB Compatibility
        QB = {
            enabled = false, -- Enable QB compatibility.
            jobs = {'police', 'fbi'} -- Allowed jobs to use the grab ped feature.
        },
    },

    CommandSystem = {
        Enabled = false, -- Enable/disable the command-based interaction system. (WARNING! If you are using a system in the Target System, disable the command system)
        
        Grab = 'grab', -- Command to grab a person (modifiable in cl_utils.lua).
        PutPlayer = 'putplayer', -- Command to put a person into a vehicle (modifiable in cl_utils.lua).
        RemovePlayer = 'removeplayer', -- Command to remove a person from a vehicle (modifiable in cl_utils.lua).
    },

    -- Target System Configuration
    TargetSystem = {
        -- Enables the use of a 3D interaction system (Only one can be enabled at a time).
        -- (If you are using the target system set Config.CommandSystem.Enabled = false)
        
        UseOXTarget = true, -- Enable ox_target support (See client/ox_target.lua).
        UseQBTarget = false, -- Enable qb-target support (See client/qb_target.lua).

        CustomTarget = false -- Set to true if using a custom target system. Follow the structure of client/ox_target.lua or client/qb_target.lua.
    },

    -- Player Movement Settings
    DisableControls = {
        disableSprint = true, -- Disable sprinting while carrying a player (recommended: true).
        getOutVehicle = true, -- Prevents grabbed players from exiting the vehicle on their own.
    },
    CollisionRange = 0.5, -- Collision distance between players (0.0 to disable collisions).
    GrabbingRadius = 1.0, -- Distance to grab a player (recommended: 1.0).
    AttachPosition = vector3(0.20, 0.45, 0.0), -- Position of the grabbed player relative to the grabber.

    -- Animations
    Animations = {
        policeAnimation = {
            enabled = true, -- Enable animation for the grabber (e.g., police).
            animDict = 'amb@world_human_drinking@coffee@male@base',
            anim = 'base'
        },
        citizenAnimation = {
            enabled = false, -- Enable animation for the grabbed person.
            animDict = 'amb@world_human_drinking@coffee@male@base',
            anim = 'base'
        }
    }
}

-- [[ Key Bindings - Refer to https://docs.fivem.net/docs/game-references/controls/ ]]
Config.Keys = {
    GrabAndDropKey = 289, -- Key to grab/release a person (used when Config.CommandSystem.Enabled = false) (You need to modify here and in the cl_utils.lua file line 82 where the RegisterKeyMapping function appears)
    GrabAndDropKeyString = '~INPUT_REPLAY_START_STOP_RECORDING_SECONDARY~', -- Display name for the grab/release key.

    TaskEnterKey = 305, -- Key to place a person into a vehicle.
    TaskEnterKeyString = '~INPUT_REPLAY_STARTPOINT~' -- Display name for the key to place a person into a vehicle.
}

-- [[ Language Libraries - Edit texts for different languages here ]]
Config.Languages = {
    ['en'] = {
        ['taskenter'] = 'Put the person in the vehicle '..Config.Keys.TaskEnterKeyString,
        ['exitped'] = 'Taking the person out the vehicle '..Config.Keys.TaskEnterKeyString,
        ['releaseperson'] = 'Release the person press '..Config.Keys.GrabAndDropKeyString,

        ['dragplayer'] = 'Drag the player',
        ['putplayerinvehicle'] = 'Put the player in the vehicle',
        ['removeplayerfromvehicle'] = 'Remove the player from the vehicle'
    },
    ['fr'] = {
        ['taskenter'] = 'Faire monter la personne '..Config.Keys.TaskEnterKeyString,
        ['exitped'] = 'Faire descendre la personne '..Config.Keys.TaskEnterKeyString,
        ['releaseperson'] = 'Lâcher la personne '..Config.Keys.GrabAndDropKeyString,

        ['dragplayer'] = 'Traîner le joueur',
        ['putplayerinvehicle'] = 'Mettre le joueur dans le véhicule',
        ['removeplayerfromvehicle'] = 'Sortir le joueur du véhicule'
    }
}