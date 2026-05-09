CreateThread(function()
    local harvestableCrops = {}
    for itemName, itemData in pairs(Config.Seeds) do
        local item = bridge.inv.getItemData(itemName) or {}
        harvestableCrops[itemName] = {
            label = item.label or itemName,
            price = itemData.sellPrice
        }
    end

    exports['prp-bridge']:RegisterSellShop(
        "farm_sell_shop",
        {
            label = locale("FARMING_SELL_SHOP_LABEL"),
            items = harvestableCrops
        }
    )
end)

RegisterNetEvent("prp-farming:server:useSellShop", function()
    local src = source
    local ped = GetPlayerPed(src)
    if not ped or not DoesEntityExist(ped) then return end

    local pedCoords = GetEntityCoords(ped, false)
    if #(pedCoords - Config.Peds.main.pos.xyz) > 10.0 then return end

    exports["prp-bridge"]:OpenSellShop(src, "farm_sell_shop")
end)