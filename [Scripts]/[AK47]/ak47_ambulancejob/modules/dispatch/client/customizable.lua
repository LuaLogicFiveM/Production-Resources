--[[Citizen.CreateThread(function()
    if not Config.CustomDispatch then
        if GetResourceState('cd_dispatch') == 'started' or GetResourceState('cd_dispatch') == 'starting' then
            Config.CustomDispatch = 'cd_dispatch'
            return
        end
        if GetResourceState('qs-dispatch') == 'started' or GetResourceState('qs-dispatch') == 'starting' then
            Config.CustomDispatch = 'qs-dispatch'
            return
        end
        if GetResourceState('ps-dispatch') == 'started' or GetResourceState('ps-dispatch') == 'starting' then
            Config.CustomDispatch = 'ps-dispatch'
            return
        end
    end
end)]]

function CustomDispatch()
    local data = exports['cd_dispatch']:GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'ambulance', 'ems'},
        coords = data.coords,
        title = '10-15 - Injured Person',
        message = 'A '..data.sex..' needs medical assistance at '..data.street, 
        flash = 0,
        unique_id = data.unique_id,
        sound = 1,
        blip = {
            sprite = 431, 
            scale = 1.2, 
            colour = 3,
            flashes = false, 
            text = '911 - Injured Person',
            time = 5,
            radius = 0,
        }
    })
end