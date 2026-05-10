---@diagnostic disable: duplicate-set-field
if GetResourceState('qb-inventory') == 'missing' then return end

local QBInventoryAPI = {}

local qbInventoryExport
local inventoryVersion
local inventoryStashes = {}
local inventoryShops = {}
local isInitialized = false

local function initializeQBInventory()
    if isInitialized then return true end
    if GetResourceState('qb-inventory') ~= 'started' then
        DebugPrint("QB-Inventory resource is not started", "error")
        return false
    end

    qbInventoryExport = exports['qb-inventory']
    if not qbInventoryExport then
        DebugPrint("Failed to get qb-inventory export", "error")
        return false
    end

    local metadata = GetResourceMetadata("qb-inventory", "version", 0)
    if metadata then
        local majorVersion = tonumber(string.sub(metadata, 1, 1))
        inventoryVersion = majorVersion and majorVersion >= 2
    else
        inventoryVersion = false
    end

    if config.Debug then
        DebugPrint("QB-Inventory version detected: " .. (inventoryVersion and "v2+" or "v1"), "info")
    end
    isInitialized = true
    return true
end

local function validateItemOperation(src, item, count, operation)
    if not src or not item or not count then
        DebugPrint(string.format("Invalid %s parameters: src=%s, item=%s, count=%s", operation, tostring(src), tostring(item), tostring(count)), "error")
        return false
    end

    if type(count) ~= "number" or count <= 0 then
        DebugPrint(string.format("Invalid count for %s: %s", operation, tostring(count)), "error")
        return false
    end

    return true
end

local function notifyPlayerInventoryUpdate(src, updateData)
    if not src or not updateData then return end

    TriggerClientEvent('grp_bridge:client:inventory:update', src, updateData)
end

local function processStashOperation(stashId, items, operation)
    if not stashId or not items then return false end

    if type(items) ~= "table" then
        DebugPrint("Invalid items parameter for stash operation", "error")
        return false
    end

    local successCount = 0
    for _, itemData in ipairs(items) do
        if operation == "add" then
            local success = qbInventoryExport:AddItem(stashId, itemData.item or itemData.name, itemData.count or itemData.amount or 1, nil, itemData.metadata or itemData.info)
            if success then successCount = successCount + 1 end
        elseif operation == "remove" then
            local success = qbInventoryExport:RemoveItem(stashId, itemData.item or itemData.name, itemData.count or itemData.amount or 1)
            if success then successCount = successCount + 1 end
        end
    end

    return successCount > 0
end

QBInventoryAPI.GetResourceName = function()
    return "qb-inventory"
end

QBInventoryAPI.AddItem = function(src, item, count, slot, metadata)
    if not initializeQBInventory() then return false end
    if not validateItemOperation(src, item, count, "AddItem") then return false end

    if inventoryVersion and not qbInventoryExport:CanAddItem(src, item, count) then
        if config.Debug then
            DebugPrint(string.format("Player %s cannot carry %d %s", src, count, item), "warning")
        end
        return false
    end

    local success = qbInventoryExport:AddItem(src, item, count, slot, metadata, "grp_bridge")
    if success then
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBInventoryAPI.GetItemInfo(item), 'add', count)
        notifyPlayerInventoryUpdate(src, {
            action = "add",
            item = item,
            count = count,
            slot = slot,
            metadata = metadata
        })
    end

    return success
end

QBInventoryAPI.RemoveItem = function(src, item, count, slot, metadata)
    if not initializeQBInventory() then return false end
    if not validateItemOperation(src, item, count, "RemoveItem") then return false end

    local success = qbInventoryExport:RemoveItem(src, item, count, slot, "grp_bridge")
    if success then
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBInventoryAPI.GetItemInfo(item), 'remove', count)
        notifyPlayerInventoryUpdate(src, {
            action = "remove",
            item = item,
            count = count,
            slot = slot,
            metadata = metadata
        })
    end

    return success
end

QBInventoryAPI.HasItem = function(src, item, requiredCount)
    if not initializeQBInventory() then return false end
    if not src or not item then return false end
    requiredCount = requiredCount or 1

    return qbInventoryExport:HasItem(src, item, requiredCount)
end

QBInventoryAPI.CanCarryItem = function(src, item, count)
    if not inventoryVersion then return true end
    if not src or not item or not count then return false end

    return qbInventoryExport:CanAddItem(src, item, count)
end

QBInventoryAPI.GetItemInfo = function(item)
    if not initializeQBInventory() then return nil end
    if not item then return {} end

    local itemData
    if Framework and Framework.Shared and Framework.Shared.Items then
        itemData = Framework.Shared.Items[item]
    end

    if itemData then
        return {
            name = itemData.name,
            label = itemData.label,
            weight = itemData.weight,
            stack = itemData.unique,
            description = itemData.description,
            image = QBInventoryAPI.GetImagePath(item)
        }
    end

    return {}
end

QBInventoryAPI.Items = function()
    if not initializeQBInventory() then return {} end
    if Framework and Framework.Shared and Framework.Shared.Items then
        return Framework.Shared.Items
    end

    if qbInventoryExport.GetItems then
        return qbInventoryExport:GetItems()
    end

    return {}
end

QBInventoryAPI.GetItemCount = function(src, item, metadata)
    if not initializeQBInventory() then return 0 end
    if not src or not item then return 0 end

    -- Use framework player data instead of qb-inventory export
    local Player = Framework.Functions.GetPlayer(src)
    if not Player then return 0 end

    local total = 0
    if Player.PlayerData and Player.PlayerData.items then
        for _, it in pairs(Player.PlayerData.items) do
            if it and it.name == item then
                if not metadata or (it.info and Bridge.Tables.DeepEquals(it.info, metadata)) then
                    total = total + (it.amount or 0)
                end
            end
        end
    end
    return total
end

QBInventoryAPI.GetPlayerInventory = function(src)
    if not initializeQBInventory() then return {} end
    if not src then return {} end

    -- Use framework player data instead of qb-inventory export
    local Player = Framework.Functions.GetPlayer(src)
    return Player and Player.PlayerData.items or {}
end

QBInventoryAPI.GetItemBySlot = function(src, slot)
    if not src or not slot then return {} end

    local slotData = qbInventoryExport:GetItemBySlot(src, slot)
    if slotData then
        return {
            name = slotData.name,
            label = slotData.name,
            weight = slotData.weight,
            slot = slotData.slot,
            count = slotData.amount,
            metadata = slotData.info,
            stack = slotData.unique,
            description = slotData.description
        }
    end

    return {}
end

QBInventoryAPI.GetImagePath = function(item)
    if not item then return "" end

    item = QBInventoryAPI.StripImageExtension(item)
    local resourceFile = LoadResourceFile("qb-inventory", string.format("html/images/%s.png", item))
    if resourceFile then
        return string.format("nui://qb-inventory/html/images/%s.png", item)
    end

    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

QBInventoryAPI.StripImageExtension = function(item)
    if not item then return "" end
    item = string.gsub(item, "%.png$", "")
    item = string.gsub(item, "%.jpg$", "")
    item = string.gsub(item, "%.jpeg$", "")
    item = string.gsub(item, "%.webp$", "")
    return item
end

QBInventoryAPI.OpenStash = function(src, stashType, stashId)
    if not initializeQBInventory() then return false end
    if not src or not stashId then return false end

    stashType = stashType or "stash"
    local stashData = inventoryStashes[stashId]

    if not stashData then
        DebugPrint(string.format("Stash %s not registered", stashId), "warning")
        return false
    end

    if not inventoryVersion then
        TriggerClientEvent('grp_bridge:client:qb-inventory:openStash', src, stashId, {
            weight = stashData.weight or 5000,
            slots = stashData.slots or 20
        })
        return true
    end

    return qbInventoryExport:OpenInventory(src, 'stash', stashId)
end

QBInventoryAPI.RegisterStash = function(stashId, label, slots, weight, owner, groups, coords)
    if not initializeQBInventory() then return false end
    if not stashId then return false end

    if inventoryStashes[stashId] then
        if config.Debug then
            DebugPrint(string.format("Stash %s already registered, updating", stashId), "info")
        end
    end

    inventoryStashes[stashId] = {
        id = stashId,
        label = label or stashId,
        slots = slots or 20,
        weight = weight or 5000,
        owner = owner,
        groups = groups,
        coords = coords
    }

    if inventoryVersion then
        qbInventoryExport:CreateInventory(stashId, {
            label = label or stashId,
            slots = slots or 20,
            maxweight = weight or 5000
        })
    end

    return true
end

QBInventoryAPI.AddStashItems = function(stashId, items)
    return processStashOperation(stashId, items, "add")
end

QBInventoryAPI.RemoveStashItems = function(stashId, items)
    return processStashOperation(stashId, items, "remove")
end

QBInventoryAPI.ClearStash = function(stashId, stashType)
    if not stashId then return false end

    if inventoryStashes[stashId] then
        inventoryStashes[stashId] = nil
    end

    if stashType == "trunk" then
        stashId = "trunk-" .. stashId
    elseif stashType == "glovebox" then
        stashId = "glovebox-" .. stashId
    end

    if inventoryVersion then
        local stashInv = qbInventoryExport:GetInventory(stashId)
        if stashInv then
            qbInventoryExport:ClearStash(stashId)
            return true
        end
    end

    return true
end

QBInventoryAPI.OpenShop = function(src, shopId)
    if not src or not shopId then return false end

    if not inventoryVersion then
        local shopData = inventoryShops[shopId]
        if shopData then
            TriggerClientEvent("inventory:client:OpenInventory", src, "shop", shopId, shopData)
            return true
        end
        return false
    end

    return qbInventoryExport:OpenShop(src, shopId)
end

QBInventoryAPI.RegisterShop = function(shopId, inventory, coords, groups)
    if not shopId or not inventory then return false end

    if inventoryShops[shopId] then
        if config.Debug then
            DebugPrint(string.format("Shop %s already registered", shopId), "info")
        end
        return true
    end

    if not inventoryVersion then
        local shopData = {
            label = shopId,
            items = {},
            slots = 0
        }

        for _, itemData in pairs(inventory) do
            table.insert(shopData.items, {
                name = itemData.name,
                price = itemData.price,
                amount = itemData.count or itemData.amount or 1000,
                info = itemData.metadata or itemData.info or {},
                type = 'item'
            })
        end

        shopData.slots = #shopData.items
        inventoryShops[shopId] = shopData

        DebugPrint("Registered shop using legacy method for QB-Inventory v1", "info")
        return true
    end

    local processedItems = {}
    for _, itemData in pairs(inventory) do
        table.insert(processedItems, {
            name = itemData.name,
            price = itemData.price,
            amount = itemData.count or itemData.amount or 1000
        })
    end

    inventoryShops[shopId] = {
        inventory = processedItems,
        coords = coords,
        groups = groups
    }

    qbInventoryExport:CreateShop({
        name = shopId,
        label = shopId,
        coords = coords,
        items = processedItems
    })

    return true
end

QBInventoryAPI.UpdatePlate = function(oldPlate, newPlate)
    if not oldPlate or not newPlate then return false end

    if not inventoryVersion then
        local query = [[
            UPDATE inventory_glovebox SET plate = @newPlate WHERE plate = @oldPlate;
            UPDATE inventory_trunk SET plate = @newPlate WHERE plate = @oldPlate;
        ]]
        -- This would need database access, simplified for now
        DebugPrint("Plate update not implemented for QB-Inventory v1", "warning")
        return false
    end

    local gloveboxInv = qbInventoryExport:GetInventory('glovebox-'..oldPlate) or {slots = 5, maxweight = 10000, items = {}}
    local trunkInv = qbInventoryExport:GetInventory('trunk-'..oldPlate) or {slots = 5, maxweight = 10000, items = {}}

    qbInventoryExport:ClearStash('glovebox-'..oldPlate)
    qbInventoryExport:ClearStash('trunk-'..oldPlate)

    qbInventoryExport:CreateInventory('glovebox-'..newPlate, {label = 'glovebox-'..newPlate, slots = gloveboxInv.slots, maxweight = gloveboxInv.maxweight})
    qbInventoryExport:SetInventory('glovebox-'..newPlate, gloveboxInv.items or {}, "GRP Bridge Plate Update - Glovebox")

    qbInventoryExport:CreateInventory('trunk-'..newPlate, {label = 'trunk-'..newPlate, slots = trunkInv.slots, maxweight = trunkInv.maxweight})
    qbInventoryExport:SetInventory('trunk-'..newPlate, trunkInv.items or {}, "GRP Bridge Plate Update - Trunk")

    if GetResourceState('jg-mechanic') == 'started' then
        exports["jg-mechanic"]:vehiclePlateUpdated(oldPlate, newPlate)
    end

    return true
end

QBInventoryAPI.OpenPlayerInventory = function(src, targetSrc)
    if not src or not targetSrc then return false end

    -- Try qb-inventory export first
    if qbInventoryExport.OpenInventory then
        local result = qbInventoryExport:OpenInventory(src, targetSrc)
        if result ~= nil then
            return result
        end
    end

    -- Fallback: use framework notification
    TriggerClientEvent('QBCore:Notify', src, 'Player inventory opening not available', 'error')
    return false
end

return QBInventoryAPI
