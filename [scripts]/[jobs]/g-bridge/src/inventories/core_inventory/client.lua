---@diagnostic disable: duplicate-set-field
if GetResourceState("core_inventory") ~= "started" then
    return
end

local CTL = nil

function INVENTORY.CLIENT.GetInventoryName()
    return "core_inventory"
end

function INVENTORY.CLIENT.GetInventoryImagePath()
    return "core_inventory/html/img/"
end

local function repackItemList(list)
    if type(list) ~= "table" then
        return {}
    end
    local repack = {}
    for name, data in pairs(list) do
        if data and data.name then
            repack[name] = {
                name = data.name,
                label = data.label or data.name,
                weight = data.weight or 0,
                description = data.description or "",
                stack = not data.unique
            }
        end
    end
    return repack
end

local function Items()
    if CTL then
        return CTL
    end
    if not _G.CALLBACK then
        print("No callback found for core_inventory")
        return {}
    end
    local ok, list = pcall(function()
        return Citizen.Await(_G.CALLBACK.TriggerServer('g-bridge:inventory:core_inventory:items'))
    end)
    if not ok or type(list) ~= "table" then
        return {}
    end
    CTL = repackItemList(list)
    return CTL
end

function INVENTORY.CLIENT.GetItemInfo(itemName)
    if not itemName then
        return nil
    end
    local itemList = Items()
    local raw = itemList[itemName] or {}
    if next(raw) == nil then
        return {}
    end
    return {
        name = raw.name or itemName,
        label = raw.label or raw.name or "",
        weight = raw.weight or 0,
        description = raw.description or "",
        stack = raw.stack ~= false
    }
end
