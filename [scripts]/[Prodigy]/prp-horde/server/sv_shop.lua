RegisterNetEvent('prp-horde:server:currencyShop', function()
    local playerId = tonumber(source)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    game:openCurrencyShop(playerId)
end)

RegisterNetEvent('prp-horde:server:purchaseItem', function(itemId)
    local playerId = tonumber(source)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    game:purchaseItem(playerId, itemId)
end)

RegisterNetEvent('prp-horde:server:rerollShopSection', function(data)
    local playerId = tonumber(source)
    if not playerId then return end

    local game = getGame(playerId)

    if not game then
        return
    end

    if data.type == 'items' then
        game:buyShopRegeneration(playerId, data.sectionId)
    elseif data.type == 'perks' then
        game:buyPerksRegeneration(playerId)
    elseif data.type == 'supplies' then
        game:buyFinalShopRegeneration(playerId)
    end
end)
