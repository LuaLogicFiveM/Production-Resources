---@script core/client/classes/exports.lua

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@section: Utility Functions

---@param vehicleHandle integer
---@return nil|integer
---@return nil|table
local get_network_and_data = function(vehicleHandle)
    local networkId = VehToNet(vehicleHandle)
    if not networkId or networkId == 0 then return nil, nil end

    local serverData = Init.vehiclePool[networkId]
    if not serverData then return nil, nil end

    return networkId, serverData
end

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
---@section: Export Functions

---@param vehicleHandle integer
---@return nil|integer
---@usage local waterLevel = exports['z_hose']:getWaterLevel(vehicleHandle)
local function get_water_level(vehicleHandle)
    local _, serverData = get_network_and_data(vehicleHandle)
    if not serverData then return nil end

    return serverData.tankStorage.water
end

Init.exports.getWaterLevel = get_water_level
exports("getWaterLevel", get_water_level)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@param vehicleHandle integer
---@return nil|integer
---@usage local foamLevel = exports['z_hose']:getFoamLevel(vehicleHandle)
local function get_foam_level(vehicleHandle)
    local _, serverData = get_network_and_data(vehicleHandle)
    if not serverData then return nil end

    return serverData.tankStorage.foam
end

Init.exports.getFoamLevel = get_foam_level
exports("getFoamLevel", get_foam_level)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@param vehicleHandle integer
---@param newWaterLevel number
---@return boolean
---@usage local isSuccess = exports['z_hose']:setWaterLevel(vehicleHandle, newWaterLevel)
local function set_water_level(vehicleHandle, newWaterLevel)
    local networkId, _ = get_network_and_data(vehicleHandle)
    if not networkId then return false end

    if not Init.updateQueue[networkId] then Init.updateQueue[networkId] = {} end

    Init.vehiclePool[networkId].tankStorage.water = newWaterLevel

    SetTimeout(1000, function()
        Init.updateQueue[networkId] = nil
    end)

    return true
end

Init.exports.setWaterLevel = set_water_level
exports("setWaterLevel", set_water_level)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@param vehicleHandle integer
---@param newFoamLevel number
---@return boolean
---@usage local isSuccess = exports['z_hose']:setFoamLevel(vehicleHandle, newFoamLevel)
local function set_foam_level(vehicleHandle, newFoamLevel)
    local networkId, _ = get_network_and_data(vehicleHandle)
    if not networkId then return false end

    if not Init.updateQueue[networkId] then Init.updateQueue[networkId] = {} end

    Init.vehiclePool[networkId].tankStorage.foam = newFoamLevel

    SetTimeout(1000, function()
        Init.updateQueue[networkId] = nil
    end)

    return true
end

Init.exports.setFoamLevel = set_foam_level
exports("setFoamLevel", set_foam_level)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@param vehicleHandle integer
---@return nil|boolean
---@usage local IsEngaged = exports['z_hose']:isPumpEngaged(vehicleHandle)
local function is_pump_engaged(vehicleHandle)
    local _, serverData = get_network_and_data(vehicleHandle)
    if not serverData then return nil end

    return serverData.pumpData.status
end

Init.exports.isPumpEngaged = is_pump_engaged
exports("isPumpEngaged", is_pump_engaged)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@param vehicleHandle integer
---@param newStatus boolean
---@return boolean
---@usage local IsSuccess = exports['z_hose']:setPumpStatus(vehicleHandle, newStatus)
local function set_pump_status(vehicleHandle, newStatus)
    local networkId, _ = get_network_and_data(vehicleHandle)
    if not networkId then return false end

    callbacks.request('z_hose:syncDataToServer', {
        identifier = networkId,
        path = 'vehiclePool.pumpData.status',
        toStore = newStatus
    }, function(response)
        if response then return end
        Init.log('error', 'Failure when syncing data to server | ERR_OJL13DK2')
    end)

    return true
end

Init.exports.setPumpStatus = set_pump_status
exports("setPumpStatus", set_pump_status)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@param vehicleHandle integer
---@return nil|boolean
---@usage local hasSupply = exports['z_hose']:hasSupply(vehicleHandle)
local function has_supply(vehicleHandle)
    local _, serverData = get_network_and_data(vehicleHandle)
    if not serverData then return nil end

    return serverData.hasSupply
end

Init.exports.hasSupply = has_supply
exports("hasSupply", has_supply)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@return boolean | nil
---@usage local IsSuccess = exports['z_hose']:openPumpPanel()
local function open_pump_panel()
    if not bridge.hasPermission('view_pump_panel') then return nil end

    local playerPed = PlayerPedId()
    if Init.functions.isPlayerInVehicle(playerPed) then return nil end

    local vehicleData = Init.functions.getVehicle(playerPed)
    if not vehicleData or vehicleData.handle == 0 then return nil end

    local vehiclePool = Init.vehiclePool[vehicleData.networkId]
    if not vehiclePool then return nil end

    Init.functions.handleUsersActions(playerPed, {
        action = "view-pump",
        vehicleData = vehicleData,
        valves = vehiclePool.valves
    })
end

Init.exports.openPumpPanel = open_pump_panel
exports("openPumpPanel", open_pump_panel)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@description: This function returns true when the user is holding a hose.
---@return boolean
---@usage local hasHose = exports['z_hose']:UserHasHose()
local function user_has_hose()
    return (cl_globals.currentHose ~= 0)
end

Init.exports.UserHasHose = user_has_hose
exports("UserHasHose", user_has_hose)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@description: This function returns true only when the user is actively spraying water from the hose.
---@return boolean
---@usage local IsUsing = exports['z_hose']:IsUsingHose()
local function is_using_hose()
    return Init.IsUsingHose
end

Init.exports.IsUsingHose = is_using_hose
exports("IsUsingHose", is_using_hose)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@return nil
---@usage local IsSuccess = exports['z_hose']:returnHose()
local function return_hose()
    if not bridge.hasPermission('retreive&return_hose') then return nil end

    local playerPed = PlayerPedId()
    if Init.functions.isPlayerInVehicle(playerPed) then return nil end

    local vehicleData = Init.functions.getVehicle(playerPed)
    if not vehicleData or vehicleData.handle == 0 then
        bridge.notification('error', { setTimeout = 3000, setTitle = 'Error!', setDescription = 'No vehicle found!' })
        return nil
    end

    Init.functions.handleUsersActions(playerPed, {
        action = "remove-hose",
        vehicleData = vehicleData,
    })
end

Init.exports.returnHose = return_hose
exports("returnHose", return_hose)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@return nil
---@usage local IsSuccess = exports['z_hose']:removeSupply()
local function remove_supply()
    if not bridge.hasPermission('retreive&return_supply') then return nil end

    local playerPed = PlayerPedId()
    local INTERACT_DIST = 2.5

    if Init.functions.isPlayerInVehicle(playerPed) then return nil end

    local closestValve = Init.functions.getClosestValve(playerPed, 'intakes')
    if not closestValve or closestValve.distance > INTERACT_DIST then
        bridge.notification('error', { setTimeout = 3000, setTitle = 'Error!', setDescription = 'No vehicle found!' })
        return nil
    end

    Init.functions.disconnectLength(playerPed, closestValve, 'supply')
end

Init.exports.removeSupply = remove_supply
exports("removeSupply", remove_supply)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@return nil
---@usage local IsSuccess = exports['z_hose']:removeRelay()
local function remove_relay()
    if not bridge.hasPermission('retreive&return_relay') then return nil end

    local playerPed = PlayerPedId()
    local INTERACT_DIST = 2.5

    if Init.functions.isPlayerInVehicle(playerPed) then return nil end

    local closestValve = Init.functions.getClosestValve(playerPed, 'relay')
    if not closestValve or closestValve.distance > INTERACT_DIST then
        bridge.notification('error', { setTimeout = 3000, setTitle = 'Error!', setDescription = 'No vehicle found!' })
        return nil
    end

    Init.functions.disconnectLength(playerPed, closestValve, 'relay')
end

Init.exports.removeRelay = remove_relay
exports("removeRelay", remove_relay)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@return nil
---@usage local IsSuccess = exports['z_hose']:createSupply()
local function create_supply()
    if not bridge.hasPermission('retreive&return_supply') then return nil end

    local playerPed = PlayerPedId()
    local INTERACT_DIST = 2.5

    if Init.functions.isPlayerInVehicle(playerPed) then return nil end

    local closestValve = Init.functions.getClosestValve(playerPed, 'intakes')
    if not closestValve or closestValve.distance > INTERACT_DIST then
        bridge.notification('error', { setTimeout = 3000, setTitle = 'Error!', setDescription = 'No vehicle found!' })
        return nil
    end

    Init.functions.createLength(playerPed, closestValve, 'supply')
end

Init.exports.createSupply = create_supply
exports("createSupply", create_supply)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@return nil
---@usage local IsSuccess = exports['z_hose']:createRelay()
local function create_relay()
    if not bridge.hasPermission('retreive&return_relay') then return nil end

    local playerPed = PlayerPedId()
    local INTERACT_DIST = 2.5

    if Init.functions.isPlayerInVehicle(playerPed) then return nil end

    local closestValve = Init.functions.getClosestValve(playerPed, 'relay')
    if not closestValve or closestValve.distance > INTERACT_DIST then
        bridge.notification('error', { setTimeout = 3000, setTitle = 'Error!', setDescription = 'No vehicle found!' })
        return nil
    end

    Init.functions.createLength(playerPed, closestValve, 'relay')
end

Init.exports.createRelay = create_relay
exports("createRelay", create_relay)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@return nil
---@usage local IsSuccess = exports['z_hose']:createHose('water')
local function create_hose(type)
    if not bridge.hasPermission('retreive&return_hose') then return nil end

    local playerPed = PlayerPedId()
    local INTERACT_DIST = 2.5

    if Init.functions.isPlayerInVehicle(playerPed) then return nil end

    local closestValve = Init.functions.getClosestValve(playerPed, 'discharges')
    if not closestValve or closestValve.distance > INTERACT_DIST then
        bridge.notification('error', { setTimeout = 3000, setTitle = 'Error!', setDescription = 'No vehicle found!' })
        return nil
    end

    Init.functions.handleUsersActions(playerPed, {
        action = ("create-hose-%s"):format(type),
        actionData = closestValve,
    })
end

Init.exports.createHose = create_hose
exports("createHose", create_hose)

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
