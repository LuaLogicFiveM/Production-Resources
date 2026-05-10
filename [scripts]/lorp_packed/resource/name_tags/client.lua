local enabled = true
local function initIds()
    CreateThread(function()
        while enabled do
            for i = 0, 255 do
                if NetworkIsPlayerActive(i) then
                    local iPed = GetPlayerPed(i)
                    if DoesEntityExist(iPed) then
                        local distance = math.ceil(GetDistanceBetweenCoords(GetEntityCoords(cache.ped), GetEntityCoords(iPed)))
                        local headDisplayId = CreateFakeMpGamerTag(iPed, "", false, false, "", 0)
                        local visable = false
                        local playerName
                        if cache.ped ~= iPed then
                            if HasEntityClearLosToEntity(cache.ped, iPed, 17) then
                                if distance <= 20 then
                                    playerName = GetPlayerServerId(i).." "
                                    visable = true
                                end
                            end

                            if NetworkIsPlayerTalking(i) then
                                SetMpGamerTagColour(headDisplayId, 0, 6)
                                SetMpGamerTagColour(headDisplayId, 8, 6)
                            else
                                SetMpGamerTagColour(headDisplayId, 0, 0)
                                SetMpGamerTagColour(headDisplayId, 8, 0)
                            end

                            SetMpGamerTagVisibility(headDisplayId, 0, visable)
                            SetMpGamerTagAlpha(headDisplayId, 4, 225)
                            SetMpGamerTagName(headDisplayId, playerName)
                        end
                    end
                end
            end
            Wait(1000)
        end
    end)
end

local function initStaffIds()
    CreateThread(function()
        while enabled do
            for i = 0, 255 do
                if NetworkIsPlayerActive(i) then
                    local iPed = GetPlayerPed(i)
                    if DoesEntityExist(iPed) then
                        local distance = math.ceil(GetDistanceBetweenCoords(GetEntityCoords(cache.ped), GetEntityCoords(iPed)))
                        local headDisplayId = CreateFakeMpGamerTag(iPed, "", false, false, "", 0)
                        local visable = false
                        local playerName
                        if cache.ped ~= iPed then
                            if HasEntityClearLosToEntity(cache.ped, iPed, 17) then
                                if distance <= 100 then
                                    visable = true
                                    if IsPedInAnyVehicle(iPed, false) then
                                        playerName = '['..GetPlayerServerId(i)..'] - '..GetPlayerName(i)..' ('..(GetEntitySpeed(GetVehiclePedIsIn(iPed, false))*2.236936)..')'
                                    else
                                        playerName = '['..GetPlayerServerId(i)..'] - '..GetPlayerName(i)
                                    end
                                end
                            end

                            if NetworkIsPlayerTalking(i) then
                                SetMpGamerTagColour(headDisplayId, 0, 6)
                                SetMpGamerTagColour(headDisplayId, 8, 6)
                            else
                                SetMpGamerTagColour(headDisplayId, 0, 0)
                                SetMpGamerTagColour(headDisplayId, 8, 0)
                            end

                            SetMpGamerTagVisibility(headDisplayId, 0, visable)
                            SetMpGamerTagAlpha(headDisplayId, 4, 225)
                            SetMpGamerTagName(headDisplayId, playerName)
                        end
                    end
                end
            end
            Wait(1000)
        end
    end)
end

local function toggleIds()
    local hasPerms = lib.callback.await('lorp_packed:server:hasPerms', false)
    if hasPerms then
        initStaffIds()
    else
        initIds()
    end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer, isNew, skin)
    toggleIds()
end)

RegisterCommand('ids', function()
    enabled = not enabled
    if not enabled then return end
    toggleIds()
end, false)