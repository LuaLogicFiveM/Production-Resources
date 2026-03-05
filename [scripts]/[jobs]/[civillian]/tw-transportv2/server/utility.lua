CreateThread(function()
    if Config.Framework == 'vrp' then
        load(LoadResourceFile('vrp', 'lib/utils.lua'))()
        local Proxy = module('vrp', 'lib/Proxy')
        vRP = Proxy.getInterface('vRP')
    end
end)


_G.serverCallbacks = _G.serverCallbacks or {}

-- Standalone Player Storage (only used when Config.Framework == "standalone")
local StandalonePlayers = {}

-- Standalone Player Management
if Config.Framework == "standalone" then
    -- Use playerJoining instead of playerConnecting for better timing
    AddEventHandler('playerJoining', function(oldID)
        local src = source

        -- Wait a bit for player to fully connect
        CreateThread(function()
            Wait(500)

            local identifier = GetPlayerIdentifierByType(src, 'license')
            local playerName = GetPlayerName(src)

            if identifier and playerName then
                StandalonePlayers[src] = {
                    source = src,
                    identifier = identifier,
                    name = playerName,
                    money = {
                        cash = 5000, -- Starting cash
                        bank = 10000 -- Starting bank money
                    }
                    -- No inventory system in standalone mode
                }

                if Config.Debug then
                    print(string.format("^2[Standalone]^7 Player joined: %s (%s)", playerName, identifier))
                end
            end
        end)
    end)

    AddEventHandler('playerDropped', function(reason)
        local src = source
        StandalonePlayers[src] = nil

        if Config.Debug then
            print(string.format("^1[Standalone]^7 Player dropped: %s (reason: %s)", GetPlayerName(src) or "Unknown",
                reason))
        end
    end)
end

-- Helper function to wait for Core to be ready
local function WaitForCore(timeout)
    timeout = timeout or 100 -- Default 5 seconds (100 * 50ms)
    local attempts = 0

    while not Core and attempts < timeout do
        Wait(50)
        attempts = attempts + 1
    end

    if not Core then
        if Config.Debug then
            print(string.format("[^1ERROR^7][tw-transportv2] Core not loaded after %d seconds", (timeout * 50) / 1000))
            print(string.format("  - Config.Framework: ^5%s^7", Config.Framework or "nil"))
        end
        return false
    end

    return true
end


RegisterServerCallback = function(eventName, callback)
    CreateThread(function()
        if Config.Framework ~= 'vrp' and Config.Framework ~= 'standalone' then
            if not WaitForCore(100) then
                if Config.Debug then
                    print(string.format("[^1ERROR^7][tw-transportv2] Failed to register server callback: ^5%s^7",
                        eventName))
                end
                return
            end
        end


        _G.serverCallbacks[eventName] = callback
    end)
end

RegisterNetEvent(_event('triggerServerCallback'), function(eventName, requestId, invoker, ...)
    if not _G.serverCallbacks[eventName] then
        return print(("[^1ERROR^7] Server Callback not registered, name: ^5%s^7, invoker resource: ^5%s^7"):format(
            eventName, invoker))
    end

    local src = source
    _G.serverCallbacks[eventName](src, function(...)
        TriggerClientEvent(_event('serverCallback'), src, requestId, invoker, ...)
    end, ...)
end)

function RegisterCallback(name, cbFunc)
    while not Core do
        Wait(0)
    end
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Core.RegisterServerCallback(name, function(source, cb, data)
            cbFunc(source, cb, data)
        end)
    else
        Core.Functions.CreateCallback(name, function(source, cb, data)
            cbFunc(source, cb, data)
        end)
    end
end

function ExecuteSql(query, parameters)
    local IsBusy = true
    local result = nil
    if Config.SQL == "oxmysql" then
        if parameters then
            exports.oxmysql:execute(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif Config.SQL == "ghmattimysql" then
        if parameters then
            exports.ghmattimysql:execute(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            exports.ghmattimysql:execute(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif Config.SQL == "mysql-async" then
        if parameters then
            MySQL.Async.fetchAll(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            MySQL.Async.fetchAll(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

function WaitCore()
    while Core == nil do
        Wait(0)
    end
end

function GetPlayer(source)
    local Player = false

    -- Standalone framework bypass (always return a valid player object)
    if Config.Framework == 'standalone' then
        -- Check if player exists in table
        if StandalonePlayers[source] then
            return StandalonePlayers[source]
        end

        -- Create on-the-fly if not exists (for late joins or timing issues)
        local identifier = GetPlayerIdentifierByType(source, 'license')
        local playerName = GetPlayerName(source)

        if identifier and playerName then
            StandalonePlayers[source] = {
                source = source,
                identifier = identifier,
                name = playerName,
                money = {
                    cash = 5000,
                    bank = 10000
                }
            }

            if Config.Debug then
                print(string.format("^3[Standalone]^7 Created player on-demand: %s (%s)", playerName, identifier))
            end

            return StandalonePlayers[source]
        end

        -- If still can't get player, return nil
        return nil
    end

    while Core == nil do
        Citizen.Wait(0)
    end
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Player = Core.GetPlayerFromId(source)
    elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        Player = Core.Functions.GetPlayer(source)
    elseif Config.Framework == 'vrp' then
        Player = vRP.getUserId(source)
    end
    return Player
end

function GetIdentifier(source)
    -- Standalone framework (get identifier directly from native)
    if Config.Framework == 'standalone' then
        local identifier = GetPlayerIdentifierByType(source, 'license')
        if not identifier then
            -- Fallback to player table
            local player = StandalonePlayers[source]
            return player and player.identifier or nil
        end
        return identifier
    end

    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            return Player.getIdentifier()
        elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            return Player.PlayerData.citizenid
        elseif Config.Framework == 'vrp' then
            return vRP.getUserId(source)
        end
    end
end

function ChecklistItem(item)
    for _, v in pairs(Config.InventoryAccess.allowedItems) do
        if item == v then
            return true
        end
    end
    return false
end

function GetPlayerInventory(source)
    local data = {}

    -- Standalone framework (no inventory script - return empty)
    if Config.Framework == 'standalone' then
        -- No inventory system in standalone mode
        -- Return empty table to prevent UI errors
        return {}
    end

    local Player = GetPlayer(source)
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        for _, v in pairs(Player.getInventory()) do
            if v then
                v.count = v.count or v.amount
                if v and tonumber(v.count) > 0 and ChecklistItem(v.name) then
                    local formattedData = v
                    formattedData.name = string.lower(v.name)
                    formattedData.label = v.label
                    formattedData.amount = v.count
                    formattedData.image = v.image or (string.lower(v.name) .. '.png')
                    local metadata = v.metadata or v.info
                    if not metadata or next(metadata) == nil then
                        metadata = false
                    end
                    formattedData.metadata = metadata
                    table.insert(data, formattedData)
                end
            end
        end
    elseif Config.Framework == "qb" or Config.Framework == "oldqb" then
        for _, v in pairs(Player.PlayerData.items) do
            if v then
                local amount = v.count or v.amount
                if tonumber(amount) > 0 and ChecklistItem(v.name) then
                    local formattedData = v
                    formattedData.name = string.lower(v.name)
                    formattedData.label = v.label
                    formattedData.amount = amount
                    formattedData.image = v.image or (string.lower(v.name) .. '.png')
                    local metadata = v.metadata or v.info
                    if not metadata or next(metadata) == nil then
                        metadata = false
                    end
                    formattedData.metadata = metadata
                    table.insert(data, formattedData)
                end
            end
        end
    elseif Config.Framework == "vrp" then
        for _, v in pairs(vRP.Inventory(Player)) do
            if v then
                local amount = v.count or v.amount
                if tonumber(amount) > 0 and ChecklistItem(v.name) then
                    local formattedData = v
                    formattedData.name = string.lower(v.name)
                    formattedData.label = v.label
                    formattedData.amount = amount
                    formattedData.image = v.image or (string.lower(v.name) .. '.png')
                    local metadata = v.metadata or v.info
                    if not metadata or next(metadata) == nil then
                        metadata = false
                    end
                    formattedData.metadata = metadata
                    table.insert(data, formattedData)
                end
            end
        end
    end
    return data
end

function GetName(source)
    -- Standalone framework (get name directly from native)
    if Config.Framework == 'standalone' then
        local playerName = GetPlayerName(source)
        if playerName then
            return playerName
        end
        -- Fallback to player table
        local player = StandalonePlayers[source]
        return player and player.name or "Unknown"
    end

    if Config.Framework == "oldesx" or Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(tonumber(source))
        if xPlayer then
            return xPlayer.getName()
        else
            return "0"
        end
    elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        local Player = GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        else
            return "0"
        end
    elseif Config.Framework == 'vrp' then
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        if identity then
            return identity.name .. " " .. identity.name2
        end
        return "Firstname Lastname"
    end
end

function AddMoney(source, type, value)
    -- Standalone framework
    if Config.Framework == 'standalone' then
        local player = StandalonePlayers[source]
        if player and player.money[type] then
            player.money[type] = player.money[type] + tonumber(value)
        end
        return
    end

    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            if type == 'bank' then
                Player.addAccountMoney('bank', tonumber(value))
            end
            if type == 'cash' then
                Player.addMoney(value)
            end
        elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            if type == 'bank' then
                Player.Functions.AddMoney('bank', value)
            end
            if type == 'cash' then
                Player.Functions.AddMoney('cash', value)
            end
        elseif Config.Framework == 'vrp' then
            if type == 'bank' then
                local user_id = vRP.getUserId(source)
                vRP.giveBankMoney(user_id, value)
            end
            if type == 'cash' then
                local user_id = vRP.getUserId(source)
                vRP.giveMoney(user_id, value)
            end
        end
    end
end

function RemoveMoney(source, type, value)
    -- Standalone framework
    if Config.Framework == 'standalone' then
        local player = StandalonePlayers[source]
        if player and player.money[type] then
            player.money[type] = math.max(0, player.money[type] - tonumber(value))
        end
        return
    end

    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            if type == 'bank' then
                Player.removeAccountMoney('bank', value)
            end
            if type == 'cash' then
                Player.removeMoney(value)
            end
        elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            if type == 'bank' then
                Player.Functions.RemoveMoney('bank', value)
            end
            if type == 'cash' then
                Player.Functions.RemoveMoney('cash', value)
            end
        elseif Config.Framework == 'vrp' then
            if type == 'bank' then
                vRP.tryWithdraw(source, value)
            end
            if type == 'cash' then
                vRP.tryPayment(source, value)
            end
        end
    end
end

function AddXP(source, xp)
    if not xp or xp <= 0 then return end

    local identifier = GetIdentifier(source)
    local data = playerJobData[identifier]
    if not data then return end

    local profiledata = data.profiledata
    profiledata.xp = profiledata.xp + tonumber(xp)

    if profiledata.level > #Config.RequiredXP then
        TriggerClientEvent(_event('client:sendNotification'), source, Config.NotificationText['maxlevel'].text,
            Config.NotificationText['maxlevel'].type)
        return
    end

    if profiledata.xp >= Config.RequiredXP[profiledata.level] then
        profiledata.level = profiledata.level + 1
        profiledata.xp = 0
    end

    profiledata.lasttime = os.date('%Y-%m-%d %H:%M:%S')
end

function addItem(src, item, amount, slot, info)
    local amount = tonumber(amount) or 1

    -- Standalone framework (no inventory script - bypass item operations)
    if Config.Framework == 'standalone' then
        -- No inventory system in standalone mode
        -- Items are handled through mission completion rewards (money only)
        return true
    end

    local Player = GetPlayer(src)
    if Player then
        if Config.Framework == 'vrp' then
            local user_id = vRP.getUserId(src)
            vRP.giveInventoryItem(user_id, item, amount)
        end
        if Config.Inventory == "qb_inventory" then
            Player.Functions.AddItem(item, amount, slot, info)
        elseif Config.Inventory == "esx_inventory" then
            Player.addInventoryItem(item, amount)
        elseif Config.Inventory == "ox_inventory" then
            exports.ox_inventory:AddItem(src, item, amount)
        elseif Config.Inventory == "codem-inventory" then
            exports["codem-inventory"]:AddItem(src, item, amount, slot, info)
        elseif Config.Inventory == "qs_inventory" then
            exports['qs-inventory']:AddItem(src, item, amount)
        elseif Config.Inventory == "tgiann-inventory" then
            exports["tgiann-inventory"]:AddItem(src, item, amount, slot, info, false)
        end
    end
end

function GetPlayerMoney(source, value)
    -- Standalone framework
    if Config.Framework == 'standalone' then
        local player = StandalonePlayers[source]
        if player and player.money[value] then
            return player.money[value]
        end
        return 0
    end

    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            if value == 'bank' then
                return Player.getAccount('bank').money
            end
            if value == 'cash' then
                return Player.getMoney()
            end
        elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            if value == 'bank' then
                return Player.PlayerData.money['bank']
            end
            if value == 'cash' then
                return Player.PlayerData.money['cash']
            end
        elseif Config.Framework == 'vrp' then
            if value == 'bank' then
                return vRP.getBankMoney(source)
            end
            if value == 'cash' then
                return vRP.getMoney(source)
            end
        end
    end
end

function calculateDistance(coord1, coord2)
    local dx = coord1.x - coord2.x
    local dy = coord1.y - coord2.y
    local dz = coord1.z - coord2.z
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

function HasItem(source, item)
    -- Standalone framework (no inventory script - always return true to bypass checks)
    if Config.Framework == 'standalone' then
        -- No inventory system in standalone mode
        -- Return true to allow gameplay without item checks
        return true
    end

    local Player = GetPlayer(source)
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        if Config.Inventory == 'codem-inventory' then
            local item = exports["codem-inventory"]:CheckItemValid(source, item.name, tonumber(item.amount))
            return item
        elseif Config.Inventory == 'qs_inventory' then
            local itemCount = exports['qs-inventory']:GetItemTotalAmount(source, item.name)
            if itemCount == 0 or itemCount == nil then
                return false
            end
            return true
        elseif Config.Inventory == 'ox_inventory' then
            local item = exports.ox_inventory:GetItemCount(source, item.name)
            if item then
                return true
            else
                return false
            end
        elseif Config.Inventory == 'tgiann-inventory' then
            local src = source
            local has1 = exports["tgiann-inventory"]:HasItem(src, item.name, tonumber(item.amount or 1))
            if has1 then
                return true
            else
                return false
            end
        else
            local playerItem = Player.getInventoryItem(item.name)
            if not playerItem then
                return false
            end
            local amount = playerItem.count or playerItem.amount
            if tonumber(amount) >= tonumber(item.amount) then
                return true
            end
        end
    elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        if Config.Inventory == 'codem-inventory' then
            local item = exports["codem-inventory"]:CheckItemValid(source, item.name, tonumber(item.amount))
            return item
        elseif Config.Inventory == 'qs_inventory' then
            local itemCount = exports['qs-inventory']:GetItemTotalAmount(source, item.name)
            if itemCount == 0 or itemCount == nil then
                return false
            end
            return true
        elseif Config.Inventory == 'ox_inventory' then
            local item = exports.ox_inventory:GetItemCount(source, item.name)
            if item and item >= 1 then
                return true
            else
                return false
            end
        elseif Config.Inventory == 'tgiann-inventory' then
            local src = source
            local has1 = exports["tgiann-inventory"]:HasItem(src, item.name, tonumber(item.amount or 1))
            if has1 then
                return true
            else
                return false
            end
        else
            return Core.Functions.HasItem(source, item.name, tonumber(item.amount))
        end
    elseif Config.Framework == 'vrp' then
        local user_id = vRP.getUserId(source)
        local item = vRP.getInventoryItemAmount(user_id, item.name)
        if item and item >= tonumber(item.amount) then
            return true
        end
    end
    return false
end

function removeItem(src, item, amount)
    amount = tonumber(amount) or 1

    -- Standalone framework (no inventory script - bypass item removal)
    if Config.Framework == 'standalone' then
        -- No inventory system in standalone mode
        -- Return true to allow gameplay without item removal
        return true
    end

    local Player = GetPlayer(src)
    if Player then
        if Config.Framework == 'vrp' then
            local user_id = vRP.getUserId(src)
            vRP.tryGetInventoryItem(user_id, item, amount)
        end
        if Config.Inventory == "qb_inventory" then
            Player.Functions.RemoveItem(item, amount)
        elseif Config.Inventory == "esx_inventory" then
            Player.removeInventoryItem(item, amount)
        elseif Config.Inventory == "ox_inventory" then
            exports.ox_inventory:RemoveItem(src, item, amount)
        elseif Config.Inventory == "codem-inventory" then
            exports["codem-inventory"]:RemoveItem(src, item, amount)
        elseif Config.Inventory == "qs_inventory" then
            exports['qs-inventory']:RemoveItem(src, item, amount)
        elseif Config.Inventory == "tgiann-inventory" then
            local itemData = exports["tgiann-inventory"]:GetItemByName(src, item)
            if itemData.amount > 0 then
                local success = exports["tgiann-inventory"]:RemoveItem(src, item, 1, itemData.key)
            end
        end
    end
end

--- Yields the current thread until a non-nil value is returned by the function.
---@generic T
---@param cb fun(): T?
---@param errMessage string?
---@param timeout? number | false Error out after `~x` ms. Defaults to 1000, unless set to `false`.
---@return T
---@async
function waitFor(cb, errMessage, timeout)
    local value = cb()
    if value ~= nil then return value end

    if timeout or timeout == nil then
        if type(timeout) ~= 'number' then timeout = 1000 end
    end

    local startTime = timeout and os.time()
    local elapsed = 0

    while value == nil do
        Citizen.Wait(100)

        if timeout then
            elapsed = os.time() - startTime
            if elapsed * 1000 > timeout then
                return error(('%s (waited %.1fms)'):format(errMessage or 'failed to resolve callback', elapsed * 1000), 2)
            end
        end

        value = cb()
    end

    return value
end

-- =======================================
-- POLICE ALERT SYSTEM SERVER FUNCTIONS
-- =======================================

function getOnlinePoliceCount()
    local policeCount = 0
    local players = GetPlayers()

    for _, playerId in ipairs(players) do
        local Player = GetPlayer(tonumber(playerId))
        if Player then
            local jobName = nil

            if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
                jobName = Player.job.name
            elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
                jobName = Player.PlayerData.job.name
            elseif Config.Framework == 'vrp' then
                -- VRP için grup kontrolü yapılabilir
                -- Bu kısım VRP'ye göre özelleştirilebilir
                jobName = 'police' -- Placeholder
            end

            -- Polis işlerini kontrol et (genişletilebilir)
            local policeJobs = { 'bcso', 'sasp', 'gov' }

            for _, policeJob in ipairs(policeJobs) do
                if jobName == policeJob then
                    policeCount = policeCount + 1
                    break
                end
            end
        end
    end

    return policeCount
end

RegisterServerCallback(_event('server:getPoliceCount'), function(source, cb)
    local policeCount = getOnlinePoliceCount()
    if Config.Debug then
        print("Online polis sayısı:", policeCount)
    end
    cb(policeCount)
end)

-- =======================================
-- POLICE SEARCH SYSTEM SERVER FUNCTIONS
-- =======================================
function count_table(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

RegisterServerEvent(_event('server:policeImpoundVehicle'), function(ownerIdentifier, vehiclePlate, foundItem)
    local src = source

    local lobby = _G.coopData and _G.coopData[ownerIdentifier] or nil
    if not lobby then
        return
    end

    for _, player in ipairs(lobby.players) do
        local playerId = player.source
        if GetPlayerPed(playerId) then
            TriggerClientEvent(_event('client:sendNotification'), playerId,
                Config.PoliceAlert.policeSearch.searchResults.jobReset, "error")
            TriggerClientEvent(_event('client:resetjob'), playerId)
        end
    end

    if Config.Debug then
        print(Locales[Config.Locale]['policeIllegalOperationDetected'], ownerIdentifier)
    end

    lobby.roomSetting.startJob = false
    lobby.roomSetting.deliveryTruck = false

    if lobby.roomSetting.VehicleNetId then
        for _, netId in ipairs(lobby.roomSetting.VehicleNetId) do
            local vehicle = NetworkGetEntityFromNetworkId(netId)
            if DoesEntityExist(vehicle) then
                DeleteEntity(vehicle)
            end
        end
        lobby.roomSetting.VehicleNetId = {}
    end

    lobby.roomSetting.Mission = nil
    lobby.roomSetting.regionJobTask = {}

    TriggerClientEvent(_event('client:sendNotification'), src,
        string.format(Locales[Config.Locale]['policeOperationSuccess'], foundItem), "success")

    local policePlayer = GetPlayer(src)
    local policeName = GetName(src)

    if Config.Debug then
        print(string.format("[POLICE OPERATION] %s (%s) caught illegal transport - Plate: %s, Item: %s", policeName, src,
            vehiclePlate, foundItem))
    end
end)

RegisterServerEvent(_event('server:resetJobByPolice'), function(ownerIdentifier)
    local src = source

    local Player = GetPlayer(src)
    if not Player then return end

    local jobName = nil
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        jobName = Player.job.name
    elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        jobName = Player.PlayerData.job.name
    end

    local isPolice = false
    for _, policeJob in ipairs(Config.PoliceAlert.policeSearch.policeJobs) do
        if jobName == policeJob then
            isPolice = true
            break
        end
    end

    if not isPolice then
        if Config.Debug then
            print("Unauthorized reset attempt by:", src, jobName)
        end
        return
    end

    local lobby = _G.coopData and _G.coopData[ownerIdentifier] or nil
    if lobby then
        TriggerEvent(_event('server:policeImpoundVehicle'), ownerIdentifier, "Unknown",
            Locales[Config.Locale]['policeInvestigation'])
    end
end)
