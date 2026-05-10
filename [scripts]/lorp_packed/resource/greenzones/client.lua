local zones = {
    {
        name = "trust_513",
        thickness = 70.0,
        points = {
            vec3(578.4590, 600.5972, 131.5801),
            vec3(733.4153, 541.7224, 130.3930),
            vec3(779.5368, 647.4601, 136.8673),
            vec3(613.8294, 701.9733, 132.4956)
        }
    },
    {
        name = "hospital_259",
        thickness = 70.0,
        points = {
            vec3(1034.4197, 2696.7556, 39.3232),
            vec3(1123.3389, 2691.3491, 38.2134),
            vec3(1125.5835, 2744.9070, 38.4445),
            vec3(1036.2443, 2748.0952, 38.7886)
        }
    },
    {
        name = "hospital_749",
        thickness = 70.0,
        points = {
            vec3(266.9120, -610.2403, 42.7729),
            vec3(354.7124, -639.9185, 35.3704),
            vec3(413.8438, -539.3036, 32.6502),
            vec3(291.5511, -551.5823, 44.1980)
        }
    },
    {
        name = "hospital_021",
        thickness = 70.0,
        points = {
            vec3(1034.4197, 2696.7556, 39.3232),
            vec3(1123.3389, 2691.3491, 38.2134),
            vec3(1125.5835, 2744.9070, 38.4445),
            vec3(1036.2443, 2748.0952, 38.7886)
        }
    }
}

local maxSpeed = 200.0
local function inside()
    SetPlayerCanDoDriveBy(cache.playerId, false)
    DisablePlayerFiring(cache.playerId, true)
    DisableControlAction(0, 140, true)
end

local function onEnter()
    lib.showTextUI('Safe Zone', {
        position = "left-center",
        icon = 'hand',
        style = {
            borderRadius = 5,
            backgroundColor = '#48BB78',
            color = 'white'
        }
    })

    LocalPlayer.state.greenzone = true
    SetEntityAlpha(cache.ped, 150, false)
    SetLocalPlayerAsGhost(true)

    if cache.vehicle then
        maxSpeed = GetVehicleHandlingFloat(cache.vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
        SetVehicleMaxSpeed(cache.vehicle, 20.0)
    end
end

local function onExit()
    lib.hideTextUI()
    LocalPlayer.state.greenzone = nil

    SetEntityCanBeDamaged(cache.ped, true)
    DisablePlayerFiring(cache.playerId, false)
    SetPlayerCanDoDriveBy(cache.playerId, true)
    SetEntityAlpha(cache.ped, 255, false)
    SetLocalPlayerAsGhost(false)

    if cache.vehicle then
        SetVehicleMaxSpeed(cache.vehicle, maxSpeed)
    end
end

CreateThread(function()
    for _, zoneData in pairs(zones) do
        lib.zones.poly({
            name = zoneData.name,
            points = zoneData.points,
            thickness = zoneData.thickness,
            debug = false,
            inside = inside,
            onEnter = onEnter,
            onExit = onExit
        })
    end
end)