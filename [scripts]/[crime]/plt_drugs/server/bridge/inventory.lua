bridge = bridge or {}

local inventorySystem = nil

if Config.InventorySystem == 'auto' then
    if GetResourceState("ox_inventory") == 'started' then
        inventorySystem = 'ox'
    elseif GetResourceState("qb-inventory") == 'started' then
        inventorySystem = 'qb'
    elseif GetResourceState("qs-inventory") == 'started' then
        inventorySystem = 'quasar'
    elseif GetResourceState("core_inventory") == 'started' then
        inventorySystem = 'core'
    elseif GetResourceState("codem-inventory") == 'started' then
        inventorySystem = 'codem'
    elseif GetResourceState("tgiann-inventory") == 'started' then
        inventorySystem = 'tgiann'
    elseif GetResourceState("origen_inventory") == 'started' then
        inventorySystem = 'origen'
    end
else
    inventorySystem = Config.InventorySystem
end

function bridge.addItem(src, item, amount)
    if not inventorySystem then
        print(
            '^1 FATAL ERROR: There is no compatible inventory system, add your own system in plt_drugs/server/bridge/inventory.lua^7')
        return
    end

    if inventorySystem == 'ox' then
        return exports.ox_inventory:AddItem(src, item, amount)
    elseif inventorySystem == 'qb' then
        return exports['qb-inventory']:AddItem(src, item, amount)
    elseif inventorySystem == 'quasar' then
        return exports['qs-inventory']:AddItem(src, item, amount)
    elseif inventorySystem == 'core' then
        return exports.core_inventory:addItem(src, item, amount)
    elseif inventorySystem == 'codem' then
        return exports['codem-inventory']:AddItem(src, item, amount)
    elseif inventorySystem == 'tgiann' then
        return exports["tgiann-inventory"]:AddItem(src, item, amount)
    elseif inventorySystem == 'origen' then
        return exports.origen_inventory:addItem(src, item, amount)
    else
        print(
            '^1 FATAL ERROR: There is no compatible inventory system, add your own system in plt_drugs/server/bridge/inventory.lua^7')
    end
end

function bridge.removeItem(src, item, amount)
    if not inventorySystem then
        print(
            '^1 FATAL ERROR: There is no compatible inventory system, add your own system in plt_drugs/server/bridge/inventory.lua^7')
        return
    end

    if inventorySystem == 'ox' then
        return exports.ox_inventory:RemoveItem(src, item, amount)
    elseif inventorySystem == 'qb' then
        return exports['qb-inventory']:RemoveItem(src, item, amount)
    elseif inventorySystem == 'quasar' then
        return exports['qs-inventory']:RemoveItem(src, item, amount)
    elseif inventorySystem == 'core' then
        return exports.core_inventory:removeItem(src, item, amount)
    elseif inventorySystem == 'codem' then
        return exports['codem-inventory']:RemoveItem(src, item, amount)
    elseif inventorySystem == 'tgiann' then
        return exports["tgiann-inventory"]:RemoveItem(src, item, amount)
    elseif inventorySystem == 'origen' then
        return exports.origen_inventory:removeItem(src, item, amount)
    else
        print(
            '^1 FATAL ERROR: There is no compatible inventory system, add your own system in plt_drugs/server/bridge/inventory.lua^7')
    end
end

function bridge.hasItem(src, item)
    if not inventorySystem then
        print(
            '^1 FATAL ERROR: There is no compatible inventory system, add your own system in plt_drugs/server/bridge/inventory.lua^7')
        return nil
    end

    if inventorySystem == 'ox' then
        local itemData = exports.ox_inventory:GetItem(src, item)
        if not itemData or itemData.count == 0 then
            return nil
        end
        return {
            label = itemData.label or item,
            count = itemData.count
        }
    elseif inventorySystem == 'qb' then
        local getItem = exports['qb-inventory']:GetItemByName(src, item)
        local itemCount = exports['qb-inventory']:GetItemCount(src, item)
        if not itemCount or itemCount == 0 then
            return nil
        end
        return {
            label = getItem.label,
            count = itemCount
        }
    elseif inventorySystem == 'quasar' then
        local itemCount = exports['qs-inventory']:GetItemTotalAmount(src, item)
        if not itemCount or itemCount == 0 then
            return nil
        end
        return {
            label = exports['qs-inventory']:GetItemLabel(item),
            count = itemCount
        }
    elseif inventorySystem == 'core' then
        local itemInfo = exports.core_inventory:getItem(src, item)
        if not itemInfo or itemInfo.count == 0 then
            return nil
        end
        return {
            label = itemInfo.label or item,
            count = itemInfo.count
        }
    elseif inventorySystem == 'codem' then
        local itemCount = exports['codem-inventory']:GetItemsTotalAmount(src, item)
        if not itemCount or itemCount == 0 then
            return nil
        end
        return {
            label = exports['codem-inventory']:GetItemLabel(item),
            count = itemCount
        }
    elseif inventorySystem == 'tgiann' then
        local itemCount = exports["tgiann-inventory"]:GetItemCount(src, item)
        if not itemCount or itemCount == 0 then
            return nil
        end
        return {
            label = exports["tgiann-inventory"]:GetItemLabel(item, src),
            count = itemCount
        }
    elseif inventorySystem == 'origen' then
        local itemCount = exports.origen_inventory:getItemCount(src, item)
        if not itemCount or itemCount == 0 then
            return nil
        end
        return {
            label = exports.origen_inventory:GetItemLabel(item),
            count = itemCount
        }
    else
        print(
            '^1 FATAL ERROR: There is no compatible inventory system, add your own system in plt_drugs/server/bridge/inventory.lua^7')
    end

    return nil
end
