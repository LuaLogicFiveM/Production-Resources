TutorialMatches = {}
TutorialMatch = {}
TutorialMatch.__index = TutorialMatch
TutorialMatchId = 1
PlayerTutorialMatches = {}
TutorialMatchHandlers = {}

---@return TutorialMatch
function TutorialMatch:New(playerSource, startStep, ringIndex)
    local match = setmetatable({}, self)

    match.id = TutorialMatchId
    TutorialMatchId = TutorialMatchId + 1

    match.firstSource = playerSource
    match.currentRound = startStep or 1
    match.roundTime = 600
    match.totalRounds = 2
    match.ringIndex = ringIndex
    match.finishedTutorials = {}
    Config.BoxingRings[ringIndex].tutorialId = match.id
    PlayerTutorialMatches[playerSource] = match.id
    match.totalPoints = {}

    TutorialMatch[match.id] = match
    return match
end

function TutorialMatch:CreatePeds(firstPosition, secondPosition)

    local firstPed = SyncPed:New(self.firstSource, firstPosition, false, 100, 100, "blue")
    local secondPed = SyncPed:New(self.firstSource, secondPosition, true, 100, 100, "red")

    self.firstPed = firstPed
    self.firstPed.isTutorial = true
    self.secondPed = secondPed
    self.secondPed.isTutorial = true
    self.firstPosition = firstPosition
    self.secondPosition = secondPosition
end

function TutorialMatch:CountPoints()
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

function TutorialMatch:ResetPeds()
    self.firstPed.hits = 0
    self.firstPed.hitsDefended = 0
    self.firstPed.downCount = 0
    self.firstPed.timeDefending = 0
    self.firstPed.health = self.firstPed.maxHealth
    self.firstPed.stamina = self.firstPed.maxStamina

    self.secondPed.hits = 0
    self.secondPed.hitsDefended = 0
    self.secondPed.downCount = 0
    self.secondPed.timeDefending = 0
    self.secondPed.health = self.secondPed.maxHealth
    self.secondPed.stamina = self.secondPed.maxStamina

end

function TutorialMatch:StartRound()
    TriggerClientEvent("prp-boxing:startRound", self.firstSource, self.currentRound, self.roundTime, self.firstPosition)
    Citizen.Wait(3500)
    TriggerClientEvent("prp-boxing:setTutorial", self.firstSource, self.currentRound)
    local currentStep = self.currentRound
    local tick = 0
    while not self.finishedTutorials[currentStep] and not self.forceStop do
        if not DoesPlayerExist(self.firstSource) then
            self:Destroy()
            return
        end
        tick = tick + 1
        if self.currentRound == 2 and tick % 10 == 0 then
            TriggerClientEvent("prp-boxing:npcControllerTask", self.firstSource, "PerformAttack", "upper_head_r")
        end
        Citizen.Wait(100)
    end
    self.totalPoints[self.currentRound] = self:CountPoints()
    self:ResetPeds()
    self.currentRound = self.currentRound + 1
end

function TutorialMatch:GetCoordsFromRings()
    local ring = Config.BoxingRings[self.ringIndex]
    if not ring then return nil, nil end
    local firstOffset = Config.RingCorners[1]
    local firstPosition = vec4(OffsetPosition(ring.position.xyz, ring.position.w, firstOffset.x, firstOffset.y, firstOffset.z), ring.position.w - firstOffset.w)
    local secondOffset = Config.RingCorners[2]
    local secondPosition = vec4(OffsetPosition(ring.position.xyz, ring.position.w, secondOffset.x, secondOffset.y, secondOffset.z), ring.position.w - secondOffset.w)
    return firstPosition, secondPosition
end

function TutorialMatch:StartMatch()
    for i=1, self.totalRounds do
        self:StartRound()
        if self.forceStop then break end
    end
    local firstTotal = 0
    local secondTotal = 0
    for _, pts in pairs(self.totalPoints) do
        firstTotal = firstTotal + pts[1]
        secondTotal = secondTotal + pts[2]
    end
    self:Destroy()
end


function TutorialMatch:StartControl()
    TriggerClientEvent("prp-boxing:startBoxingControl", self.firstSource, self.firstSource .. "_npc")
    TriggerClientEvent("prp-boxing:startNPCBoxingControl", self.firstSource, tostring(self.firstSource))
end

function TutorialMatch:SendEvent(eventName, ...)
    TriggerClientEvent(eventName, self.firstSource, ...)
end

function TutorialMatch:Destroy()
    if self.firstPed then
        self.firstPed:Destroy()
    end
    if self.secondPed then
        self.secondPed:Destroy()
    end
    TriggerClientEvent("prp-boxing:setTutorial", self.firstSource, nil)
    PlayerTutorialMatches[self.firstSource] = nil
    if Config.BoxingRings[self.ringIndex] then
        Config.BoxingRings[self.ringIndex].tutorialId = nil
    end
    TutorialMatch[self.id] = nil
end

function GetPlayerTutorialMatch(playerSource)
    local matchId = PlayerTutorialMatches[playerSource]
    if not matchId then return nil end
    return TutorialMatch[matchId]
end

RegisterNetEvent("prp-boxing:tutorialStepFinished", function(tutorialStep)
    local match = GetPlayerTutorialMatch(source)
    if not match then return end
    match.finishedTutorials[tutorialStep] = true
end)

RegisterNetEvent("prp-boxing:tutorialSkip", function()
    local match = GetPlayerTutorialMatch(source)
    if not match then return end
    match.forceStop = true
end)