local allFishes = {}

for fish, data in pairs(FishingLoot) do
    for _, size in pairs(FishingKinds) do
        if data.price then
            local fishName = ("%s_%s"):format(size, fish)
            allFishes[fishName] = {
                label = data.label,
                price = data.price,
            }
        end
    end
end

RegisterNetEvent("prp-fishing:openSellStash", function()
    local source = source

    exports['prp-bridge']:RegisterSellShop(
        'fishing',
        {
            label = locale("SELL_FISH"),
            items = allFishes
        }
    )

    exports['prp-bridge']:OpenSellShop(source, 'fishing')
end)
