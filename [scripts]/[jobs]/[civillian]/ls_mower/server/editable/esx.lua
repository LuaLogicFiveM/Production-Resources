if Config.esxSettings.enabled then
    ESX = nil
    ESX = exports['es_extended']:getSharedObject()

    function RemovePlayerMoney(player, amount)
        local xPlayer = ESX.GetPlayerFromId(player)

        if xPlayer.getAccount(Config.esxSettings.account).money >= amount then
            xPlayer.removeAccountMoney(Config.esxSettings.account, amount)
            return true
        else
            return false
        end
    end

    function AddMoney(player, amount)
        local xPlayer = ESX.GetPlayerFromId(player)
        if not xPlayer then
            return false
        end
        xPlayer.addAccountMoney(Config.esxSettings.account, amount)
    end

    function CheckPlayerMoney(player, amount)
        local xPlayer = ESX.GetPlayerFromId(player)

        if Config.debugMode.debug then
            print(xPlayer.getAccount(Config.esxSettings.account).money, " Player's money ")
        end
        if xPlayer.getAccount(Config.esxSettings.account).money >= amount then
            return true
        else
            return false
        end
    end

    function GetPlayerOwnedMower(source)
        local _source    = source
        local xPlayer    = ESX.GetPlayerFromId(_source)

        local query      = "SELECT * from owned_vehicles where owner = @player and stored = @stored"
        local values     = {
            ["player"] = xPlayer.identifier,
            ["stored"] = 1,
            ["Impound"] = nil
        }

        local data       = sqlFetch(query, values)

        local mowerToUse = nil

        if #data > 0 then
            for _, v in ipairs(data) do
                local vehicle_data = json.decode(v.vehicle)
                if vehicle_data.model == 1783355638 then
                    mowerToUse = v
                    return mowerToUse
                end
                return nil
            end
        end
    end

    RegisterServerEvent('ls_mower:owned_vehicles')
    AddEventHandler('ls_mower:owned_vehicles', function(stored, parking, Impound, heading, spawn)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)

        -- Attempt to retrieve the mower based on its storage status
        local mowerToUse = GetPlayerOwnedMower(source)

        if stored then
            -- If the mower is being stored, use the heading's vehicle properties
            mowerToUse = { vehicle = heading.vehicleProps }
        elseif mowerToUse then
            -- If the mower is not stored, decode its vehicle data
            mowerToUse = { vehicle = json.decode(mowerToUse.vehicle) }
        end

        if mowerToUse then
            -- Prepare query and values for updating the database
            local query =
            'UPDATE owned_vehicles SET stored = @stored, parking = @parking, pound = @Impound, vehicle = @vehicle WHERE plate = @plate AND owner = @identifier'
            local values = {
                ["identifier"] = xPlayer.identifier,
                ["vehicle"]    = json.encode(mowerToUse.vehicle),
                ["plate"]      = mowerToUse.vehicle.plate,
                ["stored"]     = stored,
                ["parking"]    = parking,
                ["Impound"]    = Impound or nil
            }
            sqlInsert(query, values)

            if stored then
                xPlayer.showNotification("Vehicle stored successfully!")
            else
                -- Spawn the vehicle if it's not being stored
                ESX.OneSync.SpawnVehicle(mowerToUse.vehicle.model, spawn, heading, mowerToUse.vehicle,
                    function(vehicleId)
                        local vehicleEntity = NetworkGetEntityFromNetworkId(vehicleId)
                        Wait(300)
                        TriggerClientEvent('ls_mower:getOwnedMowerId', _source, vehicleId)
                    end)
            end
        else
            -- Notify the player if no matching vehicle is found
            xPlayer.showNotification("No matching vehicle found!")
        end
    end)

    function GiveItemOnFinishedJob(player)
        -- local items = { 'ls_emp_blocker', 'ls_entrance_key', 'ls_thermite', }
        -- local chance = math.random(1, 100)
        -- local item = items[math.random(1, #items)]
        -- local amount = math.random(1, 3)

        -- print(chance, "Chance to give item")
        -- if chance >= 1 then
        --     local xPlayer = ESX.GetPlayerFromId(tonumber(player))

        --     if Config.esxSettings.oldEsx then
        --         local esxItem = xPlayer.getInventoryItem(item)

        --         if esxItem.limit == -1 or (esxItem.count + amount) <= esxItem.limit then
        --             xPlayer.addInventoryItem(item, amount or 1)
        --             return true
        --         else
        --             return false
        --         end
        --     else
        --         if xPlayer.canCarryItem(item, amount or 1) then
        --             xPlayer.addInventoryItem(item, amount or 1)
        --             return true
        --         else
        --             return false
        --         end
        --     end
        -- end
    end
end
