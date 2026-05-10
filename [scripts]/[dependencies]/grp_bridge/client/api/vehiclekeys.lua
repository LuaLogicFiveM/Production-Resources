---@diagnostic disable: duplicate-set-field
local VEHICLEKEYS = {}
local vehicleKeysProvider
local vehicleKeysSystem = "default"
local vehicleKeysDebug = config.Debug

---@param system string
---@return table|nil
local function loadVehicleKeysSystem(system)
    local res = GetCurrentResourceName()

    if system == "default" then
        return {
            GetResourceName = function() return "default" end,
            GiveKeys = function(vehicle, plate)
                if not DoesEntityExist(vehicle) then return end
                SetVehicleDoorsLocked(vehicle, 1)
            end,
            RemoveKeys = function(vehicle, plate)
                if not DoesEntityExist(vehicle) then return end
            end,
        }
    end

    local path = ('client/api/vehiclekeys/%s.lua'):format(system)
    local src = LoadResourceFile(res, path)
    if src then
        local env = {
            DebugPrint = DebugPrint,
            GetResourceState = GetResourceState,
            DoesEntityExist = DoesEntityExist,
            GetVehicleNumberPlateText = GetVehicleNumberPlateText,
            TriggerServerEvent = TriggerServerEvent,
            TriggerEvent = TriggerEvent,
            assert = assert,
            exports = exports
        }
        setmetatable(env, { __index = _G })

        local chunk, err = load(src, ('=@%s'):format(path), "t", env)
        if chunk then
            local success, mod = pcall(chunk)
            if success and type(mod) == 'table' and mod.GetResourceName then
                if vehicleKeysDebug then
                    DebugPrint(('Vehicle keys module loaded: %s'):format(system), "debug")
                end
                return mod
            elseif success and mod == nil then
                if vehicleKeysDebug then
                    DebugPrint(('Vehicle keys module %s returned nil (resource not available)'):format(system), "debug")
                end
                return nil
            elseif not success then
                if vehicleKeysDebug then
                    DebugPrint(('Error loading vehicle keys module %s: %s'):format(system, mod), "error")
                end
            end
        else
            if vehicleKeysDebug then
                DebugPrint(('Failed to load vehicle keys file %s: %s'):format(path, err), "error")
            end
        end
    end

    return nil
end

local vehicleKeysSystems = {
    "qb-vehiclekeys",
    "qbx_vehiclekeys",
    "qs-vehiclekeys",
    "Renewed-Vehiclekeys",
    "wasabi_carlock",
    "okokGarage",
    "cd_garage",
    "mk_vehiclekeys",
    "mono_carkeys",
    "MrNewbVehicleKeys",
    "mVehicle",
    "t1ger_keys",
    "F_RealCarKeysSystem",
    "jacksam"
}

if vehicleKeysDebug then
    DebugPrint("Initializing vehicle keys system detection...", "debug")
end

local function detectVehicleKeysSystem()
    local configuredVehicleKeys = config.VehicleKeys or "auto"

    if configuredVehicleKeys ~= "auto" then
        local state = GetResourceState(configuredVehicleKeys)
        if state == 'started' or state == 'starting' then
            local mod = loadVehicleKeysSystem(configuredVehicleKeys)
            if mod then
                vehicleKeysProvider = mod
                vehicleKeysSystem = configuredVehicleKeys
                if vehicleKeysDebug then
                    DebugPrint(("Vehicle keys system loaded from config: %s"):format(configuredVehicleKeys), "success")
                end
                return
            end
        end
        if vehicleKeysDebug then
            DebugPrint(("Configured vehicle keys system '%s' not available (state: %s), falling back to auto-detection"):format(configuredVehicleKeys, state), "warning")
        end
    end

    for _, system in ipairs(vehicleKeysSystems) do
        local state = GetResourceState(system)
        if state == 'started' or state == 'starting' then
            local mod = loadVehicleKeysSystem(system)
            if mod then
                vehicleKeysProvider = mod
                vehicleKeysSystem = system
                if vehicleKeysDebug then
                    DebugPrint("Vehicle keys system loaded via auto-detection: " .. system, "success")
                end
                return
            end
        end
    end

    vehicleKeysProvider = loadVehicleKeysSystem("default")
    vehicleKeysSystem = "default"
    if vehicleKeysDebug then
        DebugPrint("No vehicle keys system loaded, using default", "warning")
    end
end

detectVehicleKeysSystem()

---@return string
function VEHICLEKEYS.GetResourceName()
    return vehicleKeysSystem or "unknown"
end

---@param vehicle number Vehicle entity handle
---@param plate? string Vehicle plate
function VEHICLEKEYS.GiveKeys(vehicle, plate)
    if vehicleKeysProvider and vehicleKeysProvider.GiveKeys then
        vehicleKeysProvider.GiveKeys(vehicle, plate)
        return
    end
    if not DoesEntityExist(vehicle) then return end
    SetVehicleDoorsLocked(vehicle, 1)
end

---@param vehicle number Vehicle entity handle
---@param plate? string Vehicle plate
function VEHICLEKEYS.RemoveKeys(vehicle, plate)
    if vehicleKeysProvider and vehicleKeysProvider.RemoveKeys then
        vehicleKeysProvider.RemoveKeys(vehicle, plate)
        return
    end
end

---@return boolean
function VEHICLEKEYS.IsAvailable()
    return vehicleKeysProvider ~= nil and vehicleKeysProvider.GiveKeys ~= nil
end

return VEHICLEKEYS