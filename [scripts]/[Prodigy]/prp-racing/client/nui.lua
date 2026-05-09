ChatNotifications, RaceNotifications, EventNotifications, ComRaceNotifications, HideCheckpointFlares, Top5Mode = false,
    false, false, false, false, false
TabletOpen = false
local appDisabled = true
local loadedSettings = false

---@param tbl table
---@return table
function ReplaceVectorToObject(tbl)
    for k, v in pairs(tbl) do
        if type(v) == "vector3" then
            tbl[k] = { x = v.x, y = v.y, z = v.z }
        elseif type(v) == "vector4" then
            tbl[k] = { x = v.x, y = v.y, z = v.z, w = v.w }
        elseif type(v) == "table" then
            tbl[k] = ReplaceVectorToObject(v)
        end
    end
    return tbl
end

---@param visible boolean
function ShowTablet(visible)
    SendAppAction("root", "setVisible", visible)
    SendAppAction("racing", "setVisible", visible)
    SetNuiFocus(visible, visible)
    appDisabled = not visible
    TabletOpen = visible
    TriggerServerEvent("prp-racing:server:setTabletOpen", visible)
end

RegisterNuiCallback('getLocale', function(data, cb)
    cb({
        lang = lib.getLocaleKey()
    })
end)

RegisterNUICallback("root:close", function(_, cb)
    ShowTablet(false)
end)

---@param cb fun(resp: Race[])
RegisterNUICallback("racing:loadActiveRaces", function(_, cb)
    cb(lib.callback.await("prp-racing:race:getActiveRaces", false))
end)

---@param data NUIPostLoadRace
---@param cb fun(resp: Race)
RegisterNUICallback("racing:loadRace", function(data, cb)
    cb(lib.callback.await("prp-racing:race:getRace", false, data.id))
end)

---@param data NUIPostLoadTracks
---@param cb fun(resp: Track[])
RegisterNUICallback("racing:loadTracks", function(data, cb)
    cb(lib.callback.await("prp-racing:track:getTracks", false, data.offset, data.query, data.filter, data.sorting))
end)

---@param data NUIPostLoadSeason
---@param cb fun(resp: Season)
RegisterNUICallback("racing:loadSeason", function(data, cb)
    cb(lib.callback.await("prp-racing:season:getSeason", false, data.seasonId))
end)

---@param data NUIPostLoadLeaderboardUsers
---@param cb fun(resp: NUICBLeaderboardUser[])
RegisterNUICallback("racing:loadLeaderboardUsers", function(data, cb)
    cb(lib.callback.await("prp-racing:season:loadLeaderboardUsers", false, data.season, nil, data.query, data.offset))
end)

---@param data NUIPostSearchProfiles
---@param cb fun(resp: User[])
RegisterNUICallback("racing:searchProfiles", function(data, cb)
    cb(lib.callback.await("prp-racing:user:searchProfiles", false, data.query))
end)

---@param data NUIPostLoadProfile
---@param cb fun(resp: NUICBLoadedProfile)
RegisterNUICallback("racing:loadProfile", function(data, cb)
    cb(lib.callback.await("prp-racing:user:getProfile", false, data.stateId))
end)

---@param data NUIPostLoadProfileData
---@param cb fun(resp: SeasonPlayerStats)
RegisterNUICallback("racing:loadProfileData", function(data, cb)
    cb(lib.callback.await("prp-racing:user:getProfileStats", false, data.stateId, data.seasonId))
end)

---@param data NUIPostGetReward
---@param cb fun(resp: NUICBRewardItem[])
RegisterNUICallback("racing:getRewardItems", function(data, cb)
    cb(lib.callback.await("prp-racing:getRewardItems", false, data.query))
end)

---@param data NUIPostGetReward
---@param cb fun(resp: NUICBRewardVehicle[])
RegisterNUICallback("racing:getRewardVehicles", function(data, cb)
    cb(lib.callback.await("prp-racing:getRewardVehicles", false, data.query))
end)

---@param data NUIPostCreateRace
---@param cb fun(resp: NUICBCreatedRace)
RegisterNUICallback("racing:createRace", function(data, cb)
    cb(lib.callback.await("prp-racing:race:create", false, data))
end)

---@param data NUIPostStartRace
---@param cb fun(resp: Response)
RegisterNUICallback("racing:startRace", function(data, cb)
    local result = lib.callback.await("prp-racing:race:start", false, data.raceId)
    if result.success then
        ShowTablet(false)
    end
    cb(result)
end)

---@param data NUIPostLeaveRace
---@param cb fun(resp: Response)
RegisterNUICallback("racing:leaveRace", function(data, cb)
    cb(lib.callback.await("prp-racing:race:leave", 500, data.raceId))
end)

---@param data NUIPostSetWaypoint
RegisterNUICallback("racing:startWaypoint", function(data, cb)
    local track = lib.callback.await("prp-racing:track:getTrack", false, data.trackId) ---@type NUICBGetTrack
    if data.reverseRoute then
        SetNewWaypoint(track.checkpoints[#track.checkpoints].coords.x, track.checkpoints[#track.checkpoints].coords.y)
    else
        SetNewWaypoint(track.checkpoints[1].coords.x, track.checkpoints[1].coords.y)
    end
    cb({})
end)

---@param data NUIPostJoinRace
---@param cb fun(resp: Response)
RegisterNUICallback("racing:joinRace", function(data, cb)
    local resp = lib.callback.await("prp-racing:race:join", false, data.raceId, data.plate)
    cb(resp)
end)

---@param data NUIPostFindPrivateRace
---@param cb fun(resp: NUICBFoundPrivateRace)
RegisterNUICallback("racing:findPrivateRace", function(data, cb)
    local resp = lib.callback.await("prp-racing:race:findPrivate", false, data.password)
    cb(resp)
end)

---@param data NUIPostLoadProfileInfo
RegisterNUICallback("racing:loadProfileVehicles", function(data, cb)
    local stateId, seasonId, offset = data.stateId, data.seasonId, data.offset
    cb({})
end)

---@param data NUIPostLoadProfileInfo
RegisterNUICallback("racing:loadProfileTracks", function(data, cb)
    local stateId, seasonId, offset = data.stateId, data.seasonId, data.offset
    cb({})
end)

---@param data NUIPostSendChatMsg
---@param cb fun(resp: Response)
RegisterNUICallback("racing:sendChatMessage", function(data, cb)
    cb(lib.callback.await("prp-racing:sendMessage", false, data.chatId, data.message))
end)

---@param data Track
---@param cb fun(resp: Response)
RegisterNUICallback("racing:saveTrack", function(data, cb)
    cb(lib.callback.await("prp-racing:saveTrack", false, data))
end)

---@param data NUIPostGetAvailableVehs
---@param cb fun(resp: OwnedVehicle[])
RegisterNUICallback("racing:getAvailableVehicles", function(data, cb)
    cb(lib.callback.await("prp-racing:vehicle:getAvailableVehicles", false, data.class))
end)

---@param data NUIPostSaveSettings
---@param cb fun(resp: Response)
RegisterNUICallback("racing:saveSettings", function(data, cb)
    local beforeSettingsRaw = GetResourceKvpString("racing_settings_ " .. bridge.fw.getIdentifier())
    local beforeSettings = beforeSettingsRaw and json.decode(beforeSettingsRaw) or {}

    local shouldSetNickname = beforeSettings.nickname and
        (data.nickname and data.nickname:len() > 0 and data.nickname:lower() ~= beforeSettings.nickname:lower())
        or data.nickname and data.nickname:len()
    local shouldSetIncognito = data.incognito ~= nil and data.incognito ~= beforeSettings.incognito

    local function resetSettings(resetNick, resetIncog)
        ChatNotifications = beforeSettings.chatNotifications
        RaceNotifications = beforeSettings.raceNotifications
        EventNotifications = beforeSettings.eventNotifications
        ComRaceNotifications = beforeSettings.comRaceNotifications
        HideCheckpointFlares = beforeSettings.hideCheckpointFlares
        Top5Mode = beforeSettings.top5Mode
        SetResourceKvp("racing_settings_ " .. bridge.fw.getIdentifier(), json.encode(beforeSettings))

        if resetNick and beforeSettings.nickname and beforeSettings.nickname:len() > 0 then
            local result = lib.callback.await("prp-racing:user:setNickname", false, beforeSettings.nickname)
            if not result?.success then
                return cb(result)
            end
        end

        if resetIncog and beforeSettings.incognito ~= nil then
            local incognitoResult = lib.callback.await("prp-racing:user:setIncognito", false, beforeSettings.incognito)
            if not incognitoResult?.success then
                return cb(incognitoResult)
            end
        end
    end

    if shouldSetNickname then
        local result = lib.callback.await("prp-racing:user:setNickname", false, data.nickname)
        if not result?.success then
            resetSettings(false, false)
            return cb(result)
        end
    end

    if shouldSetIncognito then
        local incognitoResult = lib.callback.await("prp-racing:user:setIncognito", false, data.incognito)
        if not incognitoResult?.success then
            resetSettings(shouldSetNickname, false)
            return cb(incognitoResult)
        end
    end

    if data.euTimezone ~= nil then
        local timezoneResult = lib.callback.await("prp-racing:user:setTimezone", false, data.euTimezone)
        if not timezoneResult?.success then
            resetSettings(shouldSetNickname, shouldSetIncognito)
            return cb(timezoneResult)
        end
    end

    SendAppAction("racing", "setTop5Mode", Top5Mode)

    ChatNotifications = data.chatNotifications
    RaceNotifications = data.raceNotifications
    EventNotifications = data.eventNotifications
    ComRaceNotifications = data.comRaceNotifications
    HideCheckpointFlares = data.hideCheckpointFlares
    Top5Mode = data.top5Mode
    SetResourceKvp("racing_settings_ " .. bridge.fw.getIdentifier(), json.encode(data))

    cb({ success = true })
end)

---@param data NUIPostSetFavourite
---@param cb fun(resp: Response)
RegisterNUICallback("racing:setFavourite", function(data, cb)
    local cbData = lib.callback.await("prp-racing:track:setFavourite", false, data.id, data.favourite)
    cb(cbData)
end)

---@param cb fun(resp: NUICBRedeemReward)
RegisterNUICallback("racing:redeemDaily", function(_, cb)
    cb(lib.callback.await("prp-racing:user:redeemDaily", 100))
end)

---@param data NUIPostKickPlayer
---@param cb fun(resp: Response)
RegisterNUICallback("racing:kick", function(data, cb)
    cb(lib.callback.await("prp-racing:race:kick", 500, data.raceId, data.stateId, data.isBanned))
end)

---@param data NUIPostAdminUpdateTrack
---@param cb fun(resp: NUICBAdminUpdateTrack)
RegisterNUICallback("racing:adminUpdateTrackKey", function(data, cb)
    cb(lib.callback.await("prp-racing:track:updateTrackKey", false, data.trackId, data.key, data.value))
end)

---@param data NUIPostDeleteTrack
---@param cb fun(resp: Response)
RegisterNUICallback("racing:adminDeleteTrack", function(data, cb)
    cb(lib.callback.await("prp-racing:track:deleteTrack", false, data.trackId))
end)

---@param data NUIPostDeleteTrack
---@param cb fun(resp: Response)
RegisterNUICallback("racing:deleteTrack", function(data, cb)
    cb(lib.callback.await("prp-racing:track:deleteTrack", false, data.trackId))
end)

---@param data NUIPostDeleteRace
---@param cb fun(resp: Response)
RegisterNUICallback("racing:deleteRace", function(data, cb)
    cb(lib.callback.await("prp-racing:race:delete", false, data.raceId))
end)

---@param cb fun(resp: CrewBattle[])
RegisterNUICallback("racing:loadActiveCrewBattles", function(_, cb)
    cb(lib.callback.await("prp-racing:loadActiveCrewBattles", false))
end)

---@param data NUIPostLoadCrewBattle
---@param cb fun(resp: CrewBattle)
RegisterNUICallback("racing:loadCrewBattle", function(data, cb)
    local result = lib.callback.await("prp-racing:loadCrewBattle", false, data.battleId)
    cb(result)
end)

---@param data NUIPostLoadCrew
---@param cb fun(resp: CrewSyncObj)
RegisterNUICallback("racing:loadCrew", function(data, cb)
    cb(lib.callback.await("prp-racing:crew:getCrew", false, data.crewId))
end)

---@param data NUIPostCrewBattleReady
---@param cb fun(resp: Response)
RegisterNUICallback("racing:toggleCrewBattleReady", function(data, cb)
    local result = lib.callback.await("prp-racing:toggleCrewBattleReady", false, data.battleId, data.plate)
    cb(result)
end)

---@param data NUIPostForfeitCrewBattle
---@param cb fun(resp: Response)
RegisterNUICallback("racing:forfeitCrewBattle", function(data, cb)
    cb(lib.callback.await("prp-racing:forfeitCrewBattle", false, data.battleId))
end)

---@param data NUIPostJoinCrewBattle
---@param cb fun(resp: NUICBJoinCrewBattle)
RegisterNUICallback("racing:joinCrewBattle", function(data, cb)
    cb(lib.callback.await("prp-racing:joinCrewBattle", false, data.battleId, data.members))
end)

---@param data NUIPostCreateBattle
---@param cb fun(resp: NUICBCreateBattle)
RegisterNUICallback("racing:createBattle", function(data, cb)
    local result = lib.callback.await("prp-racing:createCrewBattle", false, data.type, data.classes, data.bet,
        data.currency, data.selectedMembers)
    cb(result)
end)

---@param data NUIPostLoadCrewBattleHsty
---@param cb fun(resp: Response|CrewBattleHistory)
RegisterNUICallback("racing:loadCrewsBattleHistory", function(data, cb)
    cb(lib.callback.await("prp-racing:crew:getCrewsBattleHistory", false, data.offset))
end)

---@param cb fun(resp: NUICBLoadHome)
RegisterNUICallback("racing:loadHome", function(_, cb)
    local cbData = lib.callback.await("prp-racing:user:loadHome", false)
    SendAppAction("racing", "setTop5Mode", Top5Mode)
    SendAppAction("racing", "setSettings", {
        chatNotifications = ChatNotifications,
        raceNotifications = RaceNotifications,
        eventNotifications = EventNotifications,
        comRaceNotifications = ComRaceNotifications,
        hideCheckpointFlares = HideCheckpointFlares,
        top5Mode = Top5Mode,
        nickname = cbData.nickname,
        euTimezone = cbData.euTimezone,
        incognito = cbData.incognito
    })

    SendAppAction("racing", "setCanCreateTracks", cbData.canCreateTracks)

    cb(cbData)
end)

---@param data NUIPostLoadTrack
---@param cb fun(resp: table)
RegisterNUICallback("racing:loadCurrentTrack", function(data, cb)
    local resp = lib.callback.await("prp-racing:track:getTrack", false, data.id) ---@type NUICBGetTrack
    local trackObj = ReplaceVectorToObject(resp)
    cb(trackObj)
end)

---@param data NUIPostLoadTrackData
---@param cb fun(resp: SeasonTrackStats|Response)
RegisterNUICallback("racing:loadCurrentTrackData", function(data, cb)
    local resp = lib.callback.await("prp-racing:track:getTrackData", false, data.trackId, data.seasonId, data.raceType)
    cb(resp)
end)

---@param data NUIPostLoadCrew
---@param cb fun(resp: CrewSyncObj[])
RegisterNUICallback("racing:loadCrews", function(data, cb)
    cb(lib.callback.await("prp-racing:crew:getCrews", false, data.offset, data.query, data.seasonId, data.tournamentId))
end)

---@param data NUIPostCreateCrew
---@param cb fun(resp: NUICBCreateCrew)
RegisterNUICallback("racing:createCrew", function(data, cb)
    cb(lib.callback.await("prp-racing:crew:create", false, data.name, data.tag, data.color))
end)

---@param data NUIPostLeaveCrew
---@param cb fun(resp: Response)
RegisterNUICallback("racing:leaveCrew", function(data, cb)
    cb(lib.callback.await("prp-racing:crew:leave", false))
end)

---@param data NUIPostInviteMember
---@param cb fun(resp: Response)
RegisterNUICallback("racing:inviteMember", function(data, cb)
    cb(lib.callback.await("prp-racing:crew:invite", false, data.nickname, data.roleId))
end)

---@param data NUIPostKickCrewMember
---@param cb fun(resp: Response)
RegisterNUICallback("racing:kickFromCrew", function(data, cb)
    cb(lib.callback.await("prp-racing:crew:removePlayer", false, data.crewId, data.stateId))
end)

---@param data Track
RegisterNUICallback("racing:editor", function(data, cb)
    OpenEditor(data)
    cb({})
end)

---@param data NUIPostSubscribe
RegisterNUICallback("racing:subscribe", function(data, cb)
    -- TriggerServerEvent("prp-racing:subscribe", data.type, data.value, data?.data?.raceId or data?.data?.id)
    cb({})
end)

---@param data NUIPostCreateCrewRole
---@param cb fun(resp: Response)
RegisterNUICallback("racing:createRole", function(data, cb)
    cb(lib.callback.await("prp-racing:crew:createRole", false, data.crewId, data.name, data.permissions))
end)

---@param data NUIPostUpdateCrewRole
---@param cb fun(resp: Response)
RegisterNUICallback("racing:setRole", function(data, cb)
    cb(lib.callback.await("prp-racing:crew:setRole", false, data.crewId, data.roleId, data.name, data.permissions))
end)

---@param data NUIPostRemoveCrewRole
---@param cb fun(resp: Response)
RegisterNUICallback("racing:removeRole", function(data, cb)
    cb(lib.callback.await("prp-racing:crew:removeRole", false, data.crewId, data.roleId))
end)

---@param data NUIPostSetCrewMemberRole
---@param cb fun(resp: Response)
RegisterNUICallback("racing:setMemberRole", function(data, cb)
    cb(lib.callback.await("prp-racing:crew:setMemberRole", false, data.crewId, data.stateId, data.roleId))
end)

---@param data NUIPostClaimSeasonReward
---@param cb fun(resp: NUICBClaimSeasonReward)
RegisterNUICallback("racing:claimSeasonReward", function(data, cb)
    cb(lib.callback.await("prp-racing:season:claimReward", 500, data.id))
end)

AddEventHandler("prp-bridge:client:playerLoad", function()
    SendAppAction("root", "setPlayerData", {
        stateId = bridge.fw.getIdentifier(),
        name = bridge.fw.getCharacterName()
    })

    local cbData = lib.callback.await("prp-racing:user:loadHome", false) --
    if not cbData then return end
    SendAppAction("racing", "setTop5Mode", Top5Mode)
    SendAppAction("racing", "setSettings", {
        chatNotifications = ChatNotifications,
        raceNotifications = RaceNotifications,
        eventNotifications = EventNotifications,
        comRaceNotifications = ComRaceNotifications,
        hideCheckpointFlares = HideCheckpointFlares,
        top5Mode = Top5Mode,
        nickname = cbData.nickname,
        euTimezone = cbData.euTimezone,
        incognito = cbData.incognito
    })

    SendAppAction("racing", "setCanCreateTracks", cbData.canCreateTracks)
    loadedSettings = true
end)

AddEventHandler("prp-bridge:client:playerUnload", function()
    ShowTablet(false)
    loadedSettings = false
end)

AddEventHandler("prp-bridge:client:died", function()
    SendAppAction("root", "setDead", true)
    ShowTablet(false)
end)

AddEventHandler("prp-bridge:client:revived", function()
    SendAppAction("root", "setDead", false)
end)

---@param seasons Season[]
RegisterNetEvent("prp-racing:seasons:setSeasons", function(seasons, createCost)
    table.sort(seasons, function(a, b) return a.id > b.id end)
    SendAppAction("racing", "setAvailableSeasons", seasons)
    SendAppAction("racing", "setCrewCreateMoney", createCost)
    local settingString = GetResourceKvpString("racing_settings_ " .. bridge.fw.getIdentifier())
    if settingString then
        local settings = json.decode(settingString)
        ChatNotifications, RaceNotifications, EventNotifications, ComRaceNotifications, HideCheckpointFlares, Top5Mode =
            settings.chatNotifications, settings.raceNotifications, settings.eventNotifications,
            settings.comRaceNotifications, settings.hideCheckpointFlares, settings.top5Mode

        SendAppAction("racing", "setTop5Mode", Top5Mode)
        SendAppAction("racing", "setSettings", settings)
    end
end)

---@param chatId string
---@param message string
---@param raceName string
RegisterNetEvent("prp-racing:addChatMessage", function(chatId, message, raceName)
    SendAppAction("racing", "addRacingChatMessage", { chatId = chatId, message = message })
end)

---@param charId string
---@param message ChatMessage
---@param raceName string
RegisterNetEvent("prp-racing:race:newChatMessage", function(charId, message, raceName)
    if ChatNotifications and not TabletOpen then
        TriggerEvent("prp-bridge:phone:sendNotification", locale("NEW_MESSAGE_ON", raceName or locale("UNKNOWN")),
            ("%s: %s"):format(message.nickname, message.message))
    end
end)

---@param charId string
---@param message ChatMessage
---@param raceName string
RegisterNetEvent("prp-racing:crew:newChatMessage", function(charId, message, raceName)
    if ChatNotifications and not TabletOpen then
        TriggerEvent("prp-bridge:phone:sendNotification", locale("NEW_MESSAGE_ON", raceName or locale("UNKNOWN")),
            ("%s: %s"):format(message.nickname, message.message))
    end
end)

---@param raceName string
---@param maxLaps number
---@param trackName string
---@param isPrivate boolean
---@param hasPassword boolean
RegisterNetEvent("prp-racing:newRaceCreated", function(raceName, maxLaps, trackName, isPrivate, hasPassword)
    local rankedNotif = not isPrivate and RaceNotifications
    local communityNotif = isPrivate and ComRaceNotifications
    local sendNotif = not hasPassword and (rankedNotif or communityNotif)
    if not sendNotif then
        return
    end

    if not TabletOpen and not appDisabled then
        TriggerEvent("prp-bridge:phone:sendNotification", locale("NEW_RACE", raceName),
            locale("NEW_RACE_INFO", trackName, maxLaps))
    end
end)

---@param crewObj CrewSyncObj
RegisterNetEvent("prp-racing:setUserCrew", function(crewObj)
    SendAppAction("racing", "setUserCrew", crewObj)
end)

---@param currentRace Race
RegisterNetEvent("prp-racing:setCurrentRace", function(currentRace)
    SendAppAction("racing", "setCurrentRace", currentRace)
end)

---@param activeRaces Race[]
RegisterNetEvent("prp-racing:setActiveRaces", function(activeRaces)
    SendAppAction("racing", "setActiveRaces", activeRaces)
    SendAppAction("racing", "setHomeActiveRaces", activeRaces)
end)

---@param isAdmin boolean
---@param currencies RacingCurrency[]
---@param rankedAllowlist boolean
RegisterNetEvent("prp-racing:client:openTablet", function(isAdmin, currencies, rankedAllowlist)
    if Config.RequireItemToOpen and not bridge.inv.hasItem(Config.RacingItem, 1) then
        return
    end

    -- load player data every time if developing
    if Config.Debug or not loadedSettings then
        TriggerEvent("prp-bridge:client:playerLoad")
    end

    SendAppAction("racing", "setAdminMode", isAdmin)
    SendAppAction("racing", "setAvailableCurrencies", currencies)
    SendAppAction("racing", "setRankedAllowlist", rankedAllowlist)
    ShowTablet(true)
end)

---@param activeBattles CrewBattle[]
RegisterNetEvent("prp-racing:activeCrewBattles", function(activeBattles)
    SendAppAction("racing", "setActiveCrewBattles", activeBattles)
end)

---@param crewBattle CrewBattle
RegisterNetEvent("prp-racing:crewBattle", function(crewBattle)
    SendAppAction("racing", "setCurrentCrewBattle", crewBattle)
end)

---@param crewName string
---@return boolean
lib.callback.register("prp-racing:crew:inviteRequest", function(crewName)
    local result = bridge.fw.confirmDialog(locale("CREW_INVITE", crewName), locale("CREW_INVITE_INFO", crewName), {
        confirm = locale("ACCEPT"),
        cancel  = locale("DECLINE")
    })
    return result == 'confirm'
end)

lib.callback.register("prp-racing:client:getUserSettings", function()
    return {
        chatNotifications = ChatNotifications,
        raceNotifications = RaceNotifications,
        eventNotifications = EventNotifications,
        comRaceNotifications = ComRaceNotifications,
        hideCheckpointFlares = HideCheckpointFlares,
        top5Mode = Top5Mode
    }
end)
