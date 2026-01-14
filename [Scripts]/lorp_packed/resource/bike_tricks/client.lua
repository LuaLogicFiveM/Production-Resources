RegisterCommand("nosemanualhop", function()
    if IsPedOnAnyBike(cache.ped) then
        local pitch = GetEntityPitch(cache.vehicle)

        if pitch < -5.0 then
            ApplyForceToEntity(cache.vehicle, 1, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
            local startHeading = GetEntityHeading(cache.vehicle)
            for i = 1, 36 do
                Wait(10)
                SetEntityHeading(cache.vehicle, startHeading + (i * 10))
            end
            Wait(500)
        else
            lib.notify({title = 'Bike Tricks', description = 'You must be in a nose manual to do this', type = 'error', position = 'top'})
        end
    else
        lib.notify({title = 'Bike Tricks', description = 'You must be on a bike to do this trick', type = 'error', position = 'top'})
    end
end, false)

--RegisterKeyMapping("nosemanualhop", "Perform a Hop from Nose Manual", "keyboard", "LMENU")