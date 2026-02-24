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

local function doCarryPed(ped)
    if not ped then return end
    loadAnim('nm')
    loadAnim('missfinale_c2mcs_1')
    local player = GetPlayerPed(PlayerId())
    if IsEntityAttachedToEntity(ped, player) then
        DetachEntity(ped, true, true)
        ClearPedTasks(ped)
        ClearPedTasks(player)
    else
        TaskPlayAnim(ped, 'nm', 'firemans_carry', 8.0, -1, -1, 1, 1, false, false, false)
        AttachEntityToEntity(ped, player, GetPedBoneIndex(player, 40269),
            -0.1, 0.0, 0.1, 25.0, -290.0, -150.0, true, true, false, true, 0, true)
        TaskPlayAnim(player, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 1.0, -1, -1, 50, 0, false,
            false, false)
    end
end

local function doCancelCarryPed(ped)
    if not ped then return end
    local player = GetPlayerPed(PlayerId())
    if IsEntityAttachedToEntity(ped, player) then
        DetachEntity(ped, true, true)
        ClearPedTasks(ped)
        ClearPedTasks(player)
    end
end

local function carryPed()
    doCarryPed(getClosestPed())
end
exports('CarryPed', carryPed)

local function carryPedEntity(entity)
    doCarryPed(entity)
end
exports('CarryPedEntity', carryPedEntity)

local function cancelCarryPed()
    doCancelCarryPed(getClosestPed())
end
exports('CancelCarryPed', cancelCarryPed)

RegisterCommand('carryped', function()
    carryPed()
end, false)

RegisterKeyMapping('cancelcarryped', 'Cancel Carry Ped', 'KEYBOARD', 'X')
RegisterCommand('cancelcarryped', function()
    cancelCarryPed()
end, false)
