RegisterServerEvent('esx_ambulancejob:onPlayerDistress', function()
    local src = source
    TriggerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'ambulance' },
        coords = GetEntityCoords(GetPlayerPed(src)),
        title = 'Medical - Emergency',
        message = 'Medical emergency reported. Immediate assistance required.',
        flash = false,
        sound = 1,
        blip = { sprite=153, scale=1.1, colour=2, flashes=false, text='911 - Medical', time=6, radius=0 }
    })
end)