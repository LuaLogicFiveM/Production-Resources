SvConfig = {}

SvConfig.MaxPedsPerOutpost = 4

-- money item for being given when selling drugs
SvConfig.PaymentItem = "cash"

SvConfig.DealerStash = {
    maxSlots = 4,
    maxWeight = 10000.0
}

SvConfig.RotationInterval = 20 * 60  -- [[ seconds ]]
SvConfig.SellingInterval = 60 -- [[ seconds ]]

-- list of all items that are supported as payment
SvConfig.MoneyItems = {
    "cash",
    "money"
}

-- how much each item you can sell is worth
SvConfig.MoneyWorth = {
    ["ruby"] = 137
}

-- min and max of each item per item that can be sold in `SvConfig.MoneyWorth`
SvConfig.MoneyCounts = {
    ["ruby"] = { 1, 2 }
}

SvConfig.DrugItems = {
    {
        name = "weed_1a",

        min = { 12, 12 }, -- Randomized between these two for minimum
        max = { 25, 35 }, -- Randomized between these two for maximum

        maxPerOffer = 3   -- Maximum amount of this drug that can be offered at once.
    },
    {
        name = "weed_2a",

        min = { 10, 15 }, -- Randomized between these two for minimum
        max = { 25, 45 }, -- Randomized between these two for maximum

        maxPerOffer = 3   -- Maximum amount of this drug that can be offered at once.
    },
    {
        name = "weed_2b",

        min = { 10, 15 }, -- Randomized between these two for minimum
        max = { 25, 45 }, -- Randomized between these two for maximum

        maxPerOffer = 3   -- Maximum amount of this drug that can be offered at once.
    },
    {
        name = "joint_1a",

        min = { 35, 39 }, -- Randomized between these two for minimum
        max = { 45, 53 }, -- Randomized between these two for maximum

        maxPerOffer = 3   -- Maximum amount of this drug that can be offered at once.
    },
    {
        name = "joint_1b",

        min = { 35, 39 }, -- Randomized between these two for minimum
        max = { 45, 53 }, -- Randomized between these two for maximum

        maxPerOffer = 3   -- Maximum amount of this drug that can be offered at once.
    },
    {
        name = "joint_2a",

        min = { 50, 54 }, -- Randomized between these two for minimum
        max = { 55, 59 }, -- Randomized between these two for maximum

        maxPerOffer = 3   -- Maximum amount of this drug that can be offered at once.
    },
    {
        name = "joint_2b",

        min = { 50, 54 }, -- Randomized between these two for minimum
        max = { 55, 59 }, -- Randomized between these two for maximum

        maxPerOffer = 3   -- Maximum amount of this drug that can be offered at once.
    },
    {
        name = "joint_2c",

        min = { 50, 54 }, -- Randomized between these two for minimum
        max = { 55, 59 }, -- Randomized between these two for maximum

        maxPerOffer = 3   -- Maximum amount of this drug that can be offered at once.
    },
    {
        name = "meth",
        durability = { 1, 25 },
        min = {
            24, 29
        },
        max = {
            28, 33
        },

        maxPerOffer = 3
    },
    {
        name = "meth",
        durability = { 26, 50 },
        min = {
            43, 47
        },
        max = {
            48, 53
        },

        maxPerOffer = 3
    },
    {
        name = "meth",
        durability = { 51, 75 },
        min = {
            69, 74
        },
        max = {
            73, 79
        },

        maxPerOffer = 3
    },
    {
        name = "meth",
        durability = { 76, 99 },
        min = {
            100, 105
        },
        max = {
            108, 115
        },

        maxPerOffer = 3
    },
    {
        name = "meth",
        durability = { 100, 100 },
        min = {
            135, 145
        },
        max = {
            143, 152
        },

        maxPerOffer = 3
    },
    {
        name = "cocaine",
        min = {
            260, 275
        },
        max = {
            280, 300
        },

        maxPerOffer = 3
    }
}

SvConfig.Rep = {
    enabled = true,
    type = "crime",
    amount = 5
}

SvConfig.DispatchAlert = {
    jobs = { "gsp" },
    code = "10-90",
    title = locale("DRUG_SALE_ALERT_TEXT"),
    description = locale("DRUG_SALE_ALERT_BODY_TEXT"),
    blip = {
        sprite = 514,
        scale = 1.5,
        colour = 25,
        duration = (30 * 5), -- [[ seconds ]]
    },
}
