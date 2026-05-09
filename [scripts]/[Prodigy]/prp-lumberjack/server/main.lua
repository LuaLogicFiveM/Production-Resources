SetConvarReplicated(("ox:printlevel:%s"):format(GetCurrentResourceName()), Config.Debug and "debug" or "info")

PlateToVeh = {}
SellStashes = {}
RentedVehicles = {}

function HasValue(tbl, value)
    for k, v in ipairs(tbl) do
        if v == value or (type(v) == "table" and HasValue(v, value)) then
            return true
        end
    end
    return false
end

function SpawnVehicle(model, coords)
    local vehicle, plate = exports['prp-bridge']:SpawnTemporaryVehicle({
        model = model,
        coords = coords,
        heading = coords.w,
    })

    if not vehicle or not DoesEntityExist(vehicle) then
        return
    end

    return vehicle, plate
end

function RemoveVehicle(entity)
    DeleteEntity(entity)
end

local inventoryHooks = {}
local attachedCarryItems = {}
local carryItemFilter = {}
local carryItemAnims = {}

local function registerCarryItems()
    for itemName, item in pairs(Config.InventoryItems) do
        if item.animation and item.animation.prop then
            carryItemFilter[itemName] = true
            carryItemAnims[itemName] = item.animation

            exports["prp-bridge"]:RegisterObject({
                objectName = itemName,
                modelHash = item.animation.prop.hash,
                offset = item.animation.prop.position,
                rotation = item.animation.prop.rotation,
                boneId = item.animation.prop.bone,
                disableCollision = true,
                completelyDisableCollision = true,
            })
        end
    end
end

local function handleProp(src)
    SetTimeout(650, function()
        local foundItem = nil
        for itemName, _ in pairs(carryItemFilter) do
            if bridge.inv.hasItem(src, itemName, 1) then
                foundItem = itemName
                break
            end
        end

        if foundItem and not attachedCarryItems[src] then
            local anim = carryItemAnims[foundItem]
            attachedCarryItems[src] = {
                item = foundItem,
                object = exports["prp-bridge"]:CreateAttachObject(src, foundItem),
            }
            TriggerClientEvent("prp-lumberjack:client:carryAnim", src, true, anim.dictionary, anim.animation)
        elseif not foundItem and attachedCarryItems[src] then
            exports["prp-bridge"]:RemoveAttachObject(src, attachedCarryItems[src].object)
            attachedCarryItems[src] = nil
            TriggerClientEvent("prp-lumberjack:client:carryAnim", src, false)
        elseif foundItem and attachedCarryItems[src] and attachedCarryItems[src].item ~= foundItem then
            exports["prp-bridge"]:RemoveAttachObject(src, attachedCarryItems[src].object)
            local anim = carryItemAnims[foundItem]
            attachedCarryItems[src] = {
                item = foundItem,
                object = exports["prp-bridge"]:CreateAttachObject(src, foundItem),
            }
            TriggerClientEvent("prp-lumberjack:client:carryAnim", src, true, anim.dictionary, anim.animation)
        end
    end)

    return true
end

local function registerInventoryHooks()
    local logItemFilter = {}
    for k, v in pairs(Config.Trees) do
        logItemFilter[("%s_log"):format(k)] = true
    end

    inventoryHooks[#inventoryHooks + 1] = bridge.inv.registerSwapItemsHook(
        function(payload)
            local src = payload.source
            local inventory = payload.toInventory == src and payload.fromInventory or payload.toInventory
            local plate = string.sub(inventory, 6)

            if payload.toInventory == payload.fromInventory then
                return true
            end

            SetTimeout(100, function()
                RefreshVehicleObjects(inventory, plate)
            end)

            return true
        end, {
            itemFilter = logItemFilter,
            inventoryFilter = {
                "^trunk[%w]+"
            }
        }
    )

    inventoryHooks[#inventoryHooks + 1] = bridge.inv.registerSwapItemsHook(
        function(payload)
            return handleProp(payload.source)
        end, {
            itemFilter = carryItemFilter,
        }
    )
end

local function cleanupPlate(plate)
    return string.gsub(plate, "%s+", "")
end

local function findVehicle(plate)
    local vehicles = GetGamePool("CVehicle")
    for _, veh in ipairs(vehicles) do
        local cleanPlate = cleanupPlate(plate):lower()
        local cleanVehiclePlate = cleanupPlate(GetVehicleNumberPlateText(veh)):lower()

        if cleanVehiclePlate == cleanPlate then
            return veh
        end
    end

    return nil
end

function RefreshVehicleObjects(inventoryId, plate)
    local veh = findVehicle(plate)
    lib.print.debug(("Refreshing vehicle objects for inventory %s and plate %s. Found vehicle: %s"):format(inventoryId,
        plate, veh))
    if not veh then return end
    if not Config.AttachOffsets[GetEntityModel(veh)] then return end
    exports["prp-bridge"]:ClearVehTempAttachObjects(veh)

    Citizen.Wait(0)

    local inventory = bridge.inv.getInventory(inventoryId)
    lib.print.debug(("Refreshing vehicle objects for inventory %s with items: %s"):format(inventoryId,
        json.encode(inventory, { indent = true })))

    if not inventory or not inventory.items then return end

    local logs = {}
    for k, v in pairs(inventory.items) do
        if Config.Trees[string.sub(v.name, 0, -5)] then
            logs[#logs + 1] = v
            logs[#logs].realName = string.sub(v.name, 0, -5)
        end
    end

    lib.print.debug(("Found %s logs in inventory %s for vehicle %s"):format(#logs, inventoryId, veh))

    if #logs == 0 then return end
    table.sort(logs, function(a, b)
        return a.slot < b.slot
    end)

    for i = 1, #logs do
        local log = logs[i]

        local config = Config.InventoryItems[log.name]
        lib.print.debug(("Attaching log %s to vehicle %s with model %s"):format(log.name, veh, GetEntityModel(veh)))
        lib.print.debug('Config' .. json.encode(config))

        local attachConfig = Config.AttachOffsets[GetEntityModel(veh)]
        local logConfig = attachConfig[("log_%s"):format(i)]
        if logConfig then
            exports["prp-bridge"]:CreateVehTempAttachObject(
                veh,
                {
                    model = config.model,
                    bone = logConfig.bone,
                    offset = logConfig.offset,
                    rotation = logConfig.rot,
                }
            )
        end
    end
end

RegisterNetEvent("prp-lumberjack:rentVehicle", function()
    local source = source
    if not Config.Features.rentals then return end
    local stateId = bridge.fw.getIdentifier(source)
    local hasRentedVehicle = false
    for k, v in pairs(RentedVehicles) do
        if tostring(v) == tostring(stateId) then
            hasRentedVehicle = true
            break
        end
    end
    if hasRentedVehicle then
        bridge.fw.notify(source, "error", locale("VEH_ALREADY_RENTED"))
        return
    end
    local freeSpot = lib.callback.await("prp-lumberjack:getFreeSpot", source)
    if not freeSpot then
        bridge.fw.notify(source, "error", locale("NO_FREE_SPOTS"))
        return
    end
    local spawnCoords = Config.Job.Lumberjack.lumberCenter.vehSpawns[freeSpot]
    local success = bridge.fw.removeMoney(
        source,
        'cash',
        Config.Job.Lumberjack.vehicleRent,
        locale("VEHICLE_RENTAL_DESC", Config.Job.Lumberjack.vehicleRent)
    )

    if not success then
        bridge.fw.notify(source, "error", locale("FAILED_TO_WITHDRAW_RENT"))
        return
    end

    local vehTries = 0
    local function spawnVehicle()
        if vehTries > 3 then return end
        local coords = spawnCoords

        local vehicle, plate = exports['prp-bridge']:SpawnTemporaryVehicle({
            model = Config.Job.Lumberjack.vehicleModel,
            coords = coords,
            heading = coords.w,
        })

        return vehicle, plate
    end
    local veh, plate = spawnVehicle()
    if not veh then
        bridge.fw.notify(source, "error", locale("CANNOT_SPAWN_RENTAL_VEH"))
        return
    end

    RentedVehicles[tostring(veh)] = tostring(stateId)
    bridge.vkeys.give(source, veh, plate)
end)

RegisterNetEvent("prp-lumberjack:returnVehicle", function()
    local source = source
    if not Config.Features.rentals then return end
    local stateId = bridge.fw.getIdentifier(source)
    local hasRentedVehicle = false
    for k, v in pairs(RentedVehicles) do
        if tostring(v) == tostring(stateId) then
            hasRentedVehicle = k
            break
        end
    end
    if not hasRentedVehicle then
        bridge.fw.notify(source, "error", locale("NO_VEHICLE_RENTED"))
        return
    end
    local veh = hasRentedVehicle
    if #(GetEntityCoords(tonumber(veh)) - Config.Job.Lumberjack.lumberCenter.vehSpawns[1].xyz) > Config.VehicleReturnDistance then
        bridge.fw.notify(source, "error", locale("MUST_RETURN_VEH_TO_LUMBER_YARD"))
        return
    end

    local payout = Config.Job.Lumberjack.vehicleRent
    local success = bridge.fw.addMoney(
        source,
        'cash',
        payout,
        locale("VEHICLE_RETURN_DESC", payout)
    )

    if not success then
        bridge.fw.notify(source, "error", locale("FAILED_TO_RETURN_RENT"))
        return
    end

    RemoveVehicle(tonumber(veh))
    RentedVehicles[tostring(hasRentedVehicle)] = nil
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for i = 1, #inventoryHooks do
            bridge.inv.removeHooks(inventoryHooks[i])
        end
    end
end)

local function startup()
    registerCarryItems()
    registerInventoryHooks()
end
SetTimeout(0, startup)

AddEventHandler("playerDropped", function()
    local src = source
    if attachedCarryItems[src] then
        attachedCarryItems[src] = nil
    end
end)

RegisterNetEvent("prp-lumberjack:openSellStash", function()
    local source = source
    if not Config.Features.sellShop then return end

    local sellingItems = {}
    for k, v in pairs(Config.InventoryItems) do
        if v.sellPrice then
            sellingItems[k] = {
                label = v.label,
                price = v.sellPrice,
            }
        end
    end

    exports['prp-bridge']:RegisterSellShop(
        'lumberjack',
        {
            label = locale("SELL_MATERIALS"),
            items = sellingItems
        }
    )

    exports['prp-bridge']:OpenSellShop(source, 'lumberjack')
end)

lib.callback.register("prp-lumberjack:getLogCount", function(source, treeType)
    if not Config.Trees[treeType] then return 0 end
    local logName = treeType .. "_log"
    local items = bridge.inv.getInventoryItems(source)
    if not items then return 0 end
    local total = 0
    for _, item in pairs(items) do
        if item.name == logName then
            total = total + (item.count or 1)
        end
    end
    return total
end)

lib.callback.register("prp-lumberjack:processLog", function(source, treeType, amount)
    if not Config.Trees[treeType] then return false end

    amount = math.floor(tonumber(amount) or 0)
    if amount < 1 then return false end

    local logName = treeType .. "_log"
    local plankName = treeType .. "_plank"

    if not bridge.inv.hasItem(source, logName, amount) then return false end

    local removed = bridge.inv.removeItem(source, logName, amount)
    if not removed then return false end

    handleProp(source)

    bridge.inv.giveItem(source, plankName, amount)
    return true
end)
