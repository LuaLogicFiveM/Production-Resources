NUI_status = false

function EnableNuiFocus()
    SetNuiFocus(true, true)
    NUI_status = true
end

function DisableNuiFocus()
    SetNuiFocus(false, false)
    NUI_status = false
end

function PlayAnimation(animDict, animName, duration)
    local ped = PlayerPedId()
    if not DoesEntityExist(ped) then return end

    duration = duration or -1

    RequestAnimDict(animDict)
    local timeout = GetGameTimer() + 5000
    while not HasAnimDictLoaded(animDict) and GetGameTimer() < timeout do
        Wait(0)
    end

    if not HasAnimDictLoaded(animDict) then
        ERROR('2358', '[PlayAnimation] Timed out waiting for anim dict '..animDict..' to load')
        return
    end

    TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, duration, 49, 0.0, false, false, false)

    if duration and duration > 0 then
        CreateThread(function()
            Wait(duration + 100)
            RemoveAnimDict(animDict)
        end)
    end
end

function GetClosestPlayer(maxDistance, returnData)
    local myPed = PlayerPedId()
    local myCoords = GetEntityCoords(myPed)

    local closestPlayer
    local closestDistSq = maxDistance * maxDistance

    returnData = returnData or 'ped'

    for _, playerId in ipairs(GetActivePlayers()) do
        if playerId ~= PlayerId() then
            local ped = GetPlayerPed(playerId)

            if ped ~= 0 then
                local distSq = #(myCoords - GetEntityCoords(ped))^2

                if distSq < closestDistSq then
                    closestDistSq = distSq
                    if returnData == 'serverid' then
                        closestPlayer = GetPlayerServerId(playerId)
                    elseif returnData == 'ped' then
                        closestPlayer = ped
                    end
                end
            end
        end
    end

    return closestPlayer
end

function GetClosestPlayers(maxDistance, returnData)
    local players = {}
    local myPed = PlayerPedId()
    local myCoords = GetEntityCoords(myPed)
    local maxDistSq = maxDistance * maxDistance

    returnData = returnData or 'ped'

    for _, playerId in pairs(GetActivePlayers()) do
        if playerId ~= PlayerId() then
            local ped = GetPlayerPed(playerId)

            if ped ~= 0 then
                local coords = GetEntityCoords(ped)
                local distSq = #(myCoords - coords)^2

                if distSq <= maxDistSq then
                    if returnData == 'serverid' then
                        players[#players + 1] = GetPlayerServerId(playerId)
                    elseif returnData == 'ped' then
                        players[#players + 1] = ped
                    end
                end
            end
        end
    end

    return players
end

local specialKeyCodes = { ['b_100']='LMB',['b_101']='RMB',['b_102']='MMB',['b_103']='Mouse.ExtraBtn1',['b_104']='Mouse.ExtraBtn2',['b_105']='Mouse.ExtraBtn3',['b_106']='Mouse.ExtraBtn4',['b_107']='Mouse.ExtraBtn5',['b_108']='Mouse.ExtraBtn6',['b_109']='Mouse.ExtraBtn7',['b_110']='Mouse.ExtraBtn8',['b_115']='MouseWheel.Up',['b_116']='MouseWheel.Down',['b_130']='NumSubstract',['b_131']='NumAdd',['b_134']='Num Multiplication',['b_135']='Num Enter',['b_137']='Num1',['b_138']='Num2',['b_139']='Num3',['b_140']='Num4',['b_141']='Num5',['b_142']='Num6',['b_143']='Num7',['b_144']='Num8',['b_145']='Num9',['b_170']='F1',['b_171']='F2',['b_172']='F3',['b_173']='F4',['b_174']='F5',['b_175']='F6',['b_176']='F7',['b_177']='F8',['b_178']='F9',['b_179']='F10',['b_180']='F11',['b_181']='F12',['b_182']='F13',['b_183']='F14',['b_184']='F15',['b_185']='F16',['b_186']='F17',['b_187']='F18',['b_188']='F19',['b_189']='F20',['b_190']='F21',['b_191']='F22',['b_192']='F23',['b_193']='F24',['b_194']='Arrow Up',['b_195']='Arrow Down',['b_196']='Arrow Left',['b_197']='Arrow Right',['b_198']='Delete',['b_199']='Escape',['b_200']='Insert',['b_201']='End',['b_210']='Delete',['b_211']='Insert',['b_212']='End',['b_1000']='Shift',['b_1002']='Tab',['b_1003']='Enter',['b_1004']='Backspace',['b_1009']='PageUp',['b_1008']='Home',['b_1010']='PageDown',['b_1012']='CapsLock',['b_1013']='Control',['b_1014']='Right Control',['b_1015']='Alt',['b_1055']='Home',['b_1056']='PageUp',['b_2000']='Space' }
function GetKeyMappingKeyLabel(command)
    local hashKey = GetHashKey(command)
    local key = GetControlInstructionalButton(0, hashKey | 0x80000000, true)
    if string.find(key, "t_") then
        local label, _count = string.gsub(key, "t_", "")
        return label
    else
        return specialKeyCodes[key] or nil
    end
end