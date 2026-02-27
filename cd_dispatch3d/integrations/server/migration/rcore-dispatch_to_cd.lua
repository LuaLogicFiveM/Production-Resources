local function ConvertDispatchData(source, data)
    local blip = data.blip or {}
    return {
        job_table = data.job or {},
        coords = data.coords or GetEntityCoords(GetPlayerPed(source)),
        title = data.code or 'DISPATCH',
        message = data.text or 'No message provided',
        flash = data.default_priority and 'high' or false,
        sound = 1,
        blip = {
            sprite = blip.sprite or 1,
            scale = blip.scale+0.0 or 1.0,
            colour = blip.colour or 1,
            flashes = blip.flashes or false,
            text = blip.text or 'DISPATCH',
            time = blip.blip_time and (blip.blip_time / 1000) / 60 or 5,
            radius = blip.radius or 0,
        }
    }
end

RegisterServerEvent('rcore_dispatch:server:sendAlert', function(data)
    local source = source
    local convertedData = ConvertDispatchData(source, data)
    TriggerEvent('cd_dispatch:AddNotification', convertedData)
end)