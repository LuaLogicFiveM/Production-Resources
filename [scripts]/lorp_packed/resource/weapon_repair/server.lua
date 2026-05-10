local ox_inventory = exports.ox_inventory

RegisterNetEvent('lorp_repair_bench:server:finishRepair', function(data)
    local s = source

    data.weapon.metadata.repairs = (data.weapon.metadata.repairs or 0) + 1
    ox_inventory:SetMetadata(s, data.weapon.slot, data.weapon.metadata)

    local degrade = (data.weapon.metadata.repairs * 5)

    ox_inventory:SetDurability(s, data.weapon.slot, 100-degrade)
    lib.notify(s, {title = 'Repair Bench', description = 'This weapon has been repaired to its optimal coniditon', type = 'success', position = 'top'})
end)

RegisterNetEvent('lorp_repair_bench:server:repair', function(data)
    local s = source
    local dura = data.weapon.metadata.durability
    local repairs = data.weapon.metadata.repairs or 0

    if dura >= 100 then
        return lib.notify(s, {title = 'Repair Bench', description = 'This weapon durability is at the limit', type = 'error', position = 'top'})
    end

    if repairs >= 3 then
        return lib.notify(s, {title = 'Repair Bench', description = 'This weapon has hit the maximum repair limit', type = 'error', position = 'top'})
    end

    local missingParts = {}
    local takeParts = {}

    for _, repairParts in ipairs(data.dat.required) do
        local hasItem = false
        local count = ox_inventory:Search(s, 'count', repairParts.item)
        if count >= repairParts.count then
            hasItem = true
        end
        if not hasItem then
            table.insert(missingParts, repairParts.count .. "x " .. repairParts.item)
        else
            takeParts[repairParts.item] = repairParts.count
        end
    end

    if #missingParts > 0 then
        local partsNeeded = table.concat(missingParts, ". ")
        return lib.notify(s, {title = 'Repair Bench', description = 'You do not have the required items to repair this weapon. (' .. partsNeeded .. ')', type = 'error', position = 'top'})
    else
        for amount, item in pairs(takeParts) do
            ox_inventory:RemoveItem(s, item, amount)
        end
    end

    TriggerClientEvent('lorp_repair_bench:client:repair', s, data)
end)