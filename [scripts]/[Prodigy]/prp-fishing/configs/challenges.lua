DailyChallenges = 3 -- Number of daily challenges to generate
DailyChallengesResetCommand = "resetfishingchallenges"

---@type string[]
ChallengeTypes = {
    "CATCH_X_AMOUNT",
    "CATCH_X_AMOUNT_Y",
    "CATCH_X_WEIGHT",
}

---@class Challenge
---@field label string
---@field steps table The amount needed, it will take randomly.
---@field reward table The reward for completing the challenge. It will take one of those random every time the challenge generates.
---@field description string

---@type table<string, Challenge>
Challenges = {
    CATCH_X_AMOUNT = {
        label = locale("CATCH_X_AMOUNT_LABEL"),
        description = locale("CATCH_X_AMOUNT_DESC"),

        steps = {
            5, 10, 15, 20, 25
        },

        reward = {
            250, 500, 1000, 1250, 1500
        }
    },
    CATCH_X_AMOUNT_Y = {
        label = locale("CATCH_X_AMOUNT_Y_LABEL"),
        description = locale("CATCH_X_AMOUNT_Y_DESC"),

        steps = {
            5, 10, 15, 20, 25
        },

        reward = {
            250, 500, 1000, 1250, 1500
        }
    },
    CATCH_X_WEIGHT = {
        label = locale("CATCH_X_WEIGHT_LABEL"),
        description = locale("CATCH_X_WEIGHT_DESC"),

        steps = {
            5, 7, 8, 9, 10
        },

        reward = {
            250, 400, 650, 800, 1000
        }
    },
}

---@class ChallengeReward
---@field name string
---@field count number

---@type table<string, ChallengeReward[][]>
Rewards = {
    weekly = {
        {
            {
                name = "golden_fishing_rod",
                count = 1
            },
            {
                name = "money",
                count = 2000
            }
        },
        {
            {
                name = "sunset_fishing_rod",
                count = 1
            },
            {
                name = "money",
                count = 1500
            }
        },
        {
            {
                name = "money",
                count = 1000
            }
        }
    },
    monthly = {
        {
            {
                name = "trophy",
                count = 1
            },
            {
                name = "golden_fishing_rod",
                count = 1
            },
            {
                name = "money",
                count = 5000
            }
        },
        {
            {
                name = "golden_fishing_rod",
                count = 1,
            },
            {
                name = "money",
                count = 4000
            }
        },
        {
            {
                name = "prodigy_fishing_rod",
                count = 1
            },
            {
                name = "money",
                count = 3000
            }
        }
    }
}

if IsDuplicityVersion() then
    local excludeDailyFishes = {
        ["jellyfish"] = true,
        ["jellyfish_orange"] = true,
        ["jellyfish_red"] = true,
        ["jellyfish_green"] = true,
        ["jellyfish_pink"] = true,
        ["jellyfish_purple"] = true,
        ["jellyfish_rainbow"] = true,
    }

    ChallengeGenerations = {
        CATCH_X_AMOUNT = function(data)
            local randomAmount = data.steps[math.random(1, #data.steps)]

            return {
                amount = randomAmount
            }
        end,
        CATCH_X_AMOUNT_Y = function(data)
            local randomAmount = data.steps[math.random(1, #data.steps)]
            local randomFish = Fishes[math.random(1, #Fishes)]

            if excludeDailyFishes[randomFish] or randomFish:match("_rad") then
                return ChallengeGenerations.CATCH_X_AMOUNT_Y(data)
            end

            return {
                amount = randomAmount,
                fish = randomFish
            }
        end,
        CATCH_X_WEIGHT = function(data)
            local randomWeight = data.steps[math.random(1, #data.steps)]

            return {
                amount = randomWeight
            }
        end
    }
end