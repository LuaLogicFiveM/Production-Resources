local GRP = GRP or {}
local API
local framework

local function waitFor(res)
    local t = GetGameTimer()
    while GetResourceState(res) ~= 'started' do
        if GetGameTimer() - t > 15000 then
            print(('^1[grp_bridge]^7 timeout waiting for %s'):format(res))
            break
        end
        Wait(50)
    end
end

if config.Framework:lower() ~= "auto" then
    framework = config.Framework:lower()
    if config.Debug then
        DebugPrint("Using manually configured framework: " .. framework, "info")
    end
else
    local qb = GetResourceState('qb-core') == "started"
    local qbx = GetResourceState('qbx_core') == "started"
    local esx = GetResourceState('es_extended') == "started"

    if config.Debug then
        DebugPrint("Framework detection results:", "debug")
        DebugPrint("QB-Core: " .. (qb and "Found" or "Not found"), "debug")
        DebugPrint("QBX-Core: " .. (qbx and "Found" or "Not found"), "debug")
        DebugPrint("ESX Extended: " .. (esx and "Found" or "Not found"), "debug")
    end

    if qbx then 
        framework = 'qbx'
        if config.Debug then
            DebugPrint("Framework detected: QBX-Core", "success")
        end
    elseif qb then 
        framework = 'qb'
        if config.Debug then
            DebugPrint("Framework detected: QB-Core", "success")
        end
    elseif esx then 
        framework = 'esx'
        if config.Debug then
            DebugPrint("Framework detected: ESX Extended", "success")
        end
    else
        DebugPrint("Couldn't detect your framework! Please make sure that grp_bridge starts AFTER your framework resource.", "error")
        return error("Unknown Framework")
    end
end

local function loadApiFile(name)
    local res = GetCurrentResourceName()
    local path = ('client/api/%s.lua'):format(name)
    local src = LoadResourceFile(res, path)
    assert(src, ('[grp_bridge] missing api file: %s'):format(path))
    local chunk, err = load(src, ('=@%s'):format(path))
    assert(chunk, err)
    local mod = chunk()
    assert(type(mod) == 'table', ('[grp_bridge] %s must return a table'):format(path))
    return mod
end

local function loadInventoryFile(name)
    local res = GetCurrentResourceName()

    local fileVariations = {
        name,
        name:gsub("-", "_"),
        name:gsub("_", "-"),
    }

    local src, path
    for _, fileName in ipairs(fileVariations) do
        path = ('client/api/inventory/%s.lua'):format(fileName)
        src = LoadResourceFile(res, path)
        if src then
            if config.Debug then
                DebugPrint(('Found inventory file: %s'):format(path), "debug")
            end
            break
        end
    end

    if not src then
        if config.Debug then
            DebugPrint(('Inventory file not found for %s (tried multiple variations)'):format(name), "debug")
        end
        return nil
    end
    local chunk, err = load(src, ('=@%s'):format(path))
    if not chunk then
        if config.Debug then
            DebugPrint(('Error loading inventory file %s: %s'):format(path, err), "error")
        end
        return nil
    end
    local mod = chunk()
    if type(mod) ~= 'table' then
        if config.Debug then
            DebugPrint(('Inventory file %s must return a table'):format(path), "error")
        end
        return nil
    end
    return mod
end

if framework == 'qb' then
    waitFor('qb-core')
    API = loadApiFile('qb')
    -- Register QB-Core player loaded event
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        Wait(1500)
        TriggerEvent('grp_bridge:Client:OnPlayerLoaded')
    end)
    -- Register QB-Core player unload event
    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        TriggerEvent('grp_bridge:Client:OnPlayerUnload')
    end)
    -- Register QB-Core job update event
    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(data)
        TriggerEvent('grp_bridge:Client:OnPlayerJobUpdate', data.name, data.label, data.grade_label, data.grade)
    end)
elseif framework == 'qbx' then
    waitFor('qbx_core')
    API = loadApiFile('qbx')
    -- Register QBX-Core player loaded event
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        Wait(1500)
        TriggerEvent('grp_bridge:Client:OnPlayerLoaded')
    end)
    -- Register QBX-Core player unload event
    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        TriggerEvent('grp_bridge:Client:OnPlayerUnload')
    end)
    -- Register QBX-Core job update event
    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(data)
        TriggerEvent('grp_bridge:Client:OnPlayerJobUpdate', data.name, data.label, data.grade_label, data.grade)
    end)
elseif framework == 'esx' then
    waitFor('es_extended')
    API = loadApiFile('esx')
    -- Register ESX player loaded event
    RegisterNetEvent('esx:playerLoaded', function(xPlayer)
        Wait(1500)
        TriggerEvent('grp_bridge:Client:OnPlayerLoaded')
    end)
    -- Register ESX player unload event
    RegisterNetEvent('esx:playerDropped', function()
        TriggerEvent('grp_bridge:Client:OnPlayerUnload')
    end)
    -- Register ESX job update event
    RegisterNetEvent('esx:setJob', function(job, lastJob)
        TriggerEvent('grp_bridge:Client:OnPlayerJobUpdate', job.name, job.label, job.grade_label, job.grade)
    end)
end

if framework == 'qb' then
    _G.Framework = exports['qb-core']:GetCoreObject()
elseif framework == 'qbx' then
    _G.Framework = exports['qb-core']:GetCoreObject()
elseif framework == 'esx' then
    _G.Framework = exports['es_extended']:getSharedObject()
end

-- Register inventory update event
RegisterNetEvent('grp_bridge:client:inventory:update', function(updateData)
    if config.Debug then
        DebugPrint("Inventory update received: " .. json.encode(updateData), "debug")
    end
    -- Trigger custom event for scripts that want to listen to inventory updates
    TriggerEvent('grp_bridge:client:inventoryUpdate', updateData)
end)

-- Load Target, TextUI, ProgressBar, Fuel, VehicleKeys and Inventory modules
local TARGET = loadApiFile('target')
local TEXTUI = loadApiFile('textui')
local PROGRESSBAR = loadApiFile('progressbar')
local FUEL = loadApiFile('fuel')
local VEHICLEKEYS = loadApiFile('vehiclekeys')

-- Load appropriate inventory system
local inventorySystems = {
    'qb-inventory',
    'ox_inventory',
    'codem-inventory',
    'origen_inventory',
    'qs-inventory',
    'tgiann-inventory',
    'jpr-inventory',
    'ps-inventory',
    'core_inventory'
}

local INVENTORY


if config.Inventory and config.Inventory:lower() ~= "auto" then
    local requestedSystem = config.Inventory:lower()
    local mod = loadInventoryFile(requestedSystem)
    if mod and mod.GetResourceName then
        INVENTORY = mod
        if config.Debug then
            DebugPrint("Loaded inventory client: " .. requestedSystem, "success")
        end
    else
        DebugPrint("Failed to load manually configured inventory system: " .. requestedSystem, "error")
        if config.Debug then
            DebugPrint("Manual inventory system not available, loading default", "debug")
        end
        INVENTORY = loadInventoryFile('_default') 
        if not INVENTORY then
            INVENTORY = {} 
        end
    end
else
    -- Auto-detection mode
    if config.Debug then
        DebugPrint("Inventory system set to auto-detection", "debug")
        DebugPrint("Inventory detection results:", "debug")
        for _, system in ipairs(inventorySystems) do
            local status = GetResourceState(system) == 'started' and "Found" or "Not found"
            DebugPrint(system .. ": " .. status, "debug")
        end
    end

    for _, system in ipairs(inventorySystems) do
        if GetResourceState(system) == 'started' then
            local mod = loadInventoryFile(system)
            if mod and mod.GetResourceName then
                INVENTORY = mod
                if config.Debug then
                    DebugPrint("Loaded inventory client: " .. system, "success")
                end
                break
            end
        end
    end

    if not INVENTORY then
        INVENTORY = loadInventoryFile('_default') 
        if not INVENTORY then
            INVENTORY = {} 
        end
        if config.Debug then
            DebugPrint("No inventory system found, using framework default", "warning")
        end
    end
end

if config.Debug then
    DebugPrint("GRP Bridge initialized successfully with framework: " .. framework, "success")
end

---@return string
function GRP.GetFrameworkName()
    if config.Debug then
        DebugPrint("GetFrameworkName function called", "debug")
    end
    return framework
end

function GRP.IsPlayerLoaded()
    if config.Debug then
        DebugPrint("IsPlayerLoaded function called", "debug")
    end
    return API.IsPlayerLoaded()
end

---@return table
function GRP.GetPlayerData()
    if config.Debug then
        DebugPrint("GetPlayerData function called", "debug")
    end
    return API.GetPlayerData()
end

---@param key string
---@param value any
function GRP.SetPlayerData(key, value)
    if config.Debug then
        DebugPrint("SetPlayerData function called with Key: " .. key .. ", Value: " .. tostring(value), "debug")
    end
    API.SetPlayerData(key, value)
end

function GRP.OpenInventory()
    if config.Debug then
        DebugPrint("OpenInventory function called", "debug")
    end
    API.OpenInventory()
end

---@param text string
function GRP.ShowNotification(text)
    if config.Debug then
        DebugPrint("ShowNotification function called with Text: " .. text, "debug")
    end
    API.ShowNotification(text)
end

---@param code string Dispatch code (10-XX)
---@param title string Dispatch title message
---@param message string Dispatch description
---@param blip number Blip sprite number
---@param jobs table Table containing recipient jobs
---@param important boolean | number Is the dispatch important?
function GRP.Dispatch(code, title, message, blip, jobs, important)
    if config.Debug then
        DebugPrint("Dispatch function called with Code: " .. tostring(code) .. ", Title: " .. tostring(title), "debug")
    end
    API.Dispatch(code, title, message, blip, jobs, important)
end

---@return string
function GRP.GetJob()
    if config.Debug then
        DebugPrint("GetJob function called", "debug")
    end
    return API.GetJob()
end

---@return number
function GRP.GetJobGrade()
    if config.Debug then
        DebugPrint("GetJobGrade function called", "debug")
    end
    return API.GetJobGrade()
end

---@return table jobInfo
function GRP.GetJobInfo()
    if config.Debug then
        DebugPrint("GetJobInfo function called", "debug")
    end
    return API.GetJobInfo()
end

---@param item_name string Item name
---@return boolean, number hasItem Returns true if player has given item in inventory and item count
function GRP.HasItem(item_name)
    if config.Debug then
        DebugPrint("HasItem function called with Item: " .. item_name, "debug")
    end
    if INVENTORY and INVENTORY.HasItem then
        local hasItem = INVENTORY.HasItem(item_name, 1)
        if hasItem then
            local count = (INVENTORY.GetItemCount and INVENTORY.GetItemCount(item_name)) or 1
            return true, count
        end
        return false, 0
    end
    if API and API.HasItem then
        return API.HasItem(item_name)
    end
    return false, 0
end

---@return table
function GRP.GetInventory()
    if config.Debug then
        DebugPrint("GetInventory function called", "debug")
    end
    return API.GetInventory()
end

--- Inventory System Functions

function GRP.GetInventoryResourceName()
    if config.Debug then
        DebugPrint("GetInventoryResourceName function called", "debug")
    end
    if INVENTORY and INVENTORY.GetResourceName then
        return INVENTORY.GetResourceName()
    end
    return "default"
end

function GRP.GetItemInfo(item)
    if config.Debug then
        DebugPrint("GetItemInfo function called with Item: " .. tostring(item), "debug")
    end
    if INVENTORY and INVENTORY.GetItemInfo then
        return INVENTORY.GetItemInfo(item)
    end
    return {}
end

function GRP.GetAllItems()
    if config.Debug then
        DebugPrint("GetAllItems function called", "debug")
    end
    if INVENTORY and INVENTORY.Items then
        return INVENTORY.Items()
    end
    return {}
end

function GRP.GetItemCount(item)
    if config.Debug then
        DebugPrint("GetItemCount function called with Item: " .. tostring(item), "debug")
    end
    if INVENTORY and INVENTORY.GetItemCount then
        return INVENTORY.GetItemCount(item)
    end
    return 0
end

function GRP.GetPlayerInventory()
    if config.Debug then
        DebugPrint("GetPlayerInventory function called", "debug")
    end
    if INVENTORY and INVENTORY.GetPlayerInventory then
        return INVENTORY.GetPlayerInventory()
    end
    return {}
end

function GRP.GetImagePath(item)
    if config.Debug then
        DebugPrint("GetImagePath function called with Item: " .. tostring(item), "debug")
    end
    if INVENTORY and INVENTORY.GetImagePath then
        return INVENTORY.GetImagePath(item)
    end
    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

function GRP.CanCarryItem(item, count)
    if config.Debug then
        DebugPrint("CanCarryItem function called with Item: " .. tostring(item) .. ", Count: " .. tostring(count), "debug")
    end
    if INVENTORY and INVENTORY.CanCarryItem then
        return INVENTORY.CanCarryItem(item, count)
    end
    return true
end

function GRP.GetInventoryWeight()
    if config.Debug then
        DebugPrint("GetInventoryWeight function called", "debug")
    end
    if INVENTORY and INVENTORY.GetInventoryWeight then
        return INVENTORY.GetInventoryWeight()
    end
    return 0
end

function GRP.GetInventoryMaxWeight()
    if config.Debug then
        DebugPrint("GetInventoryMaxWeight function called", "debug")
    end
    if INVENTORY and INVENTORY.GetInventoryMaxWeight then
        return INVENTORY.GetInventoryMaxWeight()
    end
    return 100000
end

-- ============================================
-- FUEL SYSTEM FUNCTIONS
-- ============================================

---@return string
function GRP.GetFuelResourceName()
    if config.Debug then
        DebugPrint("GetFuelResourceName function called", "debug")
    end
    if FUEL and FUEL.GetResourceName then
        return FUEL.GetResourceName()
    end
    return "default"
end

---@param vehicle number Vehicle entity handle
---@return number Fuel level (0-100)
function GRP.GetFuel(vehicle)
    if config.Debug then
        DebugPrint("GetFuel function called", "debug")
    end
    if FUEL and FUEL.GetFuel then
        return FUEL.GetFuel(vehicle)
    end
    return 0.0
end

---@param vehicle number Vehicle entity handle
---@param fuel number Fuel level to set
---@param fuelType? string Fuel type (for systems that support it)
function GRP.SetFuel(vehicle, fuel, fuelType)
    if config.Debug then
        DebugPrint("SetFuel function called with fuel: " .. tostring(fuel), "debug")
    end
    if FUEL and FUEL.SetFuel then
        FUEL.SetFuel(vehicle, fuel, fuelType)
    end
end

---@return boolean
function GRP.IsFuelSystemAvailable()
    if config.Debug then
        DebugPrint("IsFuelSystemAvailable function called", "debug")
    end
    if FUEL and FUEL.IsAvailable then
        return FUEL.IsAvailable()
    end
    return false
end

---@param vehicle number Vehicle entity handle
---@return number Max fuel capacity
function GRP.GetFuelCapacity(vehicle)
    if config.Debug then
        DebugPrint("GetFuelCapacity function called", "debug")
    end
    if FUEL and FUEL.GetFuelCapacity then
        return FUEL.GetFuelCapacity(vehicle)
    end
    return 65.0
end

---@param vehicle number Vehicle entity handle
---@param threshold? number Fuel threshold (default: 10.0)
---@return boolean
function GRP.NeedsFuel(vehicle, threshold)
    if config.Debug then
        DebugPrint("NeedsFuel function called", "debug")
    end
    if FUEL and FUEL.NeedsFuel then
        return FUEL.NeedsFuel(vehicle, threshold)
    end
    threshold = threshold or 10.0
    local fuel = GRP.GetFuel(vehicle)
    return fuel <= threshold
end

---@param vehicle number Vehicle entity handle
---@param fuelType? string Fuel type
function GRP.Refuel(vehicle, fuelType)
    if config.Debug then
        DebugPrint("Refuel function called", "debug")
    end
    if FUEL and FUEL.Refuel then
        FUEL.Refuel(vehicle, fuelType)
    else
        local capacity = GRP.GetFuelCapacity(vehicle)
        GRP.SetFuel(vehicle, capacity, fuelType)
    end
end

---@return string
function GRP.GetVehicleKeysResourceName()
    if config.Debug then
        DebugPrint("GetVehicleKeysResourceName function called", "debug")
    end
    if VEHICLEKEYS and VEHICLEKEYS.GetResourceName then
        return VEHICLEKEYS.GetResourceName()
    end
    return "unknown"
end

---@param vehicle number Vehicle entity handle
---@param plate? string Vehicle plate
function GRP.GiveVehicleKeys(vehicle, plate)
    if config.Debug then
        DebugPrint("GiveVehicleKeys function called", "debug")
    end
    if VEHICLEKEYS and VEHICLEKEYS.GiveKeys then
        VEHICLEKEYS.GiveKeys(vehicle, plate)
    else
        if DoesEntityExist(vehicle) then
            SetVehicleDoorsLocked(vehicle, 1)
        end
    end
end

---@param vehicle number Vehicle entity handle
---@param plate? string Vehicle plate
function GRP.RemoveVehicleKeys(vehicle, plate)
    if config.Debug then
        DebugPrint("RemoveVehicleKeys function called", "debug")
    end
    if VEHICLEKEYS and VEHICLEKEYS.RemoveKeys then
        VEHICLEKEYS.RemoveKeys(vehicle, plate)
    end
end

---@return boolean
function GRP.IsVehicleKeysSystemAvailable()
    if config.Debug then
        DebugPrint("IsVehicleKeysSystemAvailable function called", "debug")
    end
    if VEHICLEKEYS and VEHICLEKEYS.IsAvailable then
        return VEHICLEKEYS.IsAvailable()
    end
    return false
end

function GRP.CloseMenu()
    if config.Debug then
        DebugPrint("CloseMenu function called", "debug")
    end
    API.CloseMenu()
end

---@param metadata string Metadata key
---@return any metadata value
function GRP.GetPlayerMetaData(metadata)
    if config.Debug then
        DebugPrint("GetPlayerMetaData function called with Metadata: " .. metadata, "debug")
    end
    return API.GetPlayerMetaData(metadata)
end

---@return boolean dead status
function GRP.GetIsPlayerDead()
    if config.Debug then
        DebugPrint("GetIsPlayerDead function called", "debug")
    end
    return API.GetIsPlayerDead()
end

---@return string firstname, string lastname
function GRP.GetPlayerName()
    if config.Debug then
        DebugPrint("GetPlayerName function called", "debug")
    end
    return API.GetPlayerName()
end

-- ============================================
-- TARGET SYSTEM FUNCTIONS
-- ============================================

---Toggle targeting system on/off
---@param disable boolean
function GRP.DisableTargeting(disable)
    if config.Debug then
        DebugPrint("DisableTargeting function called with: " .. tostring(disable), "debug")
    end
    return TARGET.DisableTargeting(disable)
end

---Add target options to all players
---@param options table
function GRP.AddGlobalPlayer(options)
    if config.Debug then
        DebugPrint("AddGlobalPlayer function called", "debug")
    end
    return TARGET.AddGlobalPlayer(options)
end

---Remove target options from all players
---@param optionNames string|table|nil
function GRP.RemoveGlobalPlayer(optionNames)
    if config.Debug then
        DebugPrint("RemoveGlobalPlayer function called", "debug")
    end
    return TARGET.RemoveGlobalPlayer(optionNames)
end

---Add target options to all peds
---@param options table
function GRP.AddGlobalPed(options)
    if config.Debug then
        DebugPrint("AddGlobalPed function called", "debug")
    end
    return TARGET.AddGlobalPed(options)
end

---Remove target options from all peds
---@param optionNames string|table|nil
function GRP.RemoveGlobalPed(optionNames)
    if config.Debug then
        DebugPrint("RemoveGlobalPed function called", "debug")
    end
    return TARGET.RemoveGlobalPed(optionNames)
end

---Add target options to all vehicles
---@param options table
function GRP.AddGlobalVehicle(options)
    if config.Debug then
        DebugPrint("AddGlobalVehicle function called", "debug")
    end
    return TARGET.AddGlobalVehicle(options)
end

---Remove target options from all vehicles
---@param optionNames string|table|nil
function GRP.RemoveGlobalVehicle(optionNames)
    if config.Debug then
        DebugPrint("RemoveGlobalVehicle function called", "debug")
    end
    return TARGET.RemoveGlobalVehicle(optionNames)
end

---Add target to local entity
---@param entities number|table
---@param options table
function GRP.AddLocalEntity(entities, options)
    if config.Debug then
        DebugPrint("AddLocalEntity function called", "debug")
    end
    return TARGET.AddLocalEntity(entities, options)
end

---Remove target from local entity
---@param entities number|table
---@param labels string|table|nil
function GRP.RemoveLocalEntity(entities, labels)
    if config.Debug then
        DebugPrint("RemoveLocalEntity function called", "debug")
    end
    return TARGET.RemoveLocalEntity(entities, labels)
end

---Add target to networked entity
---@param netids number|table
---@param options table
function GRP.AddNetworkedEntity(netids, options)
    if config.Debug then
        DebugPrint("AddNetworkedEntity function called", "debug")
    end
    return TARGET.AddNetworkedEntity(netids, options)
end

---Remove target from networked entity
---@param netids number|table
---@param labels string|table|nil
function GRP.RemoveNetworkedEntity(netids, labels)
    if config.Debug then
        DebugPrint("RemoveNetworkedEntity function called", "debug")
    end
    return TARGET.RemoveNetworkedEntity(netids, labels)
end

---Add target to model
---@param models number|table
---@param options table
function GRP.AddModel(models, options)
    if config.Debug then
        DebugPrint("AddModel function called", "debug")
    end
    return TARGET.AddModel(models, options)
end

---Remove target from model
---@param models number|table
---@param labels string|table|nil
function GRP.RemoveModel(models, labels)
    if config.Debug then
        DebugPrint("RemoveModel function called", "debug")
    end
    return TARGET.RemoveModel(models, labels)
end

---Add box zone target
---@param name string
---@param coords vector3
---@param size vector3
---@param heading number
---@param options table
---@param debug boolean|nil
function GRP.AddBoxZone(name, coords, size, heading, options, debug)
    if config.Debug then
        DebugPrint("AddBoxZone function called with name: " .. name, "debug")
    end
    return TARGET.AddBoxZone(name, coords, size, heading, options, debug)
end

---Add sphere/circle zone target
---@param name string
---@param coords vector3
---@param radius number
---@param options table
---@param debug boolean|nil
function GRP.AddSphereZone(name, coords, radius, options, debug)
    if config.Debug then
        DebugPrint("AddSphereZone function called with name: " .. name, "debug")
    end
    return TARGET.AddSphereZone(name, coords, radius, options, debug)
end

---Remove zone by name
---@param name string
function GRP.RemoveZone(name)
    if config.Debug then
        DebugPrint("RemoveZone function called with name: " .. name, "debug")
    end
    return TARGET.RemoveZone(name)
end

---Get current target system name
---@return string|nil
function GRP.GetTargetResourceName()
    return TARGET.GetResourceName()
end

-- ============================================
-- TEXTUI SYSTEM FUNCTIONS
-- ============================================

---Show help text on screen
---@param message string
---@param position string|nil
function GRP.ShowHelpText(message, position)
    if config.Debug then
        DebugPrint("ShowHelpText function called with message: " .. message, "debug")
    end
    return TEXTUI.ShowHelpText(message, position)
end

---Hide help text from screen
function GRP.HideHelpText()
    if config.Debug then
        DebugPrint("HideHelpText function called", "debug")
    end
    return TEXTUI.HideHelpText()
end

---Show advanced textui with icon
---@param options table
function GRP.ShowAdvancedText(options)
    if config.Debug then
        DebugPrint("ShowAdvancedText function called", "debug")
    end
    return TEXTUI.ShowAdvancedText(options)
end

---Update textui message
---@param message string
function GRP.UpdateText(message)
    if config.Debug then
        DebugPrint("UpdateText function called with message: " .. message, "debug")
    end
    return TEXTUI.UpdateText(message)
end

---Check if textui is showing
---@return boolean
function GRP.IsTextUIShowing()
    return TEXTUI.IsShowing()
end

---Get current TextUI system name
---@return string
function GRP.GetTextUIResourceName()
    return TEXTUI.GetResourceName()
end

---Show key-based help text
---@param key string
---@param message string
function GRP.ShowKeyHelp(key, message)
    if config.Debug then
        DebugPrint("ShowKeyHelp function called with key: " .. key, "debug")
    end
    return TEXTUI.ShowKeyHelp(key, message)
end

---Draw 3D text at coords
---@param coords vector3
---@param text string
---@param scale number|nil
function GRP.Draw3DText(coords, text, scale)
    return TEXTUI.Draw3DText(coords, text, scale)
end

-- ============================================
-- PROGRESS BAR SYSTEM FUNCTIONS
-- ============================================

---Show progress bar
---@param options table
---@param callback function|nil
---@param isQBFormat boolean|nil
function GRP.ShowProgress(options, callback, isQBFormat)
    if config.Debug then
        DebugPrint("ShowProgress function called", "debug")
    end
    return PROGRESSBAR.ShowProgress(options, callback, isQBFormat)
end

---Get current progress bar system name
---@return string|nil
function GRP.GetProgressBarResourceName()
    return PROGRESSBAR.GetResourceName()
end


exports("GetPlayerData", function()
    return GRP.GetPlayerData()
end)

exports("IsPlayerLoaded", function()
    return GRP.IsPlayerLoaded()
end)

exports("SetPlayerData", function(key, value)
    GRP.SetPlayerData(key, value)
end)

exports("OpenInventory", function()
    GRP.OpenInventory()
end)

exports("ShowNotification", function(text)
    GRP.ShowNotification(text)
end)

exports("Dispatch", function(code, title, message, blip, jobs, important)
    GRP.Dispatch(code, title, message, blip, jobs, important)
end)

exports("GetJob", function()
    return GRP.GetJob()
end)

exports("GetJobGrade", function()
    return GRP.GetJobGrade()
end)

exports("GetJobInfo", function()
    return GRP.GetJobInfo()
end)

exports("HasItem", function(item_name)
    return GRP.HasItem(item_name)
end)

exports("GetInventory", function()
    return GRP.GetInventory()
end)

exports("GetItemInfo", function(item)
    return GRP.GetItemInfo(item)
end)

exports("Items", function()
    return GRP.GetAllItems()
end)

exports("CloseMenu", function()
    return GRP.CloseMenu()
end)

exports("GetPlayerMetaData", function(metadata)
    return GRP.GetPlayerMetaData(metadata)
end)

exports("GetIsPlayerDead", function()
    return GRP.GetIsPlayerDead()
end)

exports("GetPlayerName", function()
    return GRP.GetPlayerName()
end)

exports("GetGRP", function()
    return GRP
end)

-- ============================================
-- TARGET EXPORTS
-- ============================================

exports("DisableTargeting", function(disable)
    return GRP.DisableTargeting(disable)
end)

exports("AddGlobalPlayer", function(options)
    return GRP.AddGlobalPlayer(options)
end)

exports("RemoveGlobalPlayer", function(optionNames)
    return GRP.RemoveGlobalPlayer(optionNames)
end)

exports("AddGlobalPed", function(options)
    return GRP.AddGlobalPed(options)
end)

exports("RemoveGlobalPed", function(optionNames)
    return GRP.RemoveGlobalPed(optionNames)
end)

exports("AddGlobalVehicle", function(options)
    return GRP.AddGlobalVehicle(options)
end)

exports("RemoveGlobalVehicle", function(optionNames)
    return GRP.RemoveGlobalVehicle(optionNames)
end)

exports("AddLocalEntity", function(entities, options)
    return GRP.AddLocalEntity(entities, options)
end)

exports("RemoveLocalEntity", function(entities, labels)
    return GRP.RemoveLocalEntity(entities, labels)
end)

exports("AddNetworkedEntity", function(netids, options)
    return GRP.AddNetworkedEntity(netids, options)
end)

exports("RemoveNetworkedEntity", function(netids, labels)
    return GRP.RemoveNetworkedEntity(netids, labels)
end)

exports("AddModel", function(models, options)
    return GRP.AddModel(models, options)
end)

exports("RemoveModel", function(models, labels)
    return GRP.RemoveModel(models, labels)
end)

exports("AddBoxZone", function(name, coords, size, heading, options, debug)
    return GRP.AddBoxZone(name, coords, size, heading, options, debug)
end)

exports("AddSphereZone", function(name, coords, radius, options, debug)
    return GRP.AddSphereZone(name, coords, radius, options, debug)
end)

exports("RemoveZone", function(name)
    return GRP.RemoveZone(name)
end)

exports("GetTargetResourceName", function()
    return GRP.GetTargetResourceName()
end)

-- ============================================
-- TEXTUI EXPORTS
-- ============================================

exports("ShowHelpText", function(message, position)
    return GRP.ShowHelpText(message, position)
end)

exports("HideHelpText", function()
    return GRP.HideHelpText()
end)

exports("ShowAdvancedText", function(options)
    return GRP.ShowAdvancedText(options)
end)

exports("UpdateText", function(message)
    return GRP.UpdateText(message)
end)

exports("IsTextUIShowing", function()
    return GRP.IsTextUIShowing()
end)

exports("GetTextUIResourceName", function()
    return GRP.GetTextUIResourceName()
end)

exports("ShowKeyHelp", function(key, message)
    return GRP.ShowKeyHelp(key, message)
end)

exports("Draw3DText", function(coords, text, scale)
    return GRP.Draw3DText(coords, text, scale)
end)

-- ============================================
-- PROGRESS BAR EXPORTS
-- ============================================

exports("ShowProgress", function(options, callback, isQBFormat)
    return GRP.ShowProgress(options, callback, isQBFormat)
end)

exports("GetProgressBarResourceName", function()
    return GRP.GetProgressBarResourceName()
end)

-- ============================================
-- FUEL EXPORTS
-- ============================================

exports("GetFuelResourceName", function()
    return GRP.GetFuelResourceName()
end)

exports("GetFuel", function(vehicle)
    return GRP.GetFuel(vehicle)
end)

exports("SetFuel", function(vehicle, fuel, fuelType)
    GRP.SetFuel(vehicle, fuel, fuelType)
end)

exports("IsFuelSystemAvailable", function()
    return GRP.IsFuelSystemAvailable()
end)

exports("GetFuelCapacity", function(vehicle)
    return GRP.GetFuelCapacity(vehicle)
end)

exports("NeedsFuel", function(vehicle, threshold)
    return GRP.NeedsFuel(vehicle, threshold)
end)

exports("Refuel", function(vehicle, fuelType)
    GRP.Refuel(vehicle, fuelType)
end)

-- ============================================
-- VEHICLE KEYS EXPORTS
-- ============================================

exports("GetVehicleKeysResourceName", function()
    return GRP.GetVehicleKeysResourceName()
end)

exports("GiveVehicleKeys", function(vehicle, plate)
    GRP.GiveVehicleKeys(vehicle, plate)
end)

exports("RemoveVehicleKeys", function(vehicle, plate)
    GRP.RemoveVehicleKeys(vehicle, plate)
end)

exports("IsVehicleKeysSystemAvailable", function()
    return GRP.IsVehicleKeysSystemAvailable()
end)

-- Player loaded event handler (similar to community_bridge)
local playerLoaded = false
AddEventHandler('grp_bridge:Client:OnPlayerLoaded', function()
    if playerLoaded then return end
    playerLoaded = true

    if config.Debug then
        DebugPrint("Player loaded via GRP Bridge", "success")
    end
end)