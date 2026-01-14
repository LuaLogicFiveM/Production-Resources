local isBusy = false
local lastPressTime = 0
local singleClickScheduled = false
local Config = lib.require('resource.quick_ping.shared')

RegisterCommand('+quick_ping', function()
    if isBusy then return end

    local currentTime = GetGameTimer() / 1000

    if (currentTime - lastPressTime) <= Config.DoubleClickTreshold then
        singleClickScheduled = false

        HandlePing(Config.Icons.normal)
    else
        singleClickScheduled = true

        SetTimeout(Config.DoubleClickTreshold * 1000, function()
            if singleClickScheduled then
                HandlePing(Config.Icons.warning)
            end
        end)
    end

    lastPressTime = currentTime
end, false)

RegisterCommand('-quick_ping', function() end, false)
RegisterKeyMapping('+quick_ping', Config.Strings.place_desc, Config.Activation.mapping, Config.Activation.key)

HandlePing = function(icon)
    local _, entity, endCoords = lib.raycast.fromCamera(511, 4, 10000)
    local netId

    if endCoords.x == 0.0 or endCoords.y == 0.0 or endCoords.z  == 0.0 then return end

    if DoesEntityExist(entity) and GetEntityType(entity) == 1 or GetEntityType(entity) == 2 then
        netId = NetworkGetNetworkIdFromEntity(entity)
    end

    isBusy = true

    TriggerServerEvent('lorp_packed:client:receivePing', endCoords, netId, icon)
end

RegisterNetEvent('lorp_packed:client:receivePing', function(data)
    PlaceTemporaryMarker(data.coords, data.duration, data.pid, data.name, data.blipColor, data.entity, data.icon)
end)

local function DrawText3D(coords, text, r, g, b, scale)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    SetTextFont(0)
    SetTextScale(0, scale or 0.2)
    SetTextColour(r, g, b, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    DrawText(0, 0)
    ClearDrawOrigin()
end

local function CreateBlip(coords, sprite, color, scale, text)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)

    return blip
end

PlaceTemporaryMarker = function(coords, duration, pid, name, blipColor, netId, icon)
    CreateThread(function()
        local endTime = GetGameTimer() + duration
        local blip = CreateBlip(coords, 12, blipColor, 1.0, Config.Strings.display_text:format(pid, name))
        local distance, entity
        local id = pid

        if netId then
            entity = NetworkGetEntityFromNetworkId(netId)
        end

        while GetGameTimer() < endTime do
            if DoesEntityExist(entity) then
                coords = GetEntityCoords(entity)
            end

            distance = #(GetEntityCoords(cache.ped) - coords)

            DrawText3D(vec3(coords.x, coords.y, coords.z+8.0), Config.Strings.display_text:format(id, name), 255, 255, 255, 0.2)
            DrawText3D(vec3(coords.x, coords.y, coords.z+5.0), Config.Strings.display_text_meter:format(math.round(distance, 0)), 255, 255, 255, 0.15)
            DrawText3D(vec3(coords.x, coords.y, coords.z+0.5), icon, 255, 255, 255, 0.3)

            Wait(0)
        end

        RemoveBlip(blip)
        isBusy = false
    end)
end