Debug = false

BootLoot = {
    { 35, { name = "scrapmetal", min = 1, max = 2 } },
    { 20, { name = "rubber", min = 1, max = 3 } },
    { 15, { name = "goldcoins", min = 3, max = 7 } },
    { 10, { name = "ring", min = 2, max = 5 } },
}

FishingItems = {
    meat = "fish_meat"
}

FishingKinds = {
    "small",
    "medium",
    "large"
}

FishingBaits = {
    worm = 'fishing_bait_worm',
    fish = 'fishing_bait_fish',
    radiated = 'fishing_bait_radiated',
    boot = 'fishing_boot',
}

FishingBootItem = 'fishing_boot'

FishingTrophyMonths = {
    "january", "february", "march", "april", "may", "june",
    "july", "august", "september", "october", "november", "december"
}

FishingTrophies = {}
for _, month in ipairs(FishingTrophyMonths) do
    local itemName = "pr_trophy_fish_" .. month
    FishingTrophies[itemName] = {
        label = "Fishing Trophy (" .. month:sub(1, 1):upper() .. month:sub(2) .. ")",
        model = joaat(itemName),
    }
end

FishingDefaultLoot = 'Freshwater'
FishingLootTables = {
    Freshwater = {
        trash = {
            "fishing_boot",
            "plastic_cup"
        },
        common = {
            "small_bullhead",
            "small_carp",
            "small_catfish",
            "small_perch",
            "small_rainbow_trout"
        },
        uncommon = {
            "medium_carp",
            "medium_catfish",
            "medium_perch",
            "medium_rainbow_trout",
            "small_bullhead",
            "small_northern_pike"
        },
        rare = {
            "large_carp",
            "large_catfish",
            "large_perch",
            "large_rainbow_trout",
            "medium_bullhead",
            "medium_northern_pike"
        },
        very_rare = {
            "large_bullhead",
            "large_northern_pike",
            "large_jellyfish",
            "large_jellyfish_orange",
            "large_jellyfish_red",
            "large_jellyfish_green",
            "large_jellyfish_pink",
            "large_jellyfish_purple",
            "large_jellyfish_rainbow",
        },
        treasure = {
            "case"
        }
    },
    Saltwater = {
        trash = {
            "fishing_boot",
            "plastic_cup"
        },
        common = {
            "small_atlantic_croaker",
            "small_flounder",
            "small_red_mullet",
            "small_sardine",
            "small_atlantic_mackerel",
            "small_breamfish",
            "small_hake"
        },
        uncommon = {
            "medium_atlantic_croaker",
            "medium_flounder",
            "medium_red_mullet",
            "medium_sardine",
            "medium_atlantic_mackerel",
            "small_red_snapper",
            "small_striped_bass",
            "small_salmon",
            "medium_breamfish",
            "medium_hake",
            "small_drumfish",
            "small_coralgrouper"
        },
        rare = {
            "large_atlantic_croaker",
            "large_flounder",
            "large_red_mullet",
            "large_sardine",
            "large_atlantic_mackerel",
            "medium_red_snapper",
            "medium_striped_bass",
            "medium_salmon",
            "small_tuna",
            "large_breamfish",
            "large_hake",
            "medium_drumfish",
            "medium_coralgrouper",
            "small_barracuda",
            "medium_jellyfish",
            "medium_jellyfish_orange",
            "medium_jellyfish_red",
            "medium_jellyfish_green",
            "medium_jellyfish_pink",
            "medium_jellyfish_purple",
        },
        very_rare = {
            "large_red_snapper",
            "large_striped_bass",
            "large_salmon",
            "medium_tuna",
            "large_drumfish",
            "large_coralgrouper",
            "medium_barracuda",
            "large_jellyfish_rainbow",
            "medium_jellyfish_rainbow",
        },
        treasure = {
            "case"
        }
    },
    Radiated = {
        trash = {
            "fishing_boot",
            "plastic_cup"
        },
        common = {
            "small_atlantic_croaker_rad",
            "small_flounder_rad",
            "small_red_mullet_rad",
            "small_sardine_rad",
            -- "small_atlantic_mackerel_rad",
            "small_breamfish_rad",
            "small_hake_rad"
        },
        uncommon = {
            "medium_atlantic_croaker_rad",
            "medium_flounder_rad",
            "medium_red_mullet_rad",
            "medium_sardine_rad",
            -- "medium_atlantic_mackerel_rad",
            "small_red_snapper_rad",
            "small_striped_bass_rad",
            "small_salmon_rad",
            "medium_breamfish_rad",
            "medium_hake_rad",
            "small_drumfish_rad",
            "small_coralgrouper_rad",
            "small_barracuda_rad"
        },
        rare = {
            "medium_atlantic_croaker_rad",
            "medium_flounder_rad",
            "medium_red_mullet_rad",
            "medium_sardine_rad",
            -- "medium_atlantic_mackerel_rad",
            "small_red_snapper_rad",
            "small_striped_bass_rad",
            "small_salmon_rad",
            "medium_breamfish_rad",
            "medium_hake_rad",
            "small_drumfish_rad",
            "small_coralgrouper_rad",
            "small_barracuda_rad"
        },
        very_rare = {
            "medium_atlantic_croaker_rad",
            "medium_flounder_rad",
            "medium_red_mullet_rad",
            "medium_sardine_rad",
            -- "medium_atlantic_mackerel_rad",
            "small_red_snapper_rad",
            "small_striped_bass_rad",
            "small_salmon_rad",
            "medium_breamfish_rad",
            "medium_hake_rad",
            "small_drumfish_rad",
            "small_coralgrouper_rad",
            "small_barracuda_rad"
        },
        treasure = {
            "case"
        }
    }
}

--[[
    Freshwater Spots:
    Common Fish: 70% catch rate @ $4 each
            "small_bullhead",
            "small_carp",
            "small_catfish",
            "small_perch",
            "small_rainbow_trout"
    Uncommon Fish: 20% catch rate @ $8 ea
            "medium_carp",
            "medium_catfish",
            "medium_perch",
            "medium_rainbow_trout",
            "small_bullhead",
            "small_northern_pike"
    Rare Fish: 9% catch rate @ $15 ea
            "large_carp",
            "large_catfish",
            "large_perch",
            "large_rainbow_trout",
            "medium_bullhead",
            "medium_northern_pike"
    Very Rare: 1% catch rate @ $40
            "large_bullhead",
            "large_northern_pike"
    Rare Treasure: .1% catch rate

    Saltwater Spots:
    Common Fish: 76% catch rate @ $5 each
            "small_atlantic_croaker",
            "small_flounder",
            "small_red_mullet",
            "small_sardine",
            "small_atlantic_mackerel"
    Uncommon Fish: 20% catch rate @ $8 ea
    Rare Fish: 3% catch rate @ $15 ea
    Very Rare: 1% catch rate @ $40
    Rare Treasure: .1% catch rate
]]

--[[
    pr_atlantic_croaker
    pr_atlantic_mackerel
    pr_bullhead
    pr_carp
    pr_catfish
    pr_flounder
    pr_northern_pike
    pr_perch
    pr_rainbow_trout
    pr_red_mullet
    pr_red_snapper
    pr_salmon
    pr_sardine
    pr_striped_bass
    pr_tuna
]]

Prices = {
    Freshwater = {
        common = 16,
        uncommon = 20,
        rare = 40,
        very_rare = 75
    },
    Saltwater = {
        common = 16,
        uncommon = 20,
        rare = 40,
        very_rare = 75
    },
    Radiated = {
        common = 20,
        uncommon = 30,
        rare = 50,
        very_rare = 90
    }
}

FishingLoot = { -- adding a fish here will add small, medium, and large versions of it to the inventory.
    atlantic_croaker = {
        label = locale("ATLANTIC_CROAKER"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_atlantic_croaker`,

        rarity = "COMMON",

        price = 25, -- This is the base price of the fish, will go up/down depending on weight.
    },
    atlantic_mackerel = {
        label = locale("ATLANTIC_MACKEREL"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_atlantic_mackerel`,

        rarity = "COMMON",

        price = 25, -- This is the base price of the fish, will go up/down depending on weight.
    },
    bullhead = {
        label = locale("BULLHEAD"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_bullhead`,

        rarity = "COMMON",

        price = 30, -- This is the base price of the fish, will go up/down depending on weight.
    },
    carp = {
        label = locale("CARP"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_carp`,

        rarity = "COMMON",

        price = 25, -- This is the base price of the fish, will go up/down depending on weight.
    },
    catfish = {
        label = locale("CATFISH"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_catfish`,

        rarity = "COMMON",

        price = 30, -- This is the base price of the fish, will go up/down depending on weight.
    },
    flounder = {
        label = locale("FLOUNDER"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_flounder`,

        rarity = "COMMON",

        price = 25, -- This is the base price of the fish, will go up/down depending on weight.
    },
    northern_pike = {
        label = locale("NORTHERN_PIKE"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_northern_pike`,

        rarity = "COMMON",

        price = 25, -- This is the base price of the fish, will go up/down depending on weight.
    },
    perch = {
        label = locale("PERCH"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_perch`,

        rarity = "COMMON",

        price = 25, -- This is the base price of the fish, will go up/down depending on weight.
    },
    red_mullet = {
        label = locale("RED_MULLET"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_red_mullet`,

        rarity = "COMMON",

        price = 25, -- This is the base price of the fish, will go up/down depending on weight.
    },
    red_snapper = {
        label = locale("RED_SNAPPER"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_red_snapper`,

        rarity = "COMMON",

        price = 25, -- This is the base price of the fish, will go up/down depending on weight.
    },
    salmon = {
        label = locale("SALMON"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_salmon`,

        rarity = "COMMON",

        price = 25, -- This is the base price of the fish, will go up/down depending on weight.
    },
    sardine = {
        label = locale("SARDINE"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_sardine`,

        rarity = "COMMON",

        price = 35, -- This is the base price of the fish, will go up/down depending on weight.
    },
    striped_bass = {
        label = locale("STRIPED_BASS"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_striped_bass`,

        rarity = "COMMON",

        price = 35, -- This is the base price of the fish, will go up/down depending on weight.
    },
    tuna = {
        label = locale("TUNA"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_tuna`,

        rarity = "COMMON",

        price = 30, -- This is the base price of the fish, will go up/down depending on weight.
    },
    rainbow_trout = {
        label = locale("RAINBOW_TROUT"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_rainbow_trout`,

        rarity = "COMMON",

        price = 20, -- This is the base price of the fish, will go up/down depending on weight.
    },
    barracuda = {
        label = locale("BARRACUDA"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_barracuda`,

        rarity = "COMMON",

        price = 35, -- This is the base price of the fish, will go up/down depending on weight.
    },
    breamfish = {
        label = locale("BREAM_FISH"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_breamfish`,

        rarity = "COMMON",

        price = 25, -- This is the base price of the fish, will go up/down depending on weight.
    },
    coralgrouper = {
        label = locale("CORAL_GROUPE"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_coralgrouper`,

        rarity = "COMMON",

        price = 40, -- This is the base price of the fish, will go up/down depending on weight.
    },
    drumfish = {
        label = locale("DRUM_FISH"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_drumfish`,

        rarity = "COMMON",

        price = 30, -- This is the base price of the fish, will go up/down depending on weight.
    },
    hake = {
        label = locale("HAKE"),

        weight = { -- Min and max weight
            225,
            425
        },

        model = `pr_hake`,

        rarity = "COMMON",

        price = 20, -- This is the base price of the fish, will go up/down depending on weight.
    },
    jellyfish = {
        label = locale("JELLYFISH"),

        weight = { -- Min and max weight
            225,
            450
        },

        model = `pr_jellyfish`,

        rarity = "LEGENDARY",

        price = 70, -- This is the base price of the fish, will go up/down depending on weight.
    },
    jellyfish_orange = {
        label = locale("JELLYFISH_ORANGE"),

        weight = { -- Min and max weight
            225,
            450
        },

        model = `pr_jellyfish_orange`,

        rarity = "LEGENDARY",

        price = 70, -- This is the base price of the fish, will go up/down depending on weight.
    },
    jellyfish_red = {
        label = locale("JELLYFISH_RED"),

        weight = { -- Min and max weight
            225,
            450
        },

        model = `pr_jellyfish_red`,

        rarity = "LEGENDARY",

        price = 70, -- This is the base price of the fish, will go up/down depending on weight.
    },
    jellyfish_green = {
        label = locale("JELLYFISH_GREEN"),

        weight = { -- Min and max weight
            225,
            450
        },

        model = `pr_jellyfish_green`,

        rarity = "LEGENDARY",

        price = 70, -- This is the base price of the fish, will go up/down depending on weight.
    },
    jellyfish_pink = {
        label = locale("JELLYFISH_PINK"),

        weight = { -- Min and max weight
            225,
            450
        },

        model = `pr_jellyfish_pink`,

        rarity = "LEGENDARY",

        price = 70, -- This is the base price of the fish, will go up/down depending on weight.
    },
    jellyfish_purple = {
        label = locale("JELLYFISH_PURPLE"),

        weight = { -- Min and max weight
            225,
            450
        },

        model = `pr_jellyfish_purple`,

        rarity = "LEGENDARY",

        price = 70, -- This is the base price of the fish, will go up/down depending on weight.
    },
    jellyfish_rainbow = {
        label = locale("JELLYFISH_RAINBOW"),

        weight = { -- Min and max weight
            300,
            450
        },

        model = `pr_jellyfish_rainbow`,

        rarity = "LEGENDARY",

        price = 100, -- This is the base price of the fish, will go up/down depending on weight.
    },

    atlantic_croaker_rad = {
        label = locale("RADIATED_ATLANTIC_CROAKER"),
        weight = {
            225,
            425
        },
        model = `pr_atlantic_croaker_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    barracuda_rad = {
        label = locale("RADIATED_BARRACUDA"),
        weight = {
            225,
            425
        },
        model = `pr_barracuda_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    breamfish_rad = {
        label = locale("RADIATED_BREAM_FISH"),
        weight = {
            225,
            425
        },
        model = `pr_breamfish_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    bullhead_rad = {
        label = locale("RADIATED_BULLHEAD"),
        weight = {
            225,
            425
        },
        model = `pr_bullhead_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    carp_rad = {
        label = locale("RADIATED_CARP"),
        weight = {
            225,
            425
        },
        model = `pr_carp_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    catfish_rad = {
        label = locale("RADIATED_CATFISH"),
        weight = {
            225,
            425
        },
        model = `pr_catfish_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    coralgrouper_rad = {
        label = locale("RADIATED_CORAL_GROUPE"),
        weight = {
            225,
            425
        },
        model = `pr_coralgrouper_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    drumfish_rad = {
        label = locale("RADIATED_DRUM_FISH"),
        weight = {
            225,
            425
        },
        model = `pr_drumfish_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    flounder_rad = {
        label = locale("RADIATED_FLOUNDER"),
        weight = {
            225,
            425
        },
        model = `pr_flounder_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    hake_rad = {
        label = locale("RADIATED_HAKE"),
        weight = {
            225,
            425
        },
        model = `pr_hake_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    northern_pike_rad = {
        label = locale("RADIATED_NORTHERN_PIKE"),
        weight = {
            225,
            425
        },
        model = `pr_northern_pike_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    perch_rad = {
        label = locale("RADIATED_PERCH"),
        weight = {
            225,
            425
        },
        model = `pr_perch_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    rainbow_trout_rad = {
        label = locale("RADIATED_RAINBOW_TROUT"),
        weight = {
            225,
            425
        },
        model = `pr_rainbow_trout_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    red_mullet_rad = {
        label = locale("RADIATED_RED_MULLET"),
        weight = {
            225,
            425
        },
        model = `pr_red_mullet_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    red_snapper_rad = {
        label = locale("RADIATED_RED_SNAPPER"),
        weight = {
            225,
            425
        },
        model = `pr_red_snapper_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    salmon_rad = {
        label = locale("RADIATED_SALMON"),
        weight = {
            225,
            425
        },
        model = `pr_salmon_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    sardine_rad = {
        label = locale("RADIATED_SARDINE"),
        weight = {
            225,
            425
        },
        model = `pr_sardine_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    striped_bass_rad = {
        label = locale("RADIATED_STRIPED_BASS"),
        weight = {
            225,
            425
        },
        model = `pr_striped_bass_rad`,

        rarity = "UNCOMMON",

        price = 35,
    },
    tuna_rad = {
        label = locale("RADIATED_TUNA"),
        weight = {
            225,
            425
        },
        model = `pr_tuna_rad`,

        rarity = "UNCOMMON",
        
        price = 35,
    },
}

Fishes = {}

for fish in pairs(FishingLoot) do
    table.insert(Fishes, fish)
end

DefaultFishingLoot = { -- This is the loot table when you're outside of a zone.
    {
        table = "trash",
        chance = 5
    },
    {
        table = "common",
        chance = 55
    },
    {
        table = "uncommon",
        chance = 40
    }
}


FreshwaterLoot = {
    {
        table = "treasure",
        chance = 1
    },
    {
        table = "very_rare",
        chance = 10
    },
    {
        table = "rare",
        chance = 90
    },
    {
        table = "uncommon",
        chance = 200
    },
    {
        table = "common",
        chance = 700
    }
}

SaltwaterLoot = {
    {
        table = "treasure",
        chance = 1
    },
    {
        table = "very_rare",
        chance = 9
    },
    {
        table = "rare",
        chance = 30
    },
    {
        table = "uncommon",
        chance = 200
    },
    {
        table = "common",
        chance = 760
    }
}
