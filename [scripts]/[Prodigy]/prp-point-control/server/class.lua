---@class PointControl : OxClass
---@field id string
---@field isActive boolean
PointControl = lib.class("PointControl")

---@class PointControlData
---@field label string
---@field taskId string
---@field partyId string
---@field members table<string, boolean>

---@param payload PointControlData
function PointControl:constructor(payload)
    self.partyId = payload.partyId
    self.members = payload.members
    self.id = payload.taskId
    self.taskId = payload.taskId

    self.teamOneId = lib.string.random("..........", 10)
    self.teamTwoId = lib.string.random("..........", 10)
    self.teamOnePlayers = {}
    self.teamTwoPlayers = {}
    self.faction = "Apex"
    self.enemyFaction = "Weave"

    self:splitPlayersIntoTeams()

    self.currentStage = nil


    local locationKeys = {}
    for k, _ in pairs(Config.Locations) do
        table.insert(locationKeys, k)
    end
    self.locationId = locationKeys[math.random(1, #locationKeys)]

    self.points = {}

    self:cooldown()
end

function PointControl:splitPlayersIntoTeams()
    local playerSources = {}
    for source, _ in pairs(self.members) do
        table.insert(playerSources, source)
    end

    for i = #playerSources, 2, -1 do
        local j = math.random(i)
        playerSources[i], playerSources[j] = playerSources[j], playerSources[i]
    end

    local halfSize = math.ceil(#playerSources / 2)

    for i = 1, halfSize do
        self.teamOnePlayers[playerSources[i]] = true
    end

    for i = halfSize + 1, #playerSources do
        self.teamTwoPlayers[playerSources[i]] = true
    end
end

function PointControl:event(eventName, ...)
    if self.teamOnePlayers then
        for src, _ in pairs(self.teamOnePlayers) do
            if src then
                TriggerClientEvent(eventName, src, ...)
            end
        end
    end

    if self.teamTwoPlayers then
        for src, _ in pairs(self.teamTwoPlayers) do
            if src then
                TriggerClientEvent(eventName, src, ...)
            end
        end
    end
end

function PointControl:teamOneEvent(eventName, ...)
    if self.teamOnePlayers then
        for src, _ in pairs(self.teamOnePlayers) do
            if src then
                TriggerClientEvent(eventName, src, ...)
            end
        end
    end
end

function PointControl:teamTwoEvent(eventName, ...)
    if self.teamTwoPlayers then
        for src, _ in pairs(self.teamTwoPlayers) do
            if src then
                TriggerClientEvent(eventName, src, ...)
            end
        end
    end
end

function PointControl:serverEvent(eventName, ...)
    TriggerEvent(eventName, ...)
end

function PointControl:syncMission()

end

function PointControl:cooldown()
    if self.teamOnePlayers then
        for src, _ in pairs(self.teamOnePlayers) do
            local identifier = bridge.fw.getIdentifier(src)

            exports['prp-bridge']:startCooldownByIdentifier(
                identifier,
                Config.Mission.name,
                Config.Mission.cooldown
            )
        end
    end

    if self.teamTwoPlayers then
        for src, _ in pairs(self.teamTwoPlayers) do
            local identifier = bridge.fw.getIdentifier(src)

            exports['prp-bridge']:startCooldownByIdentifier(
                identifier,
                Config.Mission.name,
                Config.Mission.cooldown
            )
        end
    end
end

function PointControl:getTeamOnePlayerIds()
    local playerIds = {}

    for src, _ in pairs(self.teamOnePlayers) do
        if src then
            playerIds[#playerIds + 1] = src
        end
    end

    return playerIds
end

function PointControl:getTeamTwoPlayerIds()
    local playerIds = {}

    for src, _ in pairs(self.teamTwoPlayers) do
        if src then
            playerIds[#playerIds + 1] = src
        end
    end

    return playerIds
end

function PointControl:createPointStashes()
    self.pointStashes = {}
    self.pointStashToIndex = {}

    local points = Config.Locations[self.locationId].points

    for index = 1, #points do
        local stashId = bridge.inv.createTemporaryStash({
            label = locale('CAPTURE_POINT') .. " " .. string.char(index + 64),
            slots = 1,
            maxWeight = 100,
        })

        self.pointStashes[index] = stashId
        self.pointStashToIndex[stashId] = index

        lib.print.debug("Created stash " .. stashId .. " for point " .. index)
    end
end

function PointControl:registerHook()
    local filterPatterns = {}

    for _, stashId in pairs(self.pointStashes) do
        filterPatterns[#filterPatterns + 1] = stashId:gsub("%-", "%%-")
    end

    lib.print.debug("Registering inventory hook for stashes:", self.filterPatterns)

    self.hookId = bridge.inv.registerSwapItemsHook(function(payload)
        SetTimeout(0, function()
            local pSource = tostring(payload.source)

            local inventoryId = tostring(payload.toInventory)
            local pointIndex = self.pointStashToIndex[inventoryId]

            if not pointIndex then
                inventoryId = tostring(payload.fromInventory)
                pointIndex = self.pointStashToIndex[inventoryId]
            end

            if not pointIndex then return end

            local items = bridge.inv.getInventoryItems(inventoryId)
            local teamId = nil

            if items then
                for _, item in pairs(items) do
                    lib.print.debug("Checking item in stash:", item)
                    if item.name == Config.Items.controlCrate then
                        local meta = item.metadata or item.metaData
                        teamId = meta and meta.teamId
                        break
                    end
                end
            end

            if teamId then
                lib.print.debug("Player " .. pSource .. " started contesting point " .. pointIndex .. " for team " .. teamId)   
                self:startContesting(teamId, pointIndex)
            else
                lib.print.debug("Player " .. pSource .. " stopped contesting point " .. pointIndex)
                self:stopContesting(pointIndex)
            end
        end)

        return true
    end, {
        inventoryFilter = filterPatterns
    })
end

function PointControl:start()
    lib.print.debug("Starting")

    bridge.log.send(MainConfig.LogWebhook, "Point Control Started", "A point control mission has started.", {
        mission_id = self.id,
        location_id = self.locationId,
        team_one = self:getTeamOnePlayerIds(),
        team_two = self:getTeamTwoPlayerIds(),
    })

    self.isActive = true

    self:createPointStashes()
    self:registerHook()

    self.startRaceAt = os.time() + Config.PrepTime

    self:teamOneEvent("prp-point-control:constructMission", {
        missionId = self.id,
        locationId = self.locationId,
        isEnemy = false,
        factions = {
            self.faction,
            self.enemyFaction
        }
    })
    self:teamTwoEvent("prp-point-control:constructMission", {
        missionId = self.id,
        locationId = self.locationId,
        isEnemy = true,
        factions = {
            self.faction,
            self.enemyFaction
        }
    })
    self:teamOneEvent("prp-point-control:showNotification", {
        title = locale("MISSION_STARTED"),
        description = locale("GET_TO_YOUR_STARTING_POINT", "A"),
        duration = 10000,
        type = "success",
    })
    self:teamTwoEvent("prp-point-control:showNotification", {
        title = locale("MISSION_STARTED"),
        description = locale("GET_TO_YOUR_STARTING_POINT", "B"),
        duration = 10000,
        type = "success",
    })

    self:event("prp-point-control:startCountdown", self.startRaceAt)

    SetTimeout(Config.PrepTime * 1000, function()
        self:startRace()
    end)
end

function PointControl:startRace()
    self:event("prp-point-control:startRace")
end

function PointControl:startContesting(teamId, point)
    local pointLabel = string.char(point + 64)

    if not self.points[point] then
        self.points[point] = {
            teamId = teamId,
            progress = 0,
            capturing = true,
        }

        self:showNotification(nil, locale("STARTING_TO_CONTEST", pointLabel))
    else
        self.points[point].capturing = true

        if self.points[point].teamId ~= teamId then
            self.points[point].contesting = teamId

            local contestingTeam = self.teamOneId == teamId and "A" or self.teamTwoId == teamId and "B" or
                nil

            if contestingTeam then
                self:showNotification(nil, locale("POINT_CONTESTED", contestingTeam, pointLabel))
            end
        end
    end

    if self.points[point].tick then
        ClearInterval(self.points[point].tick)
    end

    self.points[point].tick = SetInterval(function()
        local pointData = self.points[point]

        if not pointData.capturing then
            return
        end

        local captureSpeed = Config.CaptureSpeed + 0.0

        if pointData.contesting then
            local wasContested = pointData.progress >= 100

            captureSpeed = Config.ContestSpeed + 0.0

            pointData.progress = pointData.progress - captureSpeed

            if wasContested then
                self:getWinner()
            end

            if pointData.progress <= 0 then
                pointData.progress = 0
                pointData.capturing = true
                pointData.teamId = pointData.contesting
                pointData.contesting = nil
            end
        else
            pointData.progress = pointData.progress + captureSpeed
        end

        if pointData.progress >= 100 then
            pointData.progress = 100
            pointData.capturing = false
            pointData.contesting = nil

            local capturingTeam = self.teamOneId == pointData.teamId and "A" or "B"
            local pointLabel = string.char(point + 64)
            if capturingTeam then
                local localeText = locale("POINT_CAPTURED", capturingTeam, pointLabel)

                self:showNotification(nil, localeText)
            end

            self:getWinner()

            if pointData.tick then
                ClearInterval(pointData.tick)
                pointData.tick = nil
            end
        end

        self:sendPoints()
    end, 100)
end

function PointControl:getWinner()
    local teamPoints = 0
    local enemyPoints = 0

    for _, point in pairs(self.points) do
        if point.progress and point.progress >= 100 and not point.contested then
            if point.teamId == self.teamOneId then
                teamPoints = teamPoints + 1
            elseif point.teamId == self.teamTwoId then
                enemyPoints = enemyPoints + 1
            end
        end
    end

    lib.print.debug("CHecking winner:", teamPoints, enemyPoints, self.winnerTick)

    if teamPoints >= Config.NeededToWin and enemyPoints < teamPoints and not self.winnerTick then
        self:event("prp-point-control:announceWinning", os.time() + Config.TimeForWin, "A")

        self.winnerTick = lib.timer(Config.TimeForWin * 1000, function()
            self:finish(false)
            self.winnerTick = nil
        end, true)
    elseif enemyPoints >= Config.NeededToWin and teamPoints < enemyPoints and not self.winnerTick then
        self:event("prp-point-control:announceWinning", os.time() + Config.TimeForWin, "B")

        self.winnerTick = lib.timer(Config.TimeForWin * 1000, function()
            self:finish(true)
            self.winnerTick = nil
        end, true)
    else
        if self.winnerTick then
            self:event("prp-point-control:hideTimer")

            self.winnerTick:forceEnd(false)
            self.winnerTick = nil
        end
    end
end

function PointControl:stopContesting(point)
    if not self.points[point] then
        return
    end

    self.points[point].capturing = false
    self.points[point].contesting = nil

    if self.points[point].tick then
        ClearInterval(self.points[point].tick)
        self.points[point].tick = nil
    end

    self:sendPoints()
    self:getWinner()
end

function PointControl:teamIdToFaction(teamId)
    if teamId == self.teamOneId then return "Apex"
    elseif teamId == self.teamTwoId then return "Weave"
    end
    return nil
end

function PointControl:sendPoints()
    local uiPoints = {}

    for index, point in ipairs(Config.Locations[self.locationId].points) do
        local pointData = self.points[index] or {}

        local ownerFaction = self:teamIdToFaction(pointData.teamId)
        local capturingId = pointData.contesting or (pointData.capturing and pointData.teamId) or nil
        local capturingFaction = self:teamIdToFaction(capturingId)

        table.insert(uiPoints, {
            id = index,
            label = string.char(index + 64),
            position = { x = point.coords.x, y = point.coords.y, z = point.coords.z },
            captureStatus = (pointData.progress or 0) >= 100 and "captured" or pointData.contesting and "contested" or
                pointData.capturing and "capturing" or "inactive",
            ownerFaction = ownerFaction,
            capturingFaction = capturingFaction,
            captureProgress = pointData.progress or 0,
            team = pointData.teamId
        })
    end

    self:event("prp-point-control:updatePoints", uiPoints)
end

function PointControl:showNotification(title, description)
    self:event("prp-bridge:notify", 'inform', description, title, 5000)
end

function PointControl:finish(teamTwoWon)
    local ok, err = pcall(function()
        local sources = teamTwoWon and self:getTeamTwoPlayerIds() or self:getTeamOnePlayerIds()

        local loot = GetLootReward(Config.Mission.loot.rolls, Config.Mission.loot.table)

        local lootNames = {}
        if loot then
            for _, src in pairs(sources) do
                if src and DoesPlayerExist(src) then
                    for _, item in pairs(loot) do
                        bridge.inv.giveItem(src, item.name, item.count, item.metadata)
                        lootNames[#lootNames + 1] = ("%sx %s"):format(item.count, item.name)
                    end
                end
            end
        end

        bridge.log.send(MainConfig.LogWebhook, "Point Control Finished", "A point control mission has finished.", {
            mission_id = self.id,
            location_id = self.locationId,
            winning_team = teamTwoWon and "team_two" or "team_one",
            winners = sources,
            rewards = table.concat(lootNames, ", "),
        })
    end)

    if not ok then
        lib.print.error("Error in PointControl:finish():", err)
    end

    self:cleanup()
end

function PointControl:cleanup()
    self:event("prp-point-control:cleanup")

    if self.hookId then
        bridge.inv.removeHooks(self.hookId)
        self.hookId = nil
    end

    if self.pointStashes then
        for _, stashId in pairs(self.pointStashes) do
            bridge.inv.clearInventory(stashId)
        end
        self.pointStashes = nil
        self.pointStashToIndex = nil
    end

    if self.generatedStartCrate then
        for _, stashId in pairs(self.generatedStartCrate) do
            bridge.inv.clearInventory(stashId)
        end
        self.generatedStartCrate = nil
    end

    self:destroy()
end

function PointControl:destroy()
    Queue:setTaskIsExecuting(self.taskId, false)

    ActiveMissions[self.id] = nil
end

lib.callback.register("prp-point-control:openCrate", function(pSource, crateType)
    local mission = GetActiveMissionByPlayerId(pSource)

    if not mission then
        lib.print.debug("No active mission found for player " .. pSource)
        return false, "No active mission"
    end

    local teamId = mission.teamOnePlayers[tostring(pSource)] and mission.teamOneId or
        mission.teamTwoPlayers[tostring(pSource)] and mission.teamTwoId or nil

    if not teamId then
        lib.print.debug("Player " .. pSource .. " is not in any team")
        return false
    end

    if string.match(crateType, "START") then
        if not mission.generatedStartCrate then
            mission.generatedStartCrate = {}
        end

        if not mission.generatedStartCrate[crateType] then
            mission.generatedStartCrate[crateType] = bridge.inv.createTemporaryStash({
                label = locale('RACE_STASH_LABEL'),
                slots = 1,
                maxWeight = 100,
                items = {
                    {
                        name = Config.Items.controlCrate,
                        count = 1,
                        metaData = {
                            teamId = teamId,
                            team = mission.teamOneId == teamId and "A" or "B"
                        }
                    }
                }
            })
        end

        bridge.inv.forceOpenStash(pSource, mission.generatedStartCrate[crateType])
        return true
    else
        local success = lib.callback.await("prp-bridge:progress", pSource, {
            duration = MainConfig.Debug and 1000 or 10000,
            label = locale("OPENING_CRATE"),
            canCancel = true,
            controlDisables = { disableMovement = true, disableCarMovement = true },
            animation = {
                dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                clip = "machinic_loop_mechandplayer",
                flag = 1
            }
        })

        if not success then
            lib.print.debug("Player " .. pSource .. " canceled opening the crate")
            return false
        end

        local pointIndex = tonumber(string.match(crateType, "POINT_(%d+)"))

        if not pointIndex or not mission.pointStashes or not mission.pointStashes[pointIndex] then
            lib.print.debug("Invalid crate type or point index for player " .. pSource)
            return false
        end

        lib.print.debug("Player " .. pSource .. " opened crate for point " .. pointIndex)
        bridge.inv.forceOpenStash(pSource, mission.pointStashes[pointIndex])
        return true
    end
end)
