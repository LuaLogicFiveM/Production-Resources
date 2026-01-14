local function ConvertDispatchData(source, data)
    local blip = data.blip or {}
    return {
        job_table = data.job or {},
        coords = data.callLocation or GetEntityCoords(GetPlayerPed(source)),
        title = data.callCode or 'DISPATCH',
        message = data.message or 'No message provided',
        flash = false,
        sound = 1,
        blip = {
            sprite = blip.sprite or 1,
            scale = blip.scale+0.0 or 1.0,
            colour = blip.colour or 1,
            flashes = blip.flashes or false,
            text = blip.text or 'DISPATCH',
            time = blip.time and (blip.time / 1000) / 60 or 5,
            radius = false,
        }
    }
end

RegisterServerEvent('qs-dispatch:server:CreateDispatchCall', function(data)
    local source = source
    local convertedData = ConvertDispatchData(source, data)
    TriggerEvent('cd_dispatch:AddNotification', convertedData)
end)