local function ConvertDispatchData(source, data)
    local blip = data.alert or {}
    return {
        job_table = data.jobs or {},
        coords = data.coords or GetEntityCoords(GetPlayerPed(source)),
        title = data.code or 'DISPATCH',
        message = ('%s at %s'):format(data.message or 'No message provided', data.street or 'Unknown location'),
        flash = data.priority and 1 or 0,
        sound = 1,
        blip = {
            sprite = blip.sprite or 1,
            scale = blip.scale+0.0 or 1.0,
            colour = blip.colour or 1,
            flashes = blip.flash or false,
            text = data.code or 'DISPATCH',
            time = 5,
            radius = blip.radius,
        }
    }
end


RegisterServerEvent('ps-dispatch:server:notify', function(data)
    local source = source
    local convertedData = ConvertDispatchData(source, data)
    TriggerEvent('cd_dispatch:AddNotification', convertedData)
end)