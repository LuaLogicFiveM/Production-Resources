local function chatMessage(string)
    TriggerClientEvent('chat:addMessage', -1, { template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.6); border-left: 4px solid rgb(255, 200, 0); border-radius: 7px;"><img src="https://i.ibb.co/5x4dPVRN/Caution-Warning.png" height="18" width="18" style="position: absolute; border-radius: 50%; left: 20px;"></img><i class="fas fa-globe"></i> <text style="position: sticky; margin-left: 4.5%;">^3Entity Wipes: ^7'..tostring(string)..'</div>' })
end

RegisterCommand('wipemenu', function(source, args)
    TriggerClientEvent('lualogic_wipes:client:requestManager', source)
end, true)

CreateThread(function()
    GlobalState.VehiclesWiped = 0
    GlobalState.VehiclesWipedLast = os.time()
    GlobalState.ObjectsWiped = 0
    GlobalState.ObjectsWipedLast = os.time()
    GlobalState.PedsWiped = 0
    GlobalState.PedsWipedLast = os.time()
end)

RegisterCommand('wipes', function(source, args)    
    if not args[1] then
        return lib.notify(source, {title = 'Entity Wipes', description = 'Invalid Usage: /wipes [type] 1 = Cars, 2 = Objects, 3 = Peds', type = 'error'})
    else
        local num = tonumber(args[1])
        if num ~= 1 and num ~= 2 and num ~= 3 then 
            return lib.notify(source, {title = 'Entity Wipes', description = 'Invalid Usage: /wipes [type] 1 = Cars, 2 = Objects, 3 = Peds', type = 'error'})
        end
    end

    local type = tonumber(args[1])
    if type == 1 then
        chatMessage('All inactive vehicles will wipe in 20 seconds')
        Wait(10000)
        chatMessage('All inactive vehicles will wipe in 10 seconds')
        Wait(10000)
        chatMessage('All inactive vehicles have been wiped')

        local amount = 0
        for _, vehicle in pairs(GetAllVehicles()) do
            if GetPedInVehicleSeat(vehicle, -1) == 0 and not Entity(vehicle).state.saveEntity then
                DeleteEntity(vehicle)
                amount = amount+1
            end
        end

        GlobalState.VehiclesWiped = amount
        GlobalState.VehiclesWipedLast = (os.time() - GlobalState.VehiclesWipedLast) / 1000000

        local name = GetPlayerName(source)
        print('[ADMIN] - ' ..name.. ' triggered a vehicle wipe.')
        exports['lorp_packed']:SendLog('Vehicles Wipe', '**[User]: **'..name..'\n'..'**[ID]: **'..source..'\n'..'**[Vehicles Wiped]: **'..amount..'\n', 'https://ptb.discord.com/api/webhooks/1221182707287986266/j7ALuj-TXW0yH599Xg3qQALKT8fLyXfG2s8qHajgmJXs20YBtxQyF10VBsI_UIXFJSaa')
    elseif type == 2 then
        chatMessage('All objects will wipe in 20 seconds')
        Wait(10000)
        chatMessage('All objects will wipe in 10 seconds')
        Wait(10000)
        chatMessage('All objects have been wiped')

        local amount = 0
        for _, object in pairs(GetAllObjects()) do
            DeleteEntity(object)
            amount = amount+1
        end

        GlobalState.ObjectsWiped = amount
        GlobalState.ObjectsWipedLast = (os.time() - GlobalState.ObjectsWipedLast) / 1000000

        local name = GetPlayerName(source)
        print('[ADMIN] - ' ..name.. ' triggered an object wipe.')
        exports['lorp_packed']:SendLog('Objects Wipe', '**[User]: **'..name..'\n'..'**[ID]: **'..source..'\n'..'**[Object Wiped]: **'..amount..'\n', 'https://ptb.discord.com/api/webhooks/1221182707287986266/j7ALuj-TXW0yH599Xg3qQALKT8fLyXfG2s8qHajgmJXs20YBtxQyF10VBsI_UIXFJSaa')
    elseif type == 3 then
        local amount = 0
        for _, ped in pairs(GetAllPeds()) do
            DeleteEntity(ped)
            amount = amount+1
        end

        GlobalState.PedsWiped = amount
        GlobalState.PedsWipedLast = (os.time() - GlobalState.PedsWipedLast) / 1000000

        local name = GetPlayerName(source)
        print('[ADMIN] - ' ..name.. ' triggered a ped wipe.')
        exports['lorp_packed']:SendLog('Ped Wipe', '**[User]: **'..name..'\n'..'**[ID]: **'..source..'\n'..'**[Peds Wiped]: **'..amount..'\n', 'https://ptb.discord.com/api/webhooks/1221182707287986266/j7ALuj-TXW0yH599Xg3qQALKT8fLyXfG2s8qHajgmJXs20YBtxQyF10VBsI_UIXFJSaa')
    end
end, true)