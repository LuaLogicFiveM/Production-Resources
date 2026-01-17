/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-handcuffs-system
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Configuration ]]

Config = {
    Language = 'en', -- Language library used for the script, see the last lines to modify the text of the language. (Config.Languages)

    EnableCommands = true, -- Don't activate if you're using a framework

    -- IMPORTANT : Follow our documentation on this subject:
    -- For ESX: https://docs.rytrak.fr/scripts/advanced-handcuffs-system/make-esx-compatible
    -- For QBCore: https://docs.rytrak.fr/scripts/advanced-handcuffs-system/make-qbcore-compatible
    -- For OX-Inventory: https://docs.rytrak.fr/scripts/advanced-handcuffs-system/make-ox-inventory-compatible
    Framework = {
        ESX = false, 
        QBCore = false,
        OXInventory = true,

        -- Config for those using a framework
        UniqueCuffs = false, -- Removes x1 of the handcuffs item when you handcuff someone, and as soon as you unhandcuff someone you get a pair of handcuffs back.
        NeedItemToCutRope = {'knife'}, -- List of possible items for cutting rope (If the table is empty, the key system will appear, when you stand behind a player, the script proposes to untie the person)
        NeedWeaponToCutRope = {'weapon_knife'} -- List of possible weapons for cutting rope.
    },

    DisableInventoryKey = {'TAB', 'F2'}, -- Disables keys to open inventory

    DisableKey = { -- Disables the keys below when the player is handcuffed. To adjust, go to the FiveM key list. https://docs.fivem.net/docs/game-references/controls/
        24,
        140,
        141,
        142,
        22,
        25,
        69,
        92,
        114,
        257,
        21, -- Sprint
        23, -- Enter vehicle
        -- The key to block the exit the vehicle is located in the cl_utils.lua file line 130.
    },

    SyncedCuffs = true, -- Keeps the player handcuffed even if he disconnects and reconnects later (this setting works with the player's GTA V license and is saved only in a temporary server table)

    NeedToBeBehind = false, -- Set this option to “true” if you want the player to be behind the person in order to handcuff/unhandcuff them. (if false, the player can be in front of the other player to cuff/uncuff him)

    -- Props configuration
    Props = {
        Cuffs = {
            name = 'cuffs',
            attachBone = 18905,
            offset = {0.02, -0.28, 0.18},
            rotation = {0.0, -90.0, 209.0}
        },
        Rope = {
            name = 'rope',
            attachBone = 18905,
            offset = {0.02, -0.04, 0.11},
            rotation = {0.0, -90.0, 204.0}
        },
        Grinder = {
            name = 'sf_prop_grinder_01a',
            attachBone = 57005,
            offset = {-0.01, -0.06, -0.14},
            rotation = {-35.0, 5.0, 70.0}
        }
    },

    StatebagsName = {
        handcuffs = 'cuffs',
        rope = 'rope'
    }
}

-- https://docs.fivem.net/docs/game-references/controls/
Config.Keys = {
    CutRopeKey = 38, -- Key to cut the rope
    CutRopeKeyString = '~INPUT_PICKUP~', -- Name of the key to cut the rope
}

-- Libraries of languages.
Config.Languages = {
    ['en'] = {
        ['notBehind'] = 'You\'re not standing behind anyone',
        ['cutrope'] = 'Press '..Config.Keys.CutRopeKeyString..' to cut the rope'
    },
    ['fr'] = {
        ['notBehind'] = 'Vous n\'êtes pas placé derrière quelqu\'un',
        ['cutrope'] = 'Presse '..Config.Keys.CutRopeKeyString..' pour couper la corde'
    }
}