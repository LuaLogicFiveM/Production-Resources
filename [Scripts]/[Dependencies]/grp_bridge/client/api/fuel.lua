---@diagnostic disable: duplicate-set-field
local FUEL = {}
local fuelProvider
local fuelSystem = "default"
local fuelDebug = config.Debug

---@param system string
---@return table|nil
local function loadFuelSystem(system)
    local res = GetCurrentResourceName()

    if system == "default" then
        return {
            GetResourceName = function() return "default" end,
            GetFuel = function(vehicle)
                if not DoesEntityExist(vehicle) then return 0.0 end
                return GetVehicleFuelLevel(vehicle)
            end,
            SetFuel = function(vehicle, fuel, fuelType)
                if not DoesEntityExist(vehicle) then return end
                SetVehicleFuelLevel(vehicle, fuel)
            end,
            GetFuelCapacity = function(vehicle)
                return 65.0
            end
        }
    end

    local path = ('client/api/fuel/%s.lua'):format(system)
    local src = LoadResourceFile(res, path)
    if src then
        local env = {
            DebugPrint = DebugPrint,
            GetResourceState = GetResourceState,
            DoesEntityExist = DoesEntityExist,
            GetVehicleFuelLevel = GetVehicleFuelLevel,
            SetVehicleFuelLevel = SetVehicleFuelLevel,
            Entity = Entity,
            exports = exports
        }
        setmetatable(env, { __index = _G })

        local chunk, err = load(src, ('=@%s'):format(path), "t", env)
        if chunk then
            local success, mod = pcall(chunk)
            if success and type(mod) == 'table' and mod.GetResourceName then
                if fuelDebug then
                    DebugPrint(('Fuel module loaded: %s'):format(system), "debug")
                end
                return mod
            elseif success and mod == nil then
                if fuelDebug then
                    DebugPrint(('Fuel module %s returned nil (resource not available)'):format(system), "debug")
                end
                return nil
            elseif not success then
                if fuelDebug then
                    DebugPrint(('Error loading fuel module %s: %s'):format(system, mod), "error")
                end
            end
        else
            if fuelDebug then
                DebugPrint(('Failed to load fuel file %s: %s'):format(path, err), "error")
            end
        end
    end

    return nil
end

local fuelSystems = {
    "ox_fuel",
    "qb-fuel",
    "ps-fuel",
    "qs-fuelstations",
    "legacyfuel",
    "renewed-fuel",
    "ti_fuel",
    "lc_fuel",
    "x-fuel",
    "cdn-fuel",
    "esx-sna-fuel",
    "bigdaddy-fuel",
    "okokgasstation"
}

if fuelDebug then
    DebugPrint("Initializing fuel system detection...", "debug")
end

local function detectFuelSystem()
    local configuredFuel = config.Fuel or "auto"

    if configuredFuel ~= "auto" then
        local state = GetResourceState(configuredFuel)
        if state == 'started' or state == 'starting' then
            local mod = loadFuelSystem(configuredFuel)
            if mod then
                fuelProvider = mod
                fuelSystem = configuredFuel
                if fuelDebug then
                    DebugPrint(("Fuel system loaded from config: %s"):format(configuredFuel), "success")
                end
                return
            end
        end
        if fuelDebug then
            DebugPrint(("Configured fuel system '%s' not available (state: %s), falling back to auto-detection"):format(configuredFuel, state), "warning")
        end
    end

    for _, system in ipairs(fuelSystems) do
        local state = GetResourceState(system)
        if state == 'started' or state == 'starting' then
            local mod = loadFuelSystem(system)
            if mod then
                fuelProvider = mod
                fuelSystem = system
                if fuelDebug then
                    DebugPrint("Fuel system loaded via auto-detection: " .. system, "success")
                end
                return
            end
        end
    end

    fuelProvider = loadFuelSystem("default")
    fuelSystem = "default"
    if fuelDebug then
        DebugPrint("No fuel system loaded, using default native fuel", "warning")
    end
end

detectFuelSystem()

---@return string
function FUEL.GetResourceName()
    return fuelSystem or "unknown"
end

---@param vehicle number Vehicle entity handle
---@return number Fuel level (0-100)
function FUEL.GetFuel(vehicle)
    if fuelProvider and fuelProvider.GetFuel then
        return fuelProvider.GetFuel(vehicle)
    end
    if not DoesEntityExist(vehicle) then return 0.0 end
    return GetVehicleFuelLevel(vehicle)
end

---@param vehicle number Vehicle entity handle
---@param fuel number Fuel level to set
---@param fuelType? string Fuel type (for systems that support it)
function FUEL.SetFuel(vehicle, fuel, fuelType)
    if fuelProvider and fuelProvider.SetFuel then
        fuelProvider.SetFuel(vehicle, fuel, fuelType)
        return
    end
    if not DoesEntityExist(vehicle) then return end
    SetVehicleFuelLevel(vehicle, fuel)
end

---@return boolean
function FUEL.IsAvailable()
    return fuelProvider ~= nil and fuelProvider.GetFuel ~= nil
end

---@param vehicle number Vehicle entity handle
---@return number Max fuel capacity
function FUEL.GetFuelCapacity(vehicle)
    if fuelProvider and fuelProvider.GetFuelCapacity then
        return fuelProvider.GetFuelCapacity(vehicle)
    end
    return 65.0
end

---@param vehicle number Vehicle entity handle
---@param threshold? number Fuel threshold (default: 10.0)
---@return boolean
function FUEL.NeedsFuel(vehicle, threshold)
    threshold = threshold or 10.0
    local fuel = FUEL.GetFuel(vehicle)
    return fuel <= threshold
end

---@param vehicle number Vehicle entity handle
---@param fuelType? string Fuel type
function FUEL.Refuel(vehicle, fuelType)
    local capacity = FUEL.GetFuelCapacity(vehicle)
    FUEL.SetFuel(vehicle, capacity, fuelType)
end

return FUEL