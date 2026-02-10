if Config.dispatchScript == "cd_dispatch" then

    function sendDispatchAlert(title, message, blipData)
        local currentPos = GetEntityCoords(PlayerPedId())
        local locationInfo = getStreetandZone(currentPos)
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police', 'sahp', 'sheriff'}, 
            coords = currentPos,
            title = title,
            message = message, 
            location = {
                label = locationInfo,
                coords = vector2(currentPos.x, currentPos.y)
            },
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = blipData.sprite, 
                scale = 1.2, 
                colour = blipData.color,
                flashes = false, 
                text = title,
                time = 5,
                radius = 0,
            }
        })
    end
end