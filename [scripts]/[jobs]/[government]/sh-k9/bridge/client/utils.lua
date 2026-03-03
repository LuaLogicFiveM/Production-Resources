-- ================== SHARED UTILITIES ==================
local settings = require 'config.config'

-- ================== ITEM LIST DETECTION ==================
local itemList = nil

-- Detect and load item list from available inventory systems
if GetResourceState('ox_inventory') == 'started' then 
    itemList = exports.ox_inventory:Items()
elseif GetResourceState('qb-core') == 'started' then 
    itemList = exports['qb-core']:GetCoreObject().Shared.Items
elseif GetResourceState('qs-inventory') == 'started' then 
    itemList = exports['qs-inventory']:GetItemList()
end

-- ================== ITEM FUNCTIONS ==================
function GetItemLabel(item)
    if not itemList then
        -- Fallback when no inventory system available
        return type(item) == 'table' and table.concat(item, ", ") or item
    end

    if type(item) == 'table' then
        -- Handle multiple items
        local itemLabels = {}
        for _, itemName in pairs(item) do
            itemLabels[#itemLabels + 1] = itemList[itemName]?.label or 'Unknown'
        end
        return table.concat(itemLabels, ", ") 
    else
        -- Handle single item
        return itemList[item]?.label or 'Unknown'
    end
end

-- ================== UTILITY FUNCTIONS ==================
function GetPlate(vehicle)
    return GetVehicleNumberPlateText(vehicle)
end

function HasAccess()
    return lib.callback.await('sh-k9:cb:HasAccess', false)
end 

-- ================== NOTIFICATION SYSTEM ==================
local NOTIFICATIONS = {
    ox = function(message, notificationType, duration)
        lib.notify({
            title = 'K9 ALERT',
            description = message,
            type = notificationType,
            duration = duration,
            position = 'top'
        })
    end,
    
    qb = function(message, notificationType, duration)
        TriggerEvent('QBCore:Notify', message, notificationType, duration)
    end,
    
    qbx = function(message, notificationType, duration)
        exports.qbx_core:Notify(message, notificationType, duration)
    end,
    
    esx = function(message, notificationType, duration)
        exports['esx_notify']:Notify(notificationType, message, duration, "K9 ALERT") 
    end,
    
    default = function(message, notificationType, duration)
        SetNotificationTextEntry('STRING')
        AddTextComponentString(message)
        DrawNotification(0, 1)
    end
}

function Notify(message, notificationType, duration)
    local handler = NOTIFICATIONS[settings.notify] or NOTIFICATIONS.ox
    handler(message, notificationType, duration)
end

--
local function Draw3DText(x, y, z, text, showBackground)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    
    -- Optional background rectangle
    if showBackground then
        local textWidth = (string.len(text)) / 370
        DrawRect(0.0, 0.0 + 0.0125, 0.017 + textWidth, 0.03, 0, 0, 0, 75)
    end
    
    ClearDrawOrigin()
end

if InsertToUtils then InsertToUtils('DRAW_TEXT_3D', Draw3DText) end