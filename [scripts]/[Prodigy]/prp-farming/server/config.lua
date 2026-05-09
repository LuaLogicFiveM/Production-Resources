lib.locale()

SvConfig = {}

SvConfig.Logs = {
     -- logs regarding open world drug farming
    pots = {
        placedPot = true,
        pickupPot = true,
        waterPot = true,
        fertilizePot = true,
        harvestCrops = true,
        removeDeadCrops = true,
        seedPlanted = true,
        webhook = ""
    }
}

SvConfig.Shop = {
    label = locale("SEEDS_SHOP_LABEL"),
    items = {
        { name = "seeds_grape", price = 2 },
        { name = "seeds_cucumber", price = 2 },
        { name = "seeds_eggplant", price = 2 },
        { name = "seeds_lettuce", price = 2 },
        { name = "seeds_onion", price = 2 },
        { name = "seeds_potato", price = 2 },
        { name = "seeds_strawberry", price = 2 },
        { name = "seeds_watermelon", price = 2 },
        { name = "seeds_banana", price = 2 },
        { name = "seeds_apple", price = 2 },
        { name = "seeds_tomato", price = 2 },
        { name = "seeds_wheat", price = 2 },
    }
}
