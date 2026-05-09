Citizen.CreateThread(function()
    for i=1, #Config.Job.Electrical.depots do
        local v = Config.Job.Electrical.depots[i]

        local blip = AddBlipForCoord(v.pedCoords)
        SetBlipSprite(blip, Config.BlipSettings.sprite)
        SetBlipColour(blip, Config.BlipSettings.color)
        SetBlipScale(blip, Config.BlipSettings.scale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Job.Electrical.name)
        EndTextCommandSetBlipName(blip)
    end
end)