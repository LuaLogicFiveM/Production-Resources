local Config = {}


-- "fivem-appearance", "illenium-appearance", or "bl-appearance"
Config.HandlerAppearance = "illenium-appearance"


Config.BagData = {
    {
        itemName = "outfitbag",
        propName = "prop_cs_heist_bag_02",
        maxSlot = 4,
    }
}

-- Only get components (clothes) and props (accessories) to prevent Change model/headblend ecc

Config.GetSkin = function(Ped)
    local Components = exports[Config.HandlerAppearance]:getPedComponents(Ped)
    local Props = exports[Config.HandlerAppearance]:getPedProps(Ped)
    return { Components = Components, Props = Props }
end


Config.SetSkin = function(Ped, skin)
    local Components = skin.Components
    local Props = skin.Props
    exports[Config.HandlerAppearance]:setPedComponents(Ped, Components)
    exports[Config.HandlerAppearance]:setPedProps(Ped, Props)
end

-- Prevent Opening Bag when player is dead
Config.DeatCheck = function(ped)
    return LocalPlayer.state.dead
end

return Config
