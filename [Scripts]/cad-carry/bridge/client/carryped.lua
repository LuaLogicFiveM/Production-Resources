if not Config.EnableCarryPed then return end

local function getClosestPed()
    local coords = GetEntityCoords(PlayerPedId())
    local peds = GetGamePool('CPed')
    local closestPed, closestCoords
    local maxDistance = Config.CarryDistance

    for i = 1, #peds do
        local ped = peds[i]

        if not IsPedAPlayer(ped) then
            local pedCoords = GetEntityCoords(ped)
            local distance = #(coords - pedCoords)

            if distance < maxDistance then
                maxDistance = distance
                closestPed = ped
                closestCoords = pedCoords
            end
        end
    end

    return closestPed, closestCoords
end

local function loadAnim(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end
    end
end

RegisterCommand('carryped', function()
    loadAnim('nm')
    loadAnim('missfinale_c2mcs_1')
    local closestPed = getClosestPed()
    if not closestPed then return end
    if IsEntityAttachedToEntity(closestPed, GetPlayerPed(PlayerId())) then
        DetachEntity(closestPed, true, true)
        ClearPedTasks(closestPed)
        ClearPedTasks(GetPlayerPed(PlayerId()))
    else
        TaskPlayAnim(closestPed, 'nm', 'firemans_carry', 8.0, -1, -1, 1, 1, false, false, false)
        AttachEntityToEntity(closestPed, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 40269),
            -0.1, 0.0, 0.1, 25.0, -290.0, -150.0, true, true, false, true, 0, true)
        TaskPlayAnim(GetPlayerPed(PlayerId()), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 1.0, -1, -1, 50, 0, false,
            false, false)
    end
end, false)

RegisterKeyMapping('cancelcarryped', 'Cancel Carry Ped', 'KEYBOARD', 'X')
RegisterCommand('cancelcarryped', function()
    local pedCercano = getClosestPed()
    if not pedCercano then return end
    if IsEntityAttachedToEntity(pedCercano, GetPlayerPed(PlayerId())) then
        DetachEntity(pedCercano, true, true)
        ClearPedTasks(pedCercano)
        ClearPedTasks(GetPlayerPed(PlayerId()))
    end
end, false)
