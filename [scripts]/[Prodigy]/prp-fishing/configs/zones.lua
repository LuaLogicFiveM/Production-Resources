-- If true, players can fish outside designated zones with reduced loot (common/uncommon only).
-- If false, players must be inside a fishing zone to fish.
AllowFishingOutsideZones = true

-- If true, fishing zone blips are always shown on the map. Disables the toggle blips event.
AlwaysShowFishingZones = true

-- Minimum time (in milliseconds) a fishing attempt must take before the server accepts it.
-- Helps prevent client-side exploits that skip the minigame. Default: 10000 (10 seconds).
MinimumFishingTime = 10000

FishingZones = {
    -- {
    --     name = locale("HUGE_FRESHWATER"),

    --     coords = vector3(1769.583, 4501.276, 30.805),

    --     radius = 150.0,

    --     bait = "fishing_bait_worm",

    --     loot = FreshwaterLoot,
    --     zone = "Freshwater",
    --     showBlip = true, -- If true, the blip for this zone is always shown on the map regardless of the global toggle.
    -- },
    {
        name = locale("SMALL_FRESHWATER"),

        coords = vector3(-207.013, 4320.982, 30.718),

        radius = 65.0,

        bait = "fishing_bait_worm",

        loot = FreshwaterLoot,
        zone = "Freshwater"
    },
    {
        name = locale("HUGE_FRESHWATER"),

        coords = vector3(-150.925, 3849.602, 30.610),

        radius = 150.0,

        bait = "fishing_bait_worm",

        loot = FreshwaterLoot,
        zone = "Freshwater"
    },
    {
        name = locale("LARGE_FRESHWATER"),

        coords = vector3(-2103.868, 2613.665, 0.879),

        radius = 90.0,

        bait = "fishing_bait_worm",

        loot = FreshwaterLoot,
        zone = "Freshwater"
    },
    {
        name = locale("SMALL_FRESHWATER"),

        coords = vector3(2560.984, 6172.700, 161.987),

        radius = 65.0,

        bait = "fishing_bait_worm",

        loot = FreshwaterLoot,
        zone = "Freshwater"
    },
    {
        name = locale("HUGE_FRESHWATER"),

        coords = vector3(1893.198, 248.417, 161.288),

        radius = 150.0,

        bait = "fishing_bait_worm",

        loot = FreshwaterLoot,
        zone = "Freshwater"
    },
    {
        name = locale("LARGE_FRESHWATER"),

        coords = vector3(1173.247, -179.040, 53.642),

        radius = 90.0,

        bait = "fishing_bait_worm",

        loot = FreshwaterLoot,
        zone = "Freshwater"
    },
    {
        name = locale("SMALL_FRESHWATER"),

        coords = vector3(1139.150, -716.836, 56.739),

        radius = 65.0,

        bait = "fishing_bait_worm",

        loot = FreshwaterLoot,
        zone = "Freshwater"
    },
    {
        name = locale("HUGE_SALTWATER"),

        coords = vector3(-3390.153, 963.596, 9.346),

        radius = 150.0,

        bait = "fishing_bait_lugworm",

        loot = SaltwaterLoot,
        zone = "Saltwater"
    },
    {
        name = locale("HUGE_SALTWATER"),

        coords = vector3(-3032.493, 3540.548, 0.803),

        radius = 150.0,

        bait = "fishing_bait_lugworm",

        loot = SaltwaterLoot,
        zone = "Saltwater"
    },
    {
        name = locale("HUGE_SALTWATER"),

        coords = vector3(-1750.265, 4964.447, 1.062),

        radius = 150.0,

        bait = "fishing_bait_lugworm",

        loot = SaltwaterLoot,
        zone = "Saltwater"
    },
    {
        name = locale("HUGE_SALTWATER"),

        coords = vector3(-1600.122, 5242.907, 3.974),

        radius = 150.0,

        bait = "fishing_bait_lugworm",

        loot = SaltwaterLoot,
        zone = "Saltwater"
    },
    {
        name = locale("HUGE_SALTWATER"),

        coords = vector3(-284.643, 6626.945, 7.135),

        radius = 150.0,

        bait = "fishing_bait_lugworm",

        loot = SaltwaterLoot,
        zone = "Saltwater"
    },
    {
        name = locale("LARGE_SALTWATER"),

        coords = vector3(3225.024, 5334.405, 2.256),

        radius = 90.0,

        bait = "fishing_bait_lugworm",

        loot = SaltwaterLoot,
        zone = "Saltwater"
    },
    {
        name = locale("HUGE_SALTWATER"),

        coords = vector3(-1789.023, -1159.033, 13.032),

        radius = 150.0,

        bait = "fishing_bait_lugworm",

        loot = SaltwaterLoot,
        zone = "Saltwater"
    },
    { -- sandy
        name = locale("HUGE_FRESHWATER"),

        coords = vector3(1481.056, 3873.224, 33.907),

        radius = 150.0,

        bait = "fishing_bait_worm",

        loot = FreshwaterLoot,
        zone = "Freshwater"
    },
    -- {
    --     name = locale("RADIATED_WATER"),

    --     coords = vector3(1699.957, 4470.694, 30.670),

    --     radius = 75.0,

    --     bait = "fishing_bait_radiated",

    --     loot = SaltwaterLoot,
    --     zone = "Radiated"
    -- }
}
