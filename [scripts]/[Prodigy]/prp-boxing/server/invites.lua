local pendingInvites = {}

lib.callback.register("prp-boxing:invitePlayer", function(source, ringIndex, targetSource, rounds, roundTime, isSparing, restTime)
    if not Config.BoxingRings[ringIndex] then 
        return { success = false, error = locale("MATCH_ALREADY_IN_PROGRESS") }
    end
    if not DoesPlayerExist(targetSource) then return end
    if Config.BoxingRings[ringIndex].matchId or Config.BoxingRings[ringIndex].tutorialId then
        return { success = false, error = locale("MATCH_ALREADY_IN_PROGRESS") }
    end
    if GetPlayerBoxingMatch(source) or GetPlayerTutorialMatch(source) or GetPlayerBoxingMatch(targetSource) or GetPlayerTutorialMatch(targetSource) then
        return { success = false, error = locale("ALREADY_IN_MATCH") }
    end
    if pendingInvites[targetSource] and pendingInvites[targetSource][source] then
        return { success = false, error = locale("INVITE_ALREADY_SENT") }
    end
    pendingInvites[targetSource] = pendingInvites[targetSource] or {}
    pendingInvites[targetSource][source] = {
        ringIndex = ringIndex,
        rounds = rounds,
        roundTime = roundTime,
        isSparing = isSparing,
        restTime = restTime,
        time = GetGameTimer()
    }
    EnsurePendingInvitesThread()
    local stateId = bridge.fw.getIdentifier(source)
    local targetStateId = bridge.fw.getIdentifier(targetSource)
    bridge.fw.notify(source, "success", locale("INVITE_SENT", bridge.fw.getCharacterName(targetStateId)))
    bridge.fw.notify(targetSource, "inform", locale("INVITE_RECEIVED", bridge.fw.getCharacterName(stateId)))
    TriggerClientEvent("prp-boxing:receiveInvite", targetSource, source, ringIndex, bridge.fw.getCharacterName(stateId), rounds, roundTime)
    return { success = true }
end)

lib.callback.register("prp-boxing:acceptInvite", function(source, ringIndex, fromSource)
    if not Config.BoxingRings[ringIndex] then
        return { success = false, error = locale("MATCH_ALREADY_IN_PROGRESS") }
    end
    if not DoesPlayerExist(fromSource) then
        return { success = false, error = locale("PLAYER_NOT_FOUND") }
    end
    if Config.BoxingRings[ringIndex].matchId or Config.BoxingRings[ringIndex].tutorialId then
        return { success = false, error = locale("MATCH_ALREADY_IN_PROGRESS") }
    end
    if GetPlayerBoxingMatch(source) or GetPlayerTutorialMatch(source) or GetPlayerBoxingMatch(fromSource) or GetPlayerTutorialMatch(fromSource) then
        return { success = false, error = locale("ALREADY_IN_MATCH") }
    end
    if not pendingInvites[source] or not pendingInvites[source][fromSource] then
        return { success = false, error = locale("NO_INVITE_FOUND") }
    end
    local invite = pendingInvites[source][fromSource]
    if invite.ringIndex ~= ringIndex then
        return { success = false, error = locale("NO_INVITE_FOUND") }
    end
    local ringCoords = Config.BoxingRings[ringIndex].position.xyz
    if #(GetEntityCoords(GetPlayerPed(fromSource)) - ringCoords) > 20.0 or #(GetEntityCoords(GetPlayerPed(source)) - ringCoords) > 20.0 then
        return { success = false, error = locale("NO_INVITE_FOUND") }
    end
    TriggerClientEvent("prp-boxing:removeInvite", source, fromSource)
    local match = BoxingMatch:New(fromSource, source, invite.roundTime, invite.rounds, ringIndex, invite.isSparing)
    pendingInvites[source][fromSource] = nil
    if not next(pendingInvites[source]) then
        pendingInvites[source] = nil
    end
    Citizen.CreateThread(function()
        local firstPos, secondPos = match:GetCoordsFromRings()
        match:CreatePeds(firstPos, secondPos)
        Citizen.Wait(500)
        match:StartControl()
        match:StartMatch()
    end)
    return { success = true }
end)

lib.callback.register("prp-boxing:declineInvite", function(source, ringIndex, fromSource)
    if not DoesPlayerExist(fromSource) then
        return { success = false, error = locale("PLAYER_NOT_FOUND") }
    end
    if not pendingInvites[source] or not pendingInvites[source][fromSource] then
        return { success = false, error = locale("NO_INVITE_FOUND") }
    end
    local invite = pendingInvites[source][fromSource]
    if invite.ringIndex ~= ringIndex then
        return { success = false, error = locale("NO_INVITE_FOUND") }
    end
    pendingInvites[source][fromSource] = nil
    if not next(pendingInvites[source]) then
        pendingInvites[source] = nil
    end
    local stateId = bridge.fw.getIdentifier(source)
    bridge.fw.notify(fromSource, "error", locale("INVITE_DECLINED", bridge.fw.getCharacterName(stateId)))
    TriggerClientEvent("prp-boxing:removeInvite", source, fromSource)
    return { success = true }
end)

local pendingInvitesThreadRunning = false
function EnsurePendingInvitesThread()
    if pendingInvitesThreadRunning then return end
    pendingInvitesThreadRunning = true
    Citizen.CreateThread(function()
        while true do
            local now = GetGameTimer()
            local toRemove = {}
            for targetSource, invites in pairs(pendingInvites) do
                for fromSource, invite in pairs(invites) do
                    if now - invite.time > Config.InviteDuration then
                        toRemove[#toRemove+1] = { targetSource, fromSource }
                    end
                end
            end
            for _, v in ipairs(toRemove) do
                if pendingInvites[v[1]] then
                    pendingInvites[v[1]][v[2]] = nil
                    if not next(pendingInvites[v[1]]) then
                        pendingInvites[v[1]] = nil
                    end
                end
            end
            if not next(pendingInvites) then
                pendingInvitesThreadRunning = false
                return
            end
            Citizen.Wait(1000)
        end
    end)
end

lib.callback.register("prp-boxing:startTutorial", function(source, ringIndex)
    if not Config.BoxingRings[ringIndex] then
        return { success = false, error = locale("MATCH_ALREADY_IN_PROGRESS") }
    end
    if not DoesPlayerExist(source) then
        return { success = false, error = locale("PLAYER_NOT_FOUND") }
    end
    if Config.BoxingRings[ringIndex].matchId or Config.BoxingRings[ringIndex].tutorialId then
        return { success = false, error = locale("MATCH_ALREADY_IN_PROGRESS") }
    end
    if GetPlayerBoxingMatch(source) or GetPlayerTutorialMatch(source) then
        return { success = false, error = locale("ALREADY_IN_MATCH") }
    end
    local ringCoords = Config.BoxingRings[ringIndex].position.xyz
    if #(GetEntityCoords(GetPlayerPed(source)) - ringCoords) > 20.0 then
        return { success = false, error = locale("TOO_FAR_FROM_RING") }
    end
    local match = TutorialMatch:New(source, 1, ringIndex)
    Config.BoxingRings[ringIndex].tutorialId = match.id
    Citizen.CreateThread(function()
        local firstPos, secondPos = match:GetCoordsFromRings()
        match:CreatePeds(firstPos, secondPos)
        Citizen.Wait(500)
        match:StartControl()
        match:StartMatch()
    end)
end)