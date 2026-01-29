RegisterNetEvent("doors_creator:alertedPolice", function(coords, message)
    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', },
        coords = coords,
        title = '10-15 - Door',
        message = message,
        flash = 0,
        sound = 1,
        blip = {
            sprite = 431,
            scale = 1.2,
            colour = 3,
            flashes = false,
            text = '911 - Door',
            time = 5,
            radius = 0,
        }
    })
end)

AddEventHandler("drugs_creator:alertedPolice", function(coords, message)
    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', },
        coords = coords,
        title = '10-15 - Drugs',
        message = message,
        flash = 0,
        sound = 1,
        blip = {
            sprite = 431,
            scale = 1.2,
            colour = 3,
            flashes = false,
            text = '911 - Drugs',
            time = 5,
            radius = 0,
        }
    })
end)

RegisterNetEvent("missions_creator:alertedPolice", function(coords, message)
    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', },
        coords = coords,
        title = '10-15',
        message = message,
        flash = 0,
        sound = 1,
        blip = {
            sprite = 431,
            scale = 1.2,
            colour = 3,
            flashes = false,
            text = '911',
            time = 5,
            radius = 0,
        }
    })
end)

AddEventHandler("robberies_creator:alertedPolice", function(coords, message)
    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', },
        coords = coords,
        title = '10-15 - Robbery',
        message = message,
        flash = 0,
        sound = 1,
        blip = {
            sprite = 431,
            scale = 1.2,
            colour = 3,
            flashes = false,
            text = '911 - Robbery',
            time = 5,
            radius = 0,
        }
    })
end)

AddEventHandler("vehiclekeys:server:dispatch", function(data)
    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', },
        coords = data.coords,
        title = data.title,
        message = data.message,
        flash = 0,
        sound = 1,
        blip = {
            sprite = 431,
            scale = 1.2,
            colour = 3,
            flashes = false,
            text = data.title,
            time = 5,
            radius = 0,
        }
    })
end)

AddEventHandler("races_creator:server:dispatch", function(data)
    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', },
        coords = data.coords,
        title = data.title,
        message = data.message,
        flash = 0,
        sound = 1,
        blip = {
            sprite = 431,
            scale = 1.2,
            colour = 3,
            flashes = false,
            text = data.title,
            time = 5,
            radius = 0,
        }
    })
end)

AddEventHandler("farming_creator:server:dispatch", function(data)
    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', },
        coords = data.coords,
        title = data.title,
        message = data.message,
        flash = 0,
        sound = 1,
        blip = {
            sprite = 431,
            scale = 1.2,
            colour = 3,
            flashes = false,
            text = data.title,
            time = 5,
            radius = 0,
        }
    })
end)

AddEventHandler("vehicles_keys:server:dispatch", function(data)
    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', },
        coords = data.coords,
        title = data.title,
        message = data.message,
        flash = 0,
        sound = 1,
        blip = {
            sprite = 431,
            scale = 1.2,
            colour = 3,
            flashes = false,
            text = data.title,
            time = 5,
            radius = 0,
        }
    })
end)