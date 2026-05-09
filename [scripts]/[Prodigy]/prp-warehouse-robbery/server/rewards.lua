function GetRewards(lootRolls, lootTable)
    if not lootRolls then
        lootRolls = 1
    end

    local loot = exports['prp-bridge']:GenerateLoot(lootTable, lootRolls)

    local rewards = {}
    local metaDatas = {}

    for _, lootItem in ipairs(loot) do
        rewards[lootItem.name] = (rewards[lootItem.name] or 0) + lootItem.count
        if lootItem.metaData then
            metaDatas[lootItem.name] = lootItem.metaData
        end
    end

    return rewards, metaDatas
end

exports("GetRewards", GetRewards)

function GiveRewards(playerId, lootRolls, lootTable)
    if not lootRolls then
        lootRolls = 1
    end

    local nothingRolled = false
    local cashRolled = false

    local loot = exports['prp-bridge']:GenerateLoot(lootTable, lootRolls)

    for _, lootItem in ipairs(loot) do
        bridge.inv.giveItem(playerId, lootItem.name, lootItem.count)
    end

    return nothingRolled, cashRolled
end