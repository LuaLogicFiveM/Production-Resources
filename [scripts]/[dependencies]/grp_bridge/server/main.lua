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
    local path = ('server/api/%s.lua'):format(name)
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
        path = ('server/api/inventory/%s.lua'):format(fileName)
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
elseif framework == 'qbx' then
    waitFor('qbx_core')
    API = loadApiFile('qbx')
elseif framework == 'esx' then
    waitFor('es_extended')
    API = loadApiFile('esx')
end

-- Set Framework globally for server-side inventory APIs
if framework == 'qb' then
    _G.Framework = exports['qb-core']:GetCoreObject()
elseif framework == 'qbx' then
    _G.Framework = exports['qb-core']:GetCoreObject()
elseif framework == 'esx' then
    _G.Framework = exports['es_extended']:getSharedObject()
end

local function loadGRP_BankingModule()
    local bankingSystems = {
        'qb-banking',
        'okokBanking',
        'fd_banking',
        'renewed-banking',
        'tgg-banking',
        'kartik-banking',
        'tgiann-bank',
        'wasabi_banking',
        'qb-management',
        'qbx_management',
        'esx_society',
        'qs-banking'
    }

    if config.Banking and config.Banking:lower() ~= "auto" then
        local requestedSystem = config.Banking:lower()
        local found = false

        for _, system in ipairs(bankingSystems) do
            if system:lower() == requestedSystem then
                local fileName = 'banking/' .. system
                local path = ('server/api/%s.lua'):format(fileName)

                if LoadResourceFile(GetCurrentResourceName(), path) then
                    if config.Debug then
                        DebugPrint("Loading manually configured GRP_Banking module: " .. system, "debug")
                    end

                    local success, mod = pcall(loadApiFile, fileName)
                    if success and mod and mod.GetSystemName then
                        GRP_Banking = mod
                        if config.Debug then
                            DebugPrint("GRP_Banking module loaded: " .. mod.GetSystemName(), "success")
                        end
                        return
                    else
                        DebugPrint("Failed to load manually configured banking system: " .. system, "error")
                        found = true
                        break
                    end
                else
                    DebugPrint("Manually configured banking system '" .. system .. "' file not found", "error")
                    found = true
                    break
                end
            end
        end

        if not found then
            DebugPrint("Invalid banking system specified in config: " .. config.Banking, "error")
            DebugPrint("Valid options: auto, " .. table.concat(bankingSystems, ", "), "error")
        end

        if config.Debug then
            DebugPrint("Manual banking system not available, loading default", "debug")
        end
        GRP_Banking = loadApiFile('banking/_default')
        return
    end

    -- Auto-detection mode (original behavior)
    if config.Debug then
        DebugPrint("Banking system set to auto-detection", "debug")
    end

    for _, system in ipairs(bankingSystems) do
        local fileName = 'banking/' .. system
        local path = ('server/api/%s.lua'):format(fileName)

        if LoadResourceFile(GetCurrentResourceName(), path) then
            if config.Debug then
                DebugPrint("Loading GRP_Banking module: " .. system, "debug")
            end

            local success, mod = pcall(loadApiFile, fileName)
            if success and mod and mod.GetSystemName then
                GRP_Banking = mod
                if config.Debug then
                    DebugPrint("GRP_Banking module loaded: " .. mod.GetSystemName(), "success")
                end
                return
            end
        end
    end

    if config.Debug then
        DebugPrint("No banking system found, loading default", "debug")
    end
    GRP_Banking = loadApiFile('banking/_default')
end

loadGRP_BankingModule()

local function loadGRP_InventoryModule()
    if config.Inventory and config.Inventory:lower() ~= "auto" then
        local requestedSystem = config.Inventory:lower()
        local fileName = 'inventory/' .. requestedSystem
        local path = ('server/api/%s.lua'):format(fileName)

        local mod = loadInventoryFile(requestedSystem)
        if mod and mod.GetResourceName then
            GRP_Inventory = mod
            if config.Debug then
                DebugPrint("GRP_Inventory module loaded: " .. mod.GetResourceName(), "success")
            end
            return
        else
            DebugPrint("Failed to load manually configured inventory system: " .. requestedSystem, "error")
        end

        if config.Debug then
            DebugPrint("Manual inventory system not available, loading default", "debug")
        end
        GRP_Inventory = loadInventoryFile('_default')
        return
    end

    -- Auto-detection mode
    if config.Debug then
        DebugPrint("Inventory system set to auto-detection", "debug")
    end

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

    if config.Debug then
        DebugPrint("Inventory detection results:", "debug")
        for _, system in ipairs(inventorySystems) do
            local status = GetResourceState(system) == 'started' and "Found" or "Not found"
            DebugPrint(system .. ": " .. status, "debug")
        end
    end

    for _, system in ipairs(inventorySystems) do
        if GetResourceState(system) == 'started' then
            if config.Debug then
                DebugPrint("Loading GRP_Inventory module: " .. system, "debug")
            end

            local mod = loadInventoryFile(system)
            if mod and mod.GetResourceName then
                GRP_Inventory = mod
                if config.Debug then
                    DebugPrint("GRP_Inventory module loaded: " .. mod.GetResourceName(), "success")
                end
                return
            else
                if config.Debug then
                    DebugPrint("Failed to load " .. system .. " inventory module", "warning")
                end
            end
        end
    end

    if config.Debug then
        DebugPrint("No inventory system found, loading default", "debug")
    end
    GRP_Inventory = loadInventoryFile('_default')
end

loadGRP_InventoryModule()

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

---@param id number
---@return table
function GRP.GetPlayer(id)
    if config.Debug then
        DebugPrint("GetPlayer function called with ID: " .. id, "debug")
    end
    return API.GetPlayer(id)
end

---@return table
function GRP.GetAllPlayers()
    if config.Debug then
        DebugPrint("GetAllPlayers function called", "debug")
    end
    return API.GetAllPlayers()
end

---@param id number
---@return string name, string label, string grade_name, number grade_level
function GRP.GetPlayerJob(id)
    if config.Debug then
        DebugPrint("GetPlayerJob function called with ID: " .. id, "debug")
    end
    return API.GetPlayerJob(id)
end

---@param id number
---@return number
function GRP.GetPlayerJobGrade(id)
    if config.Debug then
        DebugPrint("GetPlayerJobGrade function called with ID: " .. id, "debug")
    end
    return API.GetPlayerJobGrade(id)
end

---@param id number
---@return table jobInfo
function GRP.GetPlayerJobInfo(id)
    if config.Debug then
        DebugPrint("GetPlayerJobInfo function called with ID: " .. id, "debug")
    end
    return API.GetPlayerJobInfo(id)
end

---@param playerId number
---@return boolean
function GRP.HasPermission(playerId)
    if config.Debug then
        DebugPrint("HasPermission function called with PlayerID: " .. playerId, "debug")
    end
    return API.HasPermission(playerId)
end

---@param playerId number Target player ID
---@param amount number Amount to add
function GRP.AddMoney(playerId, amount)
    if config.Debug then
        DebugPrint("AddMoney function called with PlayerID: " .. playerId .. ", Amount: " .. amount, "debug")
    end
    amount = tonumber(amount) or 0
    if amount <= 0 then return false end
    return API.AddMoney(playerId, amount)
end

---@param playerId number
---@param amount number
function GRP.RemoveMoney(playerId, amount)
    if config.Debug then
        DebugPrint("RemoveMoney function called with PlayerID: " .. playerId .. ", Amount: " .. amount, "debug")
    end
    amount = tonumber(amount) or 0
    if amount <= 0 then return false end
    return API.RemoveMoney(playerId, amount)
end

function GRP.RemoveBankMoney(playerId, amount)
    if config.Debug then
        DebugPrint("RemoveBankMoney function called with PlayerID: " .. playerId .. ", Amount: " .. amount, "debug")
    end
    amount = tonumber(amount) or 0
    if amount <= 0 then return false end
    return API.RemoveBankMoney(playerId, amount)
end

function GRP.GetMoney(playerId)
    if config.Debug then
        DebugPrint("GetMoney function called with PlayerID: " .. playerId, "debug")
    end
    return API.GetMoney(playerId)
end

function GRP.GetBankMoney(playerId)
    if config.Debug then
        DebugPrint("GetBankMoney function called with PlayerID: " .. playerId, "debug")
    end
    return API.GetBankMoney(playerId)
end

---@param from number Sender's ID
---@param to number Receiver's ID
---@param amount number Amount to transfer
---@return boolean status, string statusMessage
function GRP.TransferMoney(from, to, amount)
    if config.Debug then
        DebugPrint(("TransferMoney From:%s To:%s Amount:%s"):format(from, to, amount), "debug")
    end
    amount = tonumber(amount) or 0
    if amount <= 0 then return false, "Invalid amount" end
    if not GetPlayerName(to) then return false, "Not Online" end
    return API.TransferMoney(from, to, amount)
end


function GRP.SetJob(playerId, job_name, job_grade)
    if config.Debug then
        DebugPrint("SetJob function called with PlayerID: " .. playerId .. ", Job: " .. job_name .. ", Grade: " .. job_grade, "debug")
    end
    return API.SetJob(playerId, job_name, job_grade)
end

function GRP.GetIdentifier(playerId)
    if config.Debug then
        DebugPrint("GetIdentifier function called with PlayerID: " .. playerId, "debug")
    end
    return API.GetIdentifier(playerId)
end

---@param cid string
---@return table|nil
function GRP.GetPlayerByCitizenId(cid)
    if config.Debug then
        DebugPrint("GetPlayerByCitizenId function called with CID: " .. tostring(cid), "debug")
    end
    if not cid then return nil end
    return API.GetPlayerByCitizenId(cid)
end

---@param playerId number Target player ID
---@return string firstname, string lastname
function GRP.GetPlayerName(playerId) 
    if config.Debug then
        DebugPrint("GetPlayerName function called" .. (playerId and (" with PlayerID: "..playerId) or ""), "debug")
    end
    return API.GetPlayerName(playerId)
end

---@param playerId number Target player ID
---@return vector3 coords Player Coords
function GRP.GetPlayerCoords(playerId)
    if config.Debug then
        DebugPrint("GetPlayerCoords function called with PlayerID: " .. playerId, "debug")
    end
    return API.GetPlayerCoords(playerId)
end

---@param playerId number Target player ID
---@param metadata string Metadata key
---@return any metadata value
function GRP.GetPlayerMetadata(playerId, metadata)
    if config.Debug then
        DebugPrint("GetPlayerMetadata function called with PlayerID: " .. playerId .. ", Metadata: " .. metadata, "debug")
    end
    return API.GetPlayerMetadata(playerId, metadata)
end

---@param playerId number Target player ID
---@param metadata string Metadata key
---@param value any Metadata value
---@return boolean success
function GRP.SetPlayerMetadata(playerId, metadata, value)
    if config.Debug then
        DebugPrint(("SetPlayerMetadata called | PlayerID: %s | Key: %s | Value: %s")
            :format(tostring(playerId), tostring(metadata), tostring(value)), "debug")
    end
    return API.SetPlayerMetadata(playerId, metadata, value)
end

---@param playerId number Target player ID
---@return boolean duty status
function GRP.GetPlayerDuty(playerId)
    if config.Debug then
        DebugPrint("GetPlayerDuty function called with PlayerID: " .. playerId, "debug")
    end
    return API.GetPlayerDuty(playerId)
end

---@param playerId number Target player ID
---@return boolean dead status
function GRP.GetIsPlayerDead(playerId)
    if config.Debug then
        DebugPrint("GetIsPlayerDead function called with PlayerID: " .. playerId, "debug")
    end
    return API.GetIsPlayerDead(playerId)
end

function GRP.RevivePlayer(playerId)
    if config.Debug then
        DebugPrint("RevivePlayer function called with PlayerID: " .. playerId, "debug")
    end
    playerId = tonumber(playerId)
    if not playerId then return false end
    return API.RevivePlayer(playerId)
end

function GRP.RegisterUsableItem(itemName, cb)
    if config.Debug then
        DebugPrint("RegisterUsableItem function called with ItemName: " .. itemName, "debug")
    end
    return API.RegisterUsableItem(itemName, cb)
end

function GRP.AddAccountMoney(accountName, amount, reason)
    if config.Debug then
        DebugPrint("AddAccountMoney function called with Account: " .. accountName .. ", Amount: " .. amount, "debug")
    end
    amount = tonumber(amount) or 0
    if amount <= 0 then return false end
    return GRP_Banking.AddAccountFunds(accountName, amount, reason)
end

function GRP.RemoveAccountMoney(accountName, amount, reason)
    if config.Debug then
        DebugPrint("RemoveAccountMoney function called with Account: " .. accountName .. ", Amount: " .. amount, "debug")
    end
    amount = tonumber(amount) or 0
    if amount <= 0 then return false end
    return GRP_Banking.RemoveAccountFunds(accountName, amount, reason)
end

function GRP.GetAccountMoney(accountName)
    if config.Debug then
        DebugPrint("GetAccountMoney function called with Account: " .. accountName, "debug")
    end
    return GRP_Banking.GetAccountBalance(accountName)
end

--- Inventory System Functions

function GRP.GetInventoryResourceName()
    if config.Debug then
        DebugPrint("GetInventoryResourceName function called", "debug")
    end
    if GRP_Inventory and GRP_Inventory.GetResourceName then
        return GRP_Inventory.GetResourceName()
    end
    return "default"
end

function GRP.GetItemInfo(item)
    if config.Debug then
        DebugPrint("GetItemInfo function called with Item: " .. tostring(item), "debug")
    end
    if GRP_Inventory and GRP_Inventory.GetItemInfo then
        return GRP_Inventory.GetItemInfo(item)
    end
    return {}
end

function GRP.GetAllItems()
    if config.Debug then
        DebugPrint("GetAllItems function called", "debug")
    end
    if GRP_Inventory and GRP_Inventory.Items then
        return GRP_Inventory.Items()
    end
    return {}
end

function GRP.GetItemCount(playerId, item, metadata)
    if config.Debug then
        DebugPrint("GetItemCount function called with PlayerID: " .. playerId .. ", Item: " .. item, "debug")
    end
    if GRP_Inventory and GRP_Inventory.GetItemCount then
        return GRP_Inventory.GetItemCount(playerId, item, metadata)
    end
    return 0
end

function GRP.GetPlayerInventory(playerId)
    if config.Debug then
        DebugPrint("GetPlayerInventory function called with PlayerID: " .. playerId, "debug")
    end
    if GRP_Inventory and GRP_Inventory.GetPlayerInventory then
        return GRP_Inventory.GetPlayerInventory(playerId)
    end
    return {}
end

function GRP.GetItemBySlot(playerId, slot)
    if config.Debug then
        DebugPrint("GetItemBySlot function called with PlayerID: " .. playerId .. ", Slot: " .. slot, "debug")
    end
    if GRP_Inventory and GRP_Inventory.GetItemBySlot then
        return GRP_Inventory.GetItemBySlot(playerId, slot)
    end
    return {}
end

function GRP.SetItemMetadata(playerId, item, slot, metadata)
    if config.Debug then
        DebugPrint("SetItemMetadata function called with PlayerID: " .. playerId .. ", Item: " .. item, "debug")
    end
    if GRP_Inventory and GRP_Inventory.SetMetadata then
        return GRP_Inventory.SetMetadata(playerId, item, slot, metadata)
    end
    return false
end

function GRP.GetImagePath(item)
    if config.Debug then
        DebugPrint("GetImagePath function called with Item: " .. tostring(item), "debug")
    end
    if GRP_Inventory and GRP_Inventory.GetImagePath then
        return GRP_Inventory.GetImagePath(item)
    end
    return "https://raw.githubusercontent.com/GRP-Scripts/grp-assets/main/inventory-placeholder.png"
end

function GRP.OpenStash(playerId, stashType, stashId)
    if config.Debug then
        DebugPrint("OpenStash function called with PlayerID: " .. playerId .. ", Type: " .. tostring(stashType) .. ", ID: " .. tostring(stashId), "debug")
    end
    if GRP_Inventory and GRP_Inventory.OpenStash then
        return GRP_Inventory.OpenStash(playerId, stashType, stashId)
    end
    return false
end

function GRP.RegisterStash(stashId, label, slots, weight, owner, groups, coords)
    if config.Debug then
        DebugPrint("RegisterStash function called with ID: " .. tostring(stashId), "debug")
    end
    if GRP_Inventory and GRP_Inventory.RegisterStash then
        return GRP_Inventory.RegisterStash(stashId, label, slots, weight, owner, groups, coords)
    end
    return false
end

function GRP.AddStashItems(stashId, items)
    if config.Debug then
        DebugPrint("AddStashItems function called with StashID: " .. tostring(stashId), "debug")
    end
    if GRP_Inventory and GRP_Inventory.AddStashItems then
        return GRP_Inventory.AddStashItems(stashId, items)
    end
    return false
end

function GRP.RemoveStashItems(stashId, items)
    if config.Debug then
        DebugPrint("RemoveStashItems function called with StashID: " .. tostring(stashId), "debug")
    end
    if GRP_Inventory and GRP_Inventory.RemoveStashItems then
        return GRP_Inventory.RemoveStashItems(stashId, items)
    end
    return false
end

function GRP.ClearStash(stashId, stashType)
    if config.Debug then
        DebugPrint("ClearStash function called with StashID: " .. tostring(stashId), "debug")
    end
    if GRP_Inventory and GRP_Inventory.ClearStash then
        return GRP_Inventory.ClearStash(stashId, stashType)
    end
    return false
end

function GRP.AddTrunkItems(vehiclePlate, items)
    if config.Debug then
        DebugPrint("AddTrunkItems function called with Plate: " .. tostring(vehiclePlate), "debug")
    end
    if GRP_Inventory and GRP_Inventory.AddTrunkItems then
        return GRP_Inventory.AddTrunkItems(vehiclePlate, items)
    end
    return false
end

function GRP.OpenShop(playerId, shopId)
    if config.Debug then
        DebugPrint("OpenShop function called with PlayerID: " .. playerId .. ", ShopID: " .. tostring(shopId), "debug")
    end
    if GRP_Inventory and GRP_Inventory.OpenShop then
        return GRP_Inventory.OpenShop(playerId, shopId)
    end
    return false
end

function GRP.RegisterShop(shopId, inventory, coords, groups)
    if config.Debug then
        DebugPrint("RegisterShop function called with ShopID: " .. tostring(shopId), "debug")
    end
    if GRP_Inventory and GRP_Inventory.RegisterShop then
        return GRP_Inventory.RegisterShop(shopId, inventory, coords, groups)
    end
    return false
end

function GRP.UpdateVehiclePlate(oldPlate, newPlate)
    if config.Debug then
        DebugPrint("UpdateVehiclePlate function called with Old: " .. tostring(oldPlate) .. ", New: " .. tostring(newPlate), "debug")
    end
    if GRP_Inventory and GRP_Inventory.UpdatePlate then
        return GRP_Inventory.UpdatePlate(oldPlate, newPlate)
    end
    return false
end

function GRP.OpenPlayerInventory(src, targetSrc)
    if config.Debug then
        DebugPrint("OpenPlayerInventory function called with Src: " .. src .. ", Target: " .. targetSrc, "debug")
    end
    if GRP_Inventory and GRP_Inventory.OpenPlayerInventory then
        return GRP_Inventory.OpenPlayerInventory(src, targetSrc)
    end
    return false
end

-- Update existing inventory functions to use GRP_Inventory instead of API
function GRP.AddItem(playerId, item_name, amount, slot, metadata)
    if config.Debug then
        DebugPrint("AddItem function called with PlayerID: " .. playerId .. ", Item: " .. item_name .. ", Amount: " .. amount, "debug")
    end
    amount = tonumber(amount) or 0
    if amount <= 0 then return false end
    if GRP_Inventory and GRP_Inventory.AddItem then
        return GRP_Inventory.AddItem(playerId, item_name, amount, slot, metadata)
    end
    return false
end

function GRP.RemoveItem(playerId, item_name, amount, slot, metadata)
    if config.Debug then
        DebugPrint("RemoveItem function called with PlayerID: " .. playerId .. ", Item: " .. item_name .. ", Amount: " .. amount, "debug")
    end
    amount = tonumber(amount) or 0
    if amount <= 0 then return false end
    if GRP_Inventory and GRP_Inventory.RemoveItem then
        return GRP_Inventory.RemoveItem(playerId, item_name, amount, slot, metadata)
    end
    return false
end

function GRP.GetItem(playerId, item_name)
    if config.Debug then
        DebugPrint("GetItem function called with PlayerID: " .. playerId .. ", Item: " .. item_name, "debug")
    end
    if GRP_Inventory and GRP_Inventory.GetPlayerInventory then
        local inventory = GRP_Inventory.GetPlayerInventory(playerId)
        if inventory then
            for _, item in pairs(inventory) do
                if item.name == item_name then
                    return item
                end
            end
        end
    end
    return {}
end

function GRP.CanCarryItem(playerId, item_name, amount)
    if config.Debug then
        DebugPrint("CanCarryItem function called with PlayerID: " .. playerId .. ", Item: " .. item_name .. ", Amount: " .. amount, "debug")
    end
    if GRP_Inventory and GRP_Inventory.CanCarryItem then
        return GRP_Inventory.CanCarryItem(playerId, item_name, amount)
    end
    return true
end

exports("GetPlayer", function(id)
    return GRP.GetPlayer(id)
end)

exports("GetAllPlayers", function()
    return GRP.GetAllPlayers()
end)

exports("GetPlayerJob", function(id)
    return GRP.GetPlayerJob(id)
end)

exports("GetPlayerJobGrade", function(id)
    return GRP.GetPlayerJobGrade(id)
end)

exports("GetPlayerJobInfo", function(id)
    return GRP.GetPlayerJobInfo(id)
end)

exports("HasPermission", function(playerId)
    return GRP.HasPermission(playerId)
end)

exports("AddMoney", function(playerId, amount)
    return GRP.AddMoney(playerId, amount)
end)

exports("RemoveMoney", function(playerId, amount)
    return GRP.RemoveMoney(playerId, amount)
end)

exports("RemoveBankMoney", function(playerId, amount)
    return GRP.RemoveBankMoney(playerId, amount)
end)

exports("GetMoney", function(playerId)
    return GRP.GetMoney(playerId)
end)

exports("GetBankMoney", function(playerId)
    return GRP.GetBankMoney(playerId)
end)

exports("TransferMoney", function(from, to, amount)
    return GRP.TransferMoney(from, to, amount)
end)

exports("AddItem", function(playerId, item_name, amount)
    return GRP.AddItem(playerId, item_name, amount)
end)

exports("RemoveItem", function(playerId, item_name, amount)
    return GRP.RemoveItem(playerId, item_name, amount)
end)

exports("GetItem", function(playerId, item_name)
    return GRP.GetItem(playerId, item_name)
end)

exports("CanCarryItem", function(playerId, item_name, amount)
    return GRP.CanCarryItem(playerId, item_name, amount)
end)

exports("SetJob", function(playerId, job_name, job_grade)
    return GRP.SetJob(playerId, job_name, job_grade)
end)

exports("GetIdentifier", function(playerId)
    return GRP.GetIdentifier(playerId)
end)

exports("GetPlayerByCitizenId", function(cid)
    return GRP.GetPlayerByCitizenId(cid)
end)

exports("GetPlayerName", function(playerId)
    return GRP.GetPlayerName(playerId)
end)

exports("GetPlayerCoords", function(playerId)
    return GRP.GetPlayerCoords(playerId)
end)

exports("GetPlayerMetadata", function(playerId, metadata)
    return GRP.GetPlayerMetadata(playerId, metadata)
end)

exports("SetPlayerMetadata", function(playerId, metadata, value)
    return GRP.SetPlayerMetadata(playerId, metadata, value)
end)

exports("GetPlayerDuty", function(playerId)
    return GRP.GetPlayerDuty(playerId)
end)

exports("GetIsPlayerDead", function(playerId)
    return GRP.GetIsPlayerDead(playerId)
end)

exports("RevivePlayer", function(playerId)
    return GRP.RevivePlayer(playerId)
end)

exports("RegisterUsableItem", function(itemName, cb)
    return GRP.RegisterUsableItem(itemName, cb)
end)

exports("AddAccountMoney", function(accountName, amount, reason)
    return GRP.AddAccountMoney(accountName, amount, reason)
end)

exports("RemoveAccountMoney", function(accountName, amount, reason)
    return GRP.RemoveAccountMoney(accountName, amount, reason)
end)

exports("GetAccountMoney", function(accountName)
    return GRP.GetAccountMoney(accountName)
end)

--- Inventory Exports
exports("GetInventoryResourceName", function()
    return GRP.GetInventoryResourceName()
end)

exports("GetItemInfo", function(item)
    return GRP.GetItemInfo(item)
end)

exports("GetAllItems", function()
    return GRP.GetAllItems()
end)

exports("GetItemCount", function(playerId, item, metadata)
    return GRP.GetItemCount(playerId, item, metadata)
end)

exports("GetPlayerInventory", function(playerId)
    return GRP.GetPlayerInventory(playerId)
end)

exports("GetItemBySlot", function(playerId, slot)
    return GRP.GetItemBySlot(playerId, slot)
end)

exports("SetItemMetadata", function(playerId, item, slot, metadata)
    return GRP.SetItemMetadata(playerId, item, slot, metadata)
end)

exports("GetImagePath", function(item)
    return GRP.GetImagePath(item)
end)

exports("OpenStash", function(playerId, stashType, stashId)
    return GRP.OpenStash(playerId, stashType, stashId)
end)

exports("RegisterStash", function(stashId, label, slots, weight, owner, groups, coords)
    return GRP.RegisterStash(stashId, label, slots, weight, owner, groups, coords)
end)

exports("AddStashItems", function(stashId, items)
    return GRP.AddStashItems(stashId, items)
end)

exports("RemoveStashItems", function(stashId, items)
    return GRP.RemoveStashItems(stashId, items)
end)

exports("ClearStash", function(stashId, stashType)
    return GRP.ClearStash(stashId, stashType)
end)

exports("AddTrunkItems", function(vehiclePlate, items)
    return GRP.AddTrunkItems(vehiclePlate, items)
end)

exports("OpenShop", function(playerId, shopId)
    return GRP.OpenShop(playerId, shopId)
end)

exports("RegisterShop", function(shopId, inventory, coords, groups)
    return GRP.RegisterShop(shopId, inventory, coords, groups)
end)

exports("UpdateVehiclePlate", function(oldPlate, newPlate)
    return GRP.UpdateVehiclePlate(oldPlate, newPlate)
end)

exports("OpenPlayerInventory", function(src, targetSrc)
    return GRP.OpenPlayerInventory(src, targetSrc)
end)

exports("GetGRP", function()
    return GRP
end)

local function GetVersionFromFile(body, scriptName)
    local found, version = false, "0.0.0"

    for line in body:gmatch("[^\r\n]+") do
        if line:match("%["..scriptName.."%]") then
            found = true
        elseif found then
            version = line
            break
        end
    end

    return version
end

local function CheckResourceVersion()
    if IsDuplicityVersion() then 
        CreateThread(function()
            Wait(4000)

            local resourceName = GetCurrentResourceName()
            local currentVersion = GetResourceMetadata(resourceName, "version") or "0.0.0"

            PerformHttpRequest("https://raw.githubusercontent.com/svgAPOLLO/version-checker/main/version.txt", function(err, body)
                if not body then
                    print(("^1[VersionCheck]^7 Unable to check version for ^3%s^7 (local %s)"):format(resourceName, currentVersion))
                    return
                end

                local newestVersion = GetVersionFromFile(body, resourceName)
                if newestVersion == "0.0.0" then
                    print(("^3[VersionCheck]^7 No version info found for ^3%s^7 (local %s)"):format(resourceName, currentVersion))
                    return
                end

                if currentVersion == newestVersion then
                    print(("^2[VersionCheck]^7 %s is up to date (^3%s^7)"):format(resourceName, currentVersion))
                else
                    print(("^1[VersionCheck]^7 %s is outdated! (^3%s → %s^7)"):format(resourceName, currentVersion, newestVersion))
                    print(("^1[VersionCheck]^7 Check your Keymaster and download the latest file!"):format())
                end
            end)
        end)
    end
end

CheckResourceVersion()