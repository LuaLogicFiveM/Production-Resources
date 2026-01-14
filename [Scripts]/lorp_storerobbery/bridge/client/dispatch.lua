function RobberyAlert(coords)
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.DispatchJobs, 
        coords = coords,
        title = '10-39 - Store Robbery',
        message = "Robbery reported at general store.",
        flash = 1,
        unique_id = 'storerobbery',
        sound = 1,
        blip = {
            sprite = 52,
            scale = 1.2,
            colour = 1,
            flashes = true,
            time = 5
        }
    })
end

function NetworkAlert(coords)
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = Config.DispatchJobs, 
        coords = coords,
        title = '10-39 - Network Access',
        message = "Unauthorized network access at general store.",
        flash = 0,
        unique_id = 'storenetwork',
        sound = 1,
        blip = {
            sprite = 629, 
            scale = 1.2, 
            colour = 1,
            flashes = true, 
            time = 5
        }
    })
end