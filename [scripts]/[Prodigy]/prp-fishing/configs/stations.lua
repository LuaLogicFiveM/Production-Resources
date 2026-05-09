SellingStations = {
    {
        location = vector3(-1850.190, -1249.915, 8.616 - 1.0),
        heading = 320.256 - 180.0,

        animation = "WORLD_HUMAN_STAND_FISHING"
    },
    { -- sandy
        location = vector3(1561.8, 3801.4, 33.4),
        heading = 205.1
    },
}

FishingProfileNPC = {
    model = `a_m_m_hillbilly_02`,
    coords = vector3(-1853.5, -1243.8, 8.616 - 1.0),
    heading = 230.0,
    radius = 25.0,
    scenario = "WORLD_HUMAN_CLIPBOARD",

    blip = {
        sprite = 317,
        color = 3,
        scale = 1.0,
        label = locale("FISHING_BOARD")
    }
}
