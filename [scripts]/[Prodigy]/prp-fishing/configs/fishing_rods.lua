DefaultFishingMinigame = function()
    return bridge.minigames.play("fishing", {
        fishCount = math.random(1, 3),
        fishSpeed = math.random(20, 40) / 100,
        hoverTime = math.random(5200, 7200),
        timeMargin = 3000,
    })
end

FishingRods = {
    basic_fishing_rod = {
        label = locale("BASIC_FISHING_ROD"),
        weight = 0.8,

        rarity = "UNCOMMON",

        model = `pr_fishingrod_01`,

        consume = 0.01,

        minigame = function()
            return bridge.minigames.play("fishing", {
                fishCount = math.random(1, 3),
                fishSpeed = math.random(20, 40) / 100,
                hoverTime = math.random(5200, 7200),
                timeMargin = 3000,
            })
        end,
    },
    sport_fishing_rod = {
        label = locale("SPORT_FISHING_ROD"),
        weight = 1.0,

        rarity = "RARE",

        model = `pr_fishingrod_03`,

        consume = 0.005,

        minigame = function()
            return bridge.minigames.play("fishing", {
                fishCount = math.random(1, 3),
                fishSpeed = math.random(20, 40) / 100,
                hoverTime = math.random(5200, 7200),
                timeMargin = 3000,
            })
        end,
    },
    professional_fishing_rod = {
        label = locale("PROFESSIONAL_FISHING_ROD"),
        weight = 1.2,

        rarity = "EPIC",

        model = `pr_fishingrod_06`,

        consume = 0.002,

        minigame = function()
            return bridge.minigames.play("fishing", {
                fishCount = math.random(1, 3),
                fishSpeed = math.random(20, 40) / 100,
                hoverTime = math.random(5200, 7200),
                timeMargin = 3000,
            })
        end,
    },
    prodigy_fishing_rod = {
        label = locale("PRODIGY_FISHING_ROD"),
        weight = 1.4,

        rarity = "EPIC",

        model = `pr_fishingrod_02`,

        consume = 0.0015,

        minigame = function()
            return bridge.minigames.play("fishing", {
                fishCount = math.random(1, 3),
                fishSpeed = math.random(20, 40) / 100,
                hoverTime = math.random(5200, 7200),
                timeMargin = 3000,
            })
        end,
    },
    aqua_fishing_rod = {
        label = locale("AQUA_FISHING_ROD"),
        weight = 1.5,

        rarity = "EPIC",

        model = `pr_fishingrod_04`,

        consume = 0.0015,

        minigame = function()
            return bridge.minigames.play("fishing", {
                fishCount = math.random(1, 3),
                fishSpeed = math.random(20, 40) / 100,
                hoverTime = math.random(5200, 7200),
                timeMargin = 3000,
            })
        end,
    },
    sunset_fishing_rod = {
        label = locale("SUNSET_FISHING_ROD"),
        weight = 1.5,

        rarity = "EPIC",

        model = `pr_fishingrod_05`,

        consume = 0.0015,

        minigame = function()
            return bridge.minigames.play("fishing", {
                fishCount = math.random(1, 3),
                fishSpeed = math.random(20, 40) / 100,
                hoverTime = math.random(5200, 7200),
                timeMargin = 3000,
            })
        end,
    },
    golden_fishing_rod = {
        label = locale("GOLDEN_FISHING_ROD"),
        weight = 1.5,

        rarity = "LEGENDARY",

        model = `pr_fishingrod_07`,

        consume = 0.001,

        minigame = function()
            return bridge.minigames.play("fishing", {
                fishCount = math.random(1, 3),
                fishSpeed = math.random(20, 40) / 100,
                hoverTime = math.random(5200, 7200),
                timeMargin = 3000,
            })
        end,
    }
}
