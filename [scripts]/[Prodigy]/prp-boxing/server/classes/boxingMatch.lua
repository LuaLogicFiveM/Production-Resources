BoxingMatches = {}
BoxingMatch = {}
BoxingMatch.__index = BoxingMatch
BoxingMatchId = 1
PlayerMatches = {}

---@return BoxingMatch
function BoxingMatch:New(firstPlayer, secondPlayer, roundTime, rounds, ringIndex, isSparing, restTimer)
    local match = setmetatable({}, self)

    match.id = BoxingMatchId
    BoxingMatchId = BoxingMatchId + 1

    match.firstSource = firstPlayer
    match.secondSource = secondPlayer
    match.currentRound = 1
    match.roundTime = roundTime or 180
    match.totalRounds = rounds or 3
    match.ringIndex = ringIndex
    match.isSparing = isSparing or false
    match.restTimer = restTimer or 30
    match.forceStop = false
    Config.BoxingRings[ringIndex].matchId = match.id
    PlayerMatches[firstPlayer] = match.id
    PlayerMatches[secondPlayer] = match.id
    match.totalPoints = {}

    Player(firstPlayer).state.inBoxing = true
    Player(secondPlayer).state.inBoxing = true

    BoxingMatches[match.id] = match
    return match
end

function BoxingMatch:GetCoordsFromRings()
    local ring = Config.BoxingRings[self.ringIndex]
    if not ring then return nil, nil end
    local firstOffset = Config.RingCorners[1]
    local firstPosition = vec4(OffsetPosition(ring.position.xyz, ring.position.w, firstOffset.x, firstOffset.y, firstOffset.z), ring.position.w - firstOffset.w)
    local secondOffset = Config.RingCorners[2]
    local secondPosition = vec4(OffsetPosition(ring.position.xyz, ring.position.w, secondOffset.x, secondOffset.y, secondOffset.z), ring.position.w - secondOffset.w)
    return firstPosition, secondPosition
end

function BoxingMatch:GetRestCoords()
    local ring = Config.BoxingRings[self.ringIndex]
    if not ring then return nil, nil end
    local firstOffset = Config.RestCorners[1]
    local firstPosition = vec4(OffsetPosition(ring.position.xyz, ring.position.w, firstOffset.x, firstOffset.y, firstOffset.z), ring.position.w - firstOffset.w)
    local secondOffset = Config.RestCorners[2]
    local secondPosition = vec4(OffsetPosition(ring.position.xyz, ring.position.w, secondOffset.x, secondOffset.y, secondOffset.z), ring.position.w - secondOffset.w)
    return firstPosition, secondPosition
end

function BoxingMatch:CreatePeds(firstPosition, secondPosition)

    local firstPed = SyncPed:New(self.firstSource, firstPosition, false, 100, 100, "blue")
    local secondPed = SyncPed:New(self.secondSource, secondPosition, false, 100, 100, "red")

    self.firstPed = firstPed
    self.secondPed = secondPed
    self.firstPosition = firstPosition
    self.secondPosition = secondPosition
end

function BoxingMatch:CountPoints()
    local points = { 10, 10 }
    local firstPed, secondPed = self.firstPed, self.secondPed
    if firstPed.health > secondPed.health then
        points[2] = points[2] - 1
    elseif secondPed.health > firstPed.health then
        points[1] = points[1] - 1
    end
    if firstPed.hits < secondPed.hits then
        points[2] = points[2] - 1
    elseif secondPed.hits < firstPed.hits then
        points[1] = points[1] - 1
    end
    points[2] = points[2] - secondPed.downCount
    points[1] = points[1] - firstPed.downCount
    return points
end

function BoxingMatch:ResetPeds()
    self.firstPed.hits = 0
    self.firstPed.hitsDefended = 0
    self.firstPed.downCount = 0
    self.firstPed.timeDefending = 0
    self.firstPed.health = self.firstPed.maxHealth
    self.firstPed.maxStamina = math.max(10, self.firstPed.maxStamina - math.floor(self.firstPed.totalStaminaUsed * Config.RemoveMaxStaminaPercentage / 100))
    self.firstPed.stamina = self.firstPed.maxStamina
    self.firstPed.isDown = false
    self.firstPed.isKo = false
    self.firstPed.totalStaminaUsed = 0
    self.firstPed:ClearPedTasks()

    self.secondPed.hits = 0
    self.secondPed.hitsDefended = 0
    self.secondPed.downCount = 0
    self.secondPed.timeDefending = 0
    self.secondPed.health = self.secondPed.maxHealth
    self.secondPed.maxStamina = math.max(10, self.secondPed.maxStamina - math.floor(self.secondPed.totalStaminaUsed * Config.RemoveMaxStaminaPercentage / 100))
    self.secondPed.stamina = self.secondPed.maxStamina
    self.secondPed.isDown = false
    self.secondPed.isKo = false
    self.secondPed.totalStaminaUsed = 0
    self.secondPed:ClearPedTasks()
end

function BoxingMatch:StartRound()
    TriggerClientEvent("prp-boxing:startRound", self.firstSource, self.currentRound, self.roundTime, self.firstPosition)
    TriggerClientEvent("prp-boxing:startRound", self.secondSource, self.currentRound, self.roundTime, self.secondPosition)
    Citizen.Wait(4400)
    self:SendEvent("prp-boxing:playBell", 1)
    local endTime = os.time() + self.roundTime
    local matchId = self.id
    while os.time() < endTime and not self.forceStop and BoxingMatches[matchId] do
        if not DoesPlayerExist(self.firstSource) or not DoesPlayerExist(self.secondSource) then
            self.forceStop = true
            self.noWin = true
            return
        end
        Citizen.Wait(100)
    end
    if not BoxingMatches[matchId] then return end
    self:SendEvent("prp-boxing:endRound")
    Citizen.Wait(500)
    if not self.forceStop then
        self.totalPoints[self.currentRound] = self:CountPoints()
        self:ResetPeds()
        self.currentRound = self.currentRound + 1
    end
end

function BoxingMatch:Rest()
    local firstPosition, secondPosition = self:GetRestCoords()
    TriggerClientEvent("prp-boxing:restStage", self.firstSource, self.restTimer, firstPosition, self.firstPed.maxStamina)
    TriggerClientEvent("prp-boxing:restStage", self.secondSource, self.restTimer, secondPosition, self.secondPed.maxStamina)
    local endTime = os.time() + self.restTimer + 2
    local matchId = self.id
    while os.time() < endTime and not self.forceStop and BoxingMatches[matchId] do
        if not DoesPlayerExist(self.firstSource) or not DoesPlayerExist(self.secondSource) then
            self.forceStop = true
            self.noWin = true
            return
        end
        Citizen.Wait(100)
    end
    if not BoxingMatches[matchId] then return end
end

function BoxingMatch:StartMatch()
    local introductionArray = {}
    for k, v in pairs(Config.IntroductionAnims) do
        introductionArray[#introductionArray+1] = k
    end
    local matchId = self.id
    local firstAnim = (self.firstPed.introductionAnim and Config.IntroductionAnims[self.firstPed.introductionAnim] and self.firstPed.introductionAnim) or introductionArray[math.random(1, #introductionArray)]
    local secondAnim = (self.secondPed.introductionAnim and Config.IntroductionAnims[self.secondPed.introductionAnim] and self.secondPed.introductionAnim) or introductionArray[math.random(1, #introductionArray)]
    self:SendEvent("prp-boxing:introducePlayer", self.firstSource, GetBoxingPlayerStatistics(self.firstSource, self.firstPed.color), firstAnim)
    Citizen.Wait(5500)
    if not BoxingMatches[matchId] then return end
    self:SendEvent("prp-boxing:introducePlayer", self.secondSource, GetBoxingPlayerStatistics(self.secondSource, self.secondPed.color), secondAnim, true)
    Citizen.Wait(5500)
    if not BoxingMatches[matchId] then return end
    for i=1, self.totalRounds do
        self:StartRound()
        if self.forceStop then break end
        if not BoxingMatches[matchId] then return end
        self:SendEvent("prp-boxing:playBell", 1)
        if self.restTimer > 5 and i ~= self.totalRounds then
            self:Rest()
        end
        Citizen.Wait(700)
    end
    self:SendEvent("prp-boxing:playBell", 3)
    if not BoxingMatches[matchId] then return end
    if self.noWin then
        self:Destroy()
        return
    end
    local firstTotal = 0
    local secondTotal = 0
    for _, pts in pairs(self.totalPoints) do
        firstTotal = firstTotal + pts[1]
        secondTotal = secondTotal + pts[2]
    end
    local firstCharId, secondCharId = bridge.fw.getIdentifier(self.firstSource), bridge.fw.getIdentifier(self.secondSource)
    local winCharId = (firstTotal > secondTotal) and firstCharId or (secondTotal > firstTotal) and secondCharId or nil
    if not self.isSparing then
        exports.oxmysql:insert_async("INSERT INTO boxing_matches (firstPlayer, secondPlayer, wonPlayer, isKo) VALUES (?, ?, ?, ?)", {
            firstCharId, secondCharId, winCharId or 0, self.isKo and 1 or 0
        })
    end
    local firstWin = firstCharId == winCharId
    local celebrationArray = {}
    for k, v in pairs(Config.CelebrationAnims) do
        celebrationArray[#celebrationArray+1] = k
    end
    local firstAnim = ((self.firstPed.celebrationAnim and Config.CelebrationAnims[self.firstPed.celebrationAnim] and self.firstPed.celebrationAnim) or celebrationArray[math.random(1, #celebrationArray)])
    local secondAnim = ((self.secondPed.celebrationAnim and Config.CelebrationAnims[self.secondPed.celebrationAnim] and self.secondPed.celebrationAnim) or celebrationArray[math.random(1, #celebrationArray)])
    local pointsString = ""
    for round, pts in ipairs(self.totalPoints) do
        pointsString = pointsString .. string.format("%d - %d\n", firstWin and pts[1] or pts[2], firstWin and pts[2] or pts[1])
    end
    self.firstPed:ClearPedTasks()
    self.secondPed:ClearPedTasks()
    local firstStateId = bridge.fw.getIdentifier(self.firstSource)
    local secondStateId = bridge.fw.getIdentifier(self.secondSource)
    self:SendEvent("prp-boxing:matchEnded", firstWin and self.firstSource or self.secondSource, pointsString, self.isKo, firstWin and firstAnim or secondAnim, bridge.fw.getCharacterName(firstWin and firstStateId or secondStateId), firstWin and self.firstPosition or self.secondPosition, firstWin and self.firstPed.color or self.secondPed.color, winCharId == 0, self.ringIndex)
    Citizen.Wait(10000)
    if not BoxingMatches[matchId] then return end
    self:Destroy()
end

function BoxingMatch:OnKo(source)
    Citizen.Wait(2000)
    self.isKo = true
    local isFirst = source == self.firstSource
    self.forceStop = true
    if isFirst then 
        self.totalPoints[self.currentRound] = { 99999, 0 }
    else
        self.totalPoints[self.currentRound] = { 0, 99999 }
    end
    self.currentRound = self.totalRounds + 1
end

function BoxingMatch:StartControl()
    TriggerClientEvent("prp-boxing:startBoxingControl", self.firstSource, tostring(self.secondSource))
    TriggerClientEvent("prp-boxing:startBoxingControl", self.secondSource, tostring(self.firstSource))
end

function BoxingMatch:SendEvent(eventName, ...)
    if DoesPlayerExist(self.firstSource) then
        TriggerClientEvent(eventName, self.firstSource, ...)
    end
    if DoesPlayerExist(self.secondSource) then
        TriggerClientEvent(eventName, self.secondSource, ...)
    end
end

function BoxingMatch:Destroy()
    if self.firstPed then
        self.firstPed:Destroy()
    end
    if self.secondPed then
        self.secondPed:Destroy()
    end
    PlayerMatches[self.firstSource] = nil
    PlayerMatches[self.secondSource] = nil
    if Config.BoxingRings[self.ringIndex] then
        Config.BoxingRings[self.ringIndex].matchId = nil
    end
    local firstPlayer, secondPlayer = self.firstSource, self.secondSource
    BoxingMatches[self.id] = nil
    Player(firstPlayer).state.inBoxing = nil
    Player(secondPlayer).state.inBoxing = nil
end

function GetPlayerBoxingMatch(playerSource)
    local matchId = PlayerMatches[playerSource]
    if not matchId then return nil end
    return BoxingMatches[matchId]
end

function GetBoxingPlayerStatistics(playerSource, color)
    local charId = bridge.fw.getIdentifier(playerSource)
    if not charId then return nil end
    local winStreak = 0
    local result = exports.oxmysql:query_async("SELECT wonPlayer, endTime FROM boxing_matches WHERE (firstPlayer = ? OR secondPlayer = ?) ORDER BY endTime DESC LIMIT 20", { charId, charId })
    for k, v in pairs(result or {}) do
        if v.wonPlayer == charId then
            winStreak = winStreak + 1
        else
            break
        end
    end
    local stats = exports.oxmysql:query_async("SELECT COUNT(*) AS matches, SUM(CASE WHEN wonPlayer = ? THEN 1 ELSE 0 END) AS wins, SUM(CASE WHEN wonPlayer = 0 THEN 1 ELSE 0 END) AS draws FROM boxing_matches WHERE firstPlayer = ? OR secondPlayer = ?", { charId, charId, charId })[1]
    stats = stats or { matches = 0, wins = 0, draws = 0 }
    stats.winStreak = winStreak
    stats.color = color
    stats.wins = stats.wins or 0
    stats.draws = stats.draws or 0
    stats.matches = stats.matches or 0
    stats.name = bridge.fw.getCharacterName(charId)
    return stats
end