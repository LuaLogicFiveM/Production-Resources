SvConfig = {}

SvConfig.Logging = true
SvConfig.Webhook = ""

-- Whether you want to use the bridge allowlist system
SvConfig.UseBridgeAllowlist = true

-- whether admin checks use bridge allowlist also or just `bridge.fw.isAdmin`
SvConfig.UseAdminAllowlist = true

-- whether rank allowlist is needed for ranked race creation
SvConfig.UseRankedAllowlist = true

-- do they need the "create_race" allowlist to create a race
SvConfig.RequireALToCreateRace = false

-- do they need the "track_creator" allowlist to create a race
SvConfig.RequireALToCreateTrack = true

-- Will races of the hour generate
SvConfig.GenerateRaceOfTheHour = true

-- Will the racing tablet be required to join a race
SvConfig.RequireItemToRace = true

-- how long the race countdown is
SvConfig.StartTime = 15 -- [[ seconds]]

SvConfig.EloSettings = {
    -- the starting elo of all players
    startingElo = 1000,
    -- the starting elo of all crews
    startingEloCrew = 1000,
    kFactor = 64,
    allowPrivate = false
}

-- the settings for crews
SvConfig.CrewSettings = {
    -- how many members can be in a crew in total
    maxMembers = 20,
    -- how much it costs to create a crew
    createCost = 10000,
}

-- the settings for all crew battles
SvConfig.CrewBattleSettings = {
    -- how long until a crew battle starts
    waitTime = 60 * 60, -- [[ seconds ]]
    -- min and max of the total amount of laps
    lapCount = { 1, 3 },
    -- reverse start and end checkpoint chance (0 - 100)
    reverseChance = 0,
    -- ghost chance (0 - 100)
    ghostChance = 100,
    -- how long to startup after 2 players readying up
    startAfterReady = 5 * 60 -- [[ seconds ]]
}

SvConfig.SystemRaces = {
    -- min and max of the total amount of laps
    lapCount = { 2, 3 },
    -- the different chances of what classes are allowed in the race
    classes = {
        { name = "S", chance = 0.18 },
        { name = "A", chance = 0.70 },
        { name = "B", chance = 0.12 },
    },
    -- maximum amount of players than can join system races
    maxPlayers = 20,
    -- min amount of players than can join system races
    minPlayers = 4,
    -- ghost chance (0 - 100)
    ghostChance = 100,
    -- reverse start and end checkpoint chance (0 - 100)
    reverseChance = 0,
    -- min and max of the bid
    bid = { 200, 300 },
    -- min and max of the additional reward for the race
    additionalReward = { 800, 1200 },
     -- minimum average completion time
    minAverageTime = 10, -- [[ minutes]]
    -- maximum average completion time
    maxAverageTime = 20, -- [[ minutes]]
}

-- which cryptos are classified as currencies in racing
SvConfig.AllowedCrypto = {
    ["SCRIPT"] = true,
    ["GG"] = true,
    ["TRJ"] = true,
    ["RACE"] = true
}

-- how long players have until they recieve a DNF once the DNF stage starts
SvConfig.DNFTime = 10 * 60 -- [[ seconds ]]

-- how long each racing season lasts
SvConfig.SeasonLength = 31 * 24 * 3600 -- [[ seconds ]]

-- what requirements are needed for race rewards (it validates automatically if ranked)
SvConfig.RewardValidation = {
    minPlayers = 4,
    minTime = 5 * 60,
    minCheckpoints = 0,
    requireVerifiedTrack = true
}

SvConfig.GiveRepRewards = true
SvConfig.RepRewards = {
    ranked = {
        { type = "civ", amount = 10 },
        { type = "crime", amount = 100 }
    },
    standard = {
        { type = "civ", amount = 10 },
        { type = "crime", amount = 25 }
    }
}

-- how rewards are split between race positions
SvConfig.RewardSplit = {
    [1] = {
        1.0
    },
    [2] = {
        0.6,
        0.4,
    },
    [3] = {
        0.5,
        0.3,
        0.2
    }
}

--- Reward multiplier based on the vehicle class the player used in the race
--- @type table<string, number>
SvConfig.VehicleClassRewardMultiplier = {
    ['S'] = 1.20,
    ['A'] = 1.15,
    ['B'] = 1.10,
    ['C'] = 1.05,
    ['D'] = 1.0,
    ['OPEN'] = 1.0,
    ['default'] = 1.0,
}

-- additional rewards for different positions
SvConfig.AdditionalRewards = {
    [1] = {
        currency = "RACE",
        amount = 30,
    },
    [2] = {
        currency = "RACE",
        amount = 25,
    },
    [3] = {
        currency = "RACE",
        amount = 20,
    },
    ["default"] = {
        currency = "RACE",
        amount = 15,
    }
}

-- how much money is given for different positions
SvConfig.MoneyReward = {
    [1] = 4, -- first place
    [2] = 3, -- second place
    [3] = 2, -- third place
    ["default"] = 1 -- default, all other places
}

-- the chance that someone recieves a case if they have recieved a race reward
SvConfig.CaseRewardChance = 25 -- [[ 0 - 1000 ]]

-- the reward data for racers daily case
SvConfig.DailyCase = {
    resetHour = 0,
    maxRaces = 9,
    rewards = {
        {
            type = "case",
            name = "case",
            count = 1,
            metaData = {
                caseId = "RACING_CASE",
            },
            racesRequired = 2,
        },
        {
            type = "case",
            name = "case",
            count = 1,
            metaData = {
                caseId = "RACING_CASE",
            },
            racesRequired = 5,
        },
        {
            type = "case",
            name = "case",
            count = 1,
            metaData = {
                caseId = "RACING_CASE",
            },
            racesRequired = 7,
        },
    }
}

SvConfig.PinkSlips = {
    -- where they redeem pinkslips
    redeem = vector4(1223.820, -2935.577, 5.866, 92.658),
    -- how much it costs to redeem a pinkslip
    process = { currency = "RACE", amount = 120 }
}

-- what cdns are allowed for profile picture uploading
SvConfig.AllowedCDNs = {
    "i.file.glass",
    "dropbox.com",
    "c.tenor.com",
    "upload.wikipedia.org",
    "upcdn.io",
    "i.fivemanage.com",
    "api.fivemanage.com",
    "r2.fivemanage.com",
    "imgbb.com",
    "i.ibb.co",
    "postimg.cc",
    "i.postimg.cc",
    "i.fmfile.com",
    "fmapi.net",
    "kappa.lol"
}

-- the change that police will recieve a dispatch alert
SvConfig.PoliceDispatchChance = 0.50

-- the chance that police will have time to respond before a race starts
SvConfig.GivePoliceTimeToReactChance = 0.5

-- how far away from the race in travel time dispatch blip coords will be
SvConfig.PoliceReactTime = 120 -- [[ seconds]]

SvConfig.DispatchAlerts = {
    -- either starting or willHappen based on SvConfig.GivePoliceTimeToReactChance
    willHappen = {
        jobs = { "gsp" },
        code = '10-35',
        title = locale("ILLEGAL_RACE"),
        description = locale("SOMEONE_REPORTED_AN_ILLEGAL_RACE_WILL_HAPPEN"),
        blip = {
            sprite = 38,
            scale = 1.2,
            colour = 24,
            duration = (60 * 5), -- [[ minutes ]],
            flash = true,
        },
    },
    starting = {
        jobs = { "gsp" },
        code = '10-35',
        title = locale("ILLEGAL_RACE"),
        description = locale("SOMEONE_REPORTED_AN_ILLEGAL_RACE_STARTING"),
        blip = {
            sprite = 38,
            scale = 1.2,
            colour = 24,
            duration = (60 * 5), -- [[ minutes ]],
            flash = true,
        },
    }
}

SvConfig.SeasonRewards = {
    [1] = { -- season one
        [1] = { -- first place
            {
                type = "item",
                name = "money",
                count = 50000
            },
            {
                type = "item",
                name = "meth",
                count = 1,
                metaData = {
                    batchName = "Super Delic",
                    batchQuality = 100
                }
            }
        },
        [2] = { -- second place
            {
                type = "item",
                name = "money",
                count = 25000
            },
        },
        [3] = { -- third place
            {
                type = "item",
                name = "money",
                count = 5000
            },
        },
    }
}
