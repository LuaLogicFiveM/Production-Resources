Config = {}

Config.StorageLocations = {
    vector4(503.5327, -1397.1685, 30.5507, 8.1614),
    vector4(316.2327, -1027.0244, 29.2097, 13.5518),
    vector4(1094.5809, -266.0084, 69.3137, 149.9117),
    vector4(914.1897, 3567.2930, 33.7935, 93.6738),
    vector4(2554.3579, 4667.7334, 33.9994, 205.8562),
    vector4(44.0818, 6461.2534, 31.4253, 51.0104)
}

Config.StorageLocation = Config.StorageLocations[1]

Config.StorageUnit = {
    price = 10000,
    capacity = 10,
    weight = 50,
    label = "Storage Unit",
    icon = "fas fa-box"
}

Config.UpgradeLevels = {
    {
        level = 1,
        slots = 10,
        weight = 50,
        price = 0
    },
    {
        level = 2,
        slots = 15,
        weight = 100,
        price = 250000
    },
    {
        level = 3,
        slots = 25,
        weight = 200,
        price = 500000
    },
    {
        level = 4,
        slots = 35,
        weight = 300,
        price = 750000
    },
    {
        level = 5,
        slots = 45,
        weight = 400,
        price = 1000000
    }
}

Config.Target = {
    radius = 2.0,
    icon = "fas fa-box",
    label = "Storage Units"
}

Config.LocationSettings = {
    enableLocationSpecificPricing = true,
    locationPriceMultipliers = {
        [1] = 1.0,
        [2] = 1.0
    }
}

Config.Blip = {
    sprite = 369,
    display = 4,
    scale = 0.6,
    colour = 5,
    shortRange = true,
    name = "Storage Units"
}

Config.UI = {
    title = "Storage Management",
    theme = "dark"
}

Config.TableName = "5mg_storages"

Config.Stash = {
    prefix = "storage_unit_",
    label = "Storage Unit"
}