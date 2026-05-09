Config = {}


Config.CreateItems = {
    atm_hack_device = {
        label = locale("ITEM_HACKING_DEVICE_LABEL"),
        rarity = "COMMON",
        weight = 0.1,
        isSeizable = true,
        defaultMetaData = {
            durability = 100,
        },
    },

    atm_bomb = {
        label = locale("ITEM_EXPLOSIVE_LABEL"),
        rarity = "COMMON",
        weight = 0.2,
        isSeizable = true,
    }
}

-- // If global cooldown is active, no one can rob any ATM in any way.
-- // This determines how long, in minutes, the global cooldown is
Config.GlobalCooldown = 5

--[[
    minGroupSize: How many people are require to do each robbery way (1 means players can do it solo)
    skillXP: How much xp to give to the players skill tree
    orgXP: How much xp to add to the players org
    durabilityLossOnFail: How much durability the required item loses when player fails minigame
    resetTime: How long in minutes before the ATM is reset and can be spawned in the world again (the timer is started as soon as the player initiates the robbery)
    requiredCops: How many cops are required to rob the ATM (0 means no cops required)
    alertData: The alert to send to police when this ATM is being robbed (or nil to not send an alert)
        chance: The chance this alert is sent
        code: The 10-code
        titLe: The title of the alert
        blip: The blip to show on the map | https://docs.fivem.net/docs/game-references/blips/
            icon
            size
            color
            duration
            flashing
]]
Config.Rope = {
    requiredCops = 0,
    minGroupSize = 1,
    unlockTime = { min = 240, max = 360 }, -- How long in seconds it takes for an ATM to be searchable
    playSoundOnUnlock = true,              -- If we should play a little sound on the ATM when it's unlocked
    resetTime = 45,
    cleanupAfterLoot = 2, -- How long in minutes before the ATM is removed after being looted
    tracker = {
        enabled = true,
        updateTime = 30000, -- How often, in ms, to update the blip for all cops
        blip = {
            sprite = 161,
            size = 1.5,
            color = 1,
            label = locale("ATM_TRACKER_LABEL")
        }
    },
    alertData = {
        chance = 100,
        code = "10-90",
        title = locale("ALERT_TITLE"),
        blip = {
            icon = 434,
            size = 1.5,
            color = 1,
            duration = (60 * 5),
            flashing = false,
        }
    },
    loot = {
        lootTableRolls = 2,
        lootTable = {
            COMMON = {
                { name = "moneyroll", min = 20, max = 40 },
            },
            RARE = {
                { name = "moneyroll", min = 30, max = 45 },

            },
            EPIC = {
                { name = "moneyroll", min = 50, max = 65 },
            },
            LEGENDARY = {
                { name = "moneyroll", min = 75, max = 95 },
            },
        },
        guaranteedRarities = {
        }
    }
}

Config.LogWebhookurl = ""

Config.Explosive = {
    requiredCops = 0,
    minGroupSize = 1,
    durabilityLossOnFail = 10,
    explodeExplosiveOnBroken = true,         -- If true, the explosive item will explode the player if it reaches 0% durability
    explodeDelayTime = { min = 5, max = 5 }, -- How long (in minutes) to wait before exploding the explosive
    resetTime = 45,
    alertData = {
        chance = 100,
        code = "10-90",
        title = locale("ALERT_TITLE"),
        blip = {
            icon = 434,
            size = 1.5,
            color = 1,
            duration = (60 * 5),
            flashing = false,
        }
    },
    loot = {
        lootTableRolls = 2,
        lootTable = {
            COMMON = {
                { name = "moneyroll", min = 15, max = 24 },
            },
            RARE = {
                { name = "moneyroll", min = 25, max = 40 },

            },
            EPIC = {
                { name = "moneyroll", min = 45, max = 65 },
            },
            LEGENDARY = {
                { name = "moneyroll", min = 80, max = 120 },
                { name = "goldbar",   min = 1,  max = 1 },
                { name = "rolex",     min = 1,  max = 1 },
                { name = "laptop",    min = 1,  max = 1 },
                { name = "diamond",   min = 1,  max = 1 },
            },
        },
        guaranteedRarities = {
        }
    }
}

Config.Hack = {
    requiredCops = 0,
    minGroupSize = 1,
    durabilityLossOnFail = 20,
    failsAllowed = 3,
    failCooldown = 40,                  -- How many seconds to wait before allowing the player to try again if they fail the hack
    breakItemOnSuccess = true,          -- If true, the required item will break if the minigame is completed successfully
    searchDelay = { min = 5, max = 5 }, -- How long before the player can search the ATM after successfully hacking the ATM
    resetTime = 45,
    alertData = {
        chance = 100,
        code = "10-90",
        title = locale("ALERT_TITLE"),
        blip = {
            icon = 434,
            size = 1.5,
            color = 1,
            duration = (60 * 5),
            flashing = false,
        }
    },
    loot = {
        lootTableRolls = 2,
        lootTable = {
            COMMON = {
                { name = "moneyroll", min = 20, max = 35 },
            },
            RARE = {
                { name = "moneyroll", min = 30, max = 45 },

            },
            EPIC = {
                { name = "moneyroll", min = 50, max = 65 },
            },
            LEGENDARY = {
                { name = "moneyroll", min = 75, max = 95 },
            },
        },
        guaranteedRarities = {
        }
    }
}

-- Config.OwnerCooldownOnly = false -- If true, only the owner of the group gets the cooldown, every else gets none
-- ^^ Took this out since we can just set AffiliateRobCooldown to 0 to only give owner a cooldown
Config.OwnerRobCooldown = 60     -- How many minutes to wait before allowing player to rob another ATM
Config.AffiliateRobCooldown = 50 -- Percentage of the cooldown we give to affiliates (non-group owner). EX: if OwnerRobCooldown is 60 and this is 50, then 50% of the cooldown will be given to affiliates (aka 30 minutes).
