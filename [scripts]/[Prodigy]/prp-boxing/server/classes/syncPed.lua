SyncPeds = {}
SyncPed = {}
SyncPed.__index = SyncPed

---@return SyncPed
function SyncPed:New(playerSource, position, isNpc, maxHealth, maxStamina, color, overrideFirstName, overrideLastName)
    local characterName = "Unknown Boxer"
    local stateId = bridge.fw.getIdentifier(playerSource)
    if stateId then
        local charName = bridge.fw.getCharacterName(stateId)
        if charName then
            characterName = charName
        end
    end
    local characterFirstName, characterLastName = characterName:match("^(%S+)%s+(.+)$")
    local ped = setmetatable({}, self)
    ped.position = position
    ped.maxHealth = maxHealth or 100
    ped.maxStamina = maxStamina or 100
    if not isNpc then
        ped.damageMultiplier = 1.0
        ped.staminaRegenMultiplier = 1.0
        local prefferedAnims = lib.callback.await("prp-boxing:getPreferredAnims", playerSource)
        ped.introductionAnim = prefferedAnims.intro
        ped.celebrationAnim = prefferedAnims.win
    else
        ped.damageMultiplier = 1.0
        ped.staminaRegenMultiplier = 1.0
    end
    ped.isNpc = isNpc or false
    ped.health = ped.maxHealth
    ped.stamina = ped.maxStamina
    ped.firstName = overrideFirstName or characterFirstName
    ped.lastName = overrideLastName or characterLastName
    ped.color = color or "red"
    ped.defending = false
    ped.lastPositions = {}
    ped.subscribers = {}
    ped.hits = 0
    ped.lastHit = 0
    ped.hitsDefended = 0
    ped.downCount = 0
    ped.timeDefending = 0
    ped.mashDifficulty = 5
    ped.lastAction = 0
    ped.totalStaminaUsed = 0
    ped.owner = playerSource
    playerSource = tostring(playerSource) .. (ped.isNpc and "_npc" or "")
    ped.source = playerSource
    if ped.isNpc then
        ped.firstName = Config.RandomFirstNames[math.random(1, #Config.RandomFirstNames)]
        ped.lastName = Config.RandomLastNames[math.random(1, #Config.RandomLastNames)]
    end
    SyncPeds[playerSource] = ped
    DebugPrint("Created SyncPed for source:", playerSource, "isNpc:", ped.isNpc)
    TriggerClientEvent("prp-boxing:createPed", -1, playerSource, position, ped.isNpc, ped.maxHealth, ped.maxStamina, ped.firstName, ped.lastName, ped.color)
    return SyncPeds[playerSource]
end

function SyncPed:CheckHitbox(boneCoords, position)
    local hit = false
    for hitbox, v in pairs(Config.Hitboxes) do
        local offsetPosition = OffsetPosition(position.xyz, position.w, v.offset.x, v.offset.y, v.offset.z)
        if CheckHitbox(boneCoords, offsetPosition, v.size.x, v.size.y, v.size.z, position.w) then
            hit = hitbox
            break
        end
    end
    return hit
end

function SyncPed:CheckHit(boneCoords, actionType, ping)
    if self.isKo or self.isDown then return end
    local hit
    for i=#self.lastPositions, #self.lastPositions-math.min(math.max(1, math.floor(ping/50)), 3), -1 do
        local pos = self.lastPositions[i]
        hit = self:CheckHitbox(boneCoords, pos.position)
        if hit then break end
    end
    if DebugOn then
        self:SendToSubscribers("prp-boxing:pedHitDebug", self.source, boneCoords, hit)
    end
    if hit then
        local isDown, defended = false, self.defending
        local changed = false
        if defended and self.stamina < Config.DefenseStaminaCost[actionType] then
            defended = false
        elseif defended then
            self.stamina = math.max(0, self.stamina - Config.DefenseStaminaCost[actionType])
            changed = true
            self.hitsDefended = self.hitsDefended + 1
        end
        local damage = Config.AttackDamage[actionType] or 0
        damage = math.floor(damage * (self.damageMultiplier or 1.0))
        if not defended then
            local oldHealth = self.health
            self.health = math.max(0, self.health - damage)
            if self.isTutorial and self.isNpc then
                self.health = math.max(20, self.health)
            end
            isDown = self.health <= 0 and oldHealth > 0
            self.downCount = isDown and self.downCount + 1 or self.downCount
            changed = true
            self.hits = self.hits + 1
            self.isDown = isDown
            self.lastHit = GetTimeInMilis()
        end
        if changed then
            self:SendToSubscribers("prp-boxing:syncPedData", self.source, self:GetSyncData())
        end
        local isKo = false
        if isDown and self.downCount > 3 and not self.isTutorial then
            isKo = true
            self.isKo = isKo
        end
        if self.health <= Config.KOThreshold and Config.KOAttacks[actionType] and math.random(1, 100) <= Config.KOAttacks[actionType] and not self.isTutorial then
            isKo = true
            self.isKo = isKo
        end
        DebugPrint("Hit detected:", hit, "Defending:", defended)
        self:SendToSubscribers("prp-boxing:onHit", self.source, actionType, isKo, defended, isDown, math.random(1, Config.HitSoundCount))
        isKo = self:OnHit(actionType, isKo, defended, isDown)
        return isKo
    end
end

function SyncPed:Destroy()
    TriggerClientEvent("prp-boxing:removePed", -1, self.source)
    SyncPeds[self.source] = nil
end

function SyncPed:GetSyncData()
    if not self.position then
        return nil
    end
    return {
        self.position,
        self.health,
        self.stamina,
        DebugOn and {}
    }
end

ON_HIT_BOXING_ANIMS = {
    dict = "reck@boxing@hits",
    jab_l = "thdown",
    jab_r = "thdown",
    hook_l = "thleft",
    hook_r = "thright",
    jab_l_ko = "koleft",
    jab_r_ko = "koright",
    hook_l_ko = "koleft",
    hook_r_ko = "koright",
    upper_l = "thup",
    upper_r = "thup",
    upper_l_ko = "koup",
    upper_r_ko = "koup",
    jab_l_defended = "ddown",
    jab_r_defended = "ddown",
    hook_l_defended = "dleft",
    hook_r_defended = "dright",
    upper_l_defended = "dup",
    upper_r_defended = "dup",
    defend_dict = "reck@boxing@movedefend",
}

function SyncPed:StopAnimation(animDict, animName)
    self:SendToSubscribers("prp-boxing:stopAnimSync", self.source, animDict, animName, true)
end

function SyncPed:PlayAnimation(animDict, animName, duration, flag, force)
    self:SendToSubscribers("prp-boxing:playAnimSync", self.source, { animDict, animName, duration, flag, force, true })
end

function SyncPed:ClearPedTasks()
    self:SendToSubscribers("prp-boxing:clearPedTasks", self.source)
end

function SyncPed:OnHit(actionType, isKo, defended, isDown)
    local stringSplit = string.split(actionType, "_")
    local animName = stringSplit[1] .. "_" .. stringSplit[#stringSplit]
    local hitAnim = ON_HIT_BOXING_ANIMS[animName]
    if isKo then
        hitAnim = ON_HIT_BOXING_ANIMS[animName .. "_ko"]
        self:ClearPedTasks()
        self:PlayAnimation(ON_HIT_BOXING_ANIMS.dict, hitAnim, -1, 2, true)
        Citizen.Wait(3000)
        return true
    end
    if isDown then
        Citizen.Wait(3000)
        if not self.isDown then return end
        if self.isNpc then
            Citizen.Wait(math.random(2000, 4000))
            if not self.isDown then return end
            if math.random(1, 2) == 1 then
                self:StopAnimation(ON_HIT_BOXING_ANIMS.dict, "stun_stunned")
                self:PlayAnimation(ON_HIT_BOXING_ANIMS.dict, "stun_getup", -1, 0, true)
                self.isDown = false
                self.health = self.maxHealth
                self.stamina = self.maxStamina
                self:SendToSubscribers("prp-boxing:syncPedData", self.source, self:GetSyncData())
            else
                self:StopAnimation(ON_HIT_BOXING_ANIMS.dict, "stun_stunned")
                self:PlayAnimation(ON_HIT_BOXING_ANIMS.dict, "stun_ko", -1, 2, true)
                return true
            end
        else
            local success = lib.callback.await("prp-boxing:downMashMinigame", self.owner, self.mashDifficulty + self.downCount)
            if not self.isDown then return end
            if success or self.isTutorial then
                self:StopAnimation(ON_HIT_BOXING_ANIMS.dict, "stun_stunned")
                self:PlayAnimation(ON_HIT_BOXING_ANIMS.dict, "stun_getup", -1, 0, true)
                self.health = self.maxHealth
                self.stamina = self.maxStamina
                self:SendToSubscribers("prp-boxing:syncPedData", self.source, self:GetSyncData())
                Citizen.Wait(1500)
                self.isDown = false
            else
                self:StopAnimation(ON_HIT_BOXING_ANIMS.dict, "stun_stunned")
                self:PlayAnimation(ON_HIT_BOXING_ANIMS.dict, "stun_ko", -1, 2, true)
                self.isKo = true
                return true
            end
        end
        return
    end
    if defended then
        hitAnim = ON_HIT_BOXING_ANIMS[animName .. "_defended"]
        self:PlayAnimation(ON_HIT_BOXING_ANIMS.defend_dict, hitAnim, -1, 50, true)
        return
    end
    self:PlayAnimation(ON_HIT_BOXING_ANIMS.dict, hitAnim, -1, 32, true)
end

function SyncPed:SendToSubscribers(event, ...)
    if not self.subscribers then return end
    local message = msgpack.pack_args(...)
    local msgLen = message:len()
    for subscriber, _ in pairs(self.subscribers) do
        if DoesPlayerExist(subscriber) then
            TriggerClientEventInternal(event, subscriber, message, msgLen)
        end
    end
end

RegisterNetEvent("prp-boxing:syncPlayAnim", function(data, isNpc)
    local targetSource = tostring(source)
    if isNpc then
        targetSource = targetSource .. "_npc"
    end
    if not SyncPeds[targetSource] then return end
    SyncPeds[targetSource]:SendToSubscribers("prp-boxing:playAnimSync", targetSource, data)
end)

RegisterNetEvent("prp-boxing:syncStopAnim", function(data, isNpc)
    local targetSource = tostring(source)
    if isNpc then
        targetSource = targetSource .. "_npc"
    end
    if not SyncPeds[targetSource] then return end
    SyncPeds[targetSource]:SendToSubscribers("prp-boxing:stopAnimSync", targetSource, data)
end)

RegisterNetEvent("prp-boxing:syncClearTasks", function(isNpc, ownerForce)
    local targetSource = tostring(source)
    if isNpc then
        targetSource = targetSource .. "_npc"
    end
    if not SyncPeds[targetSource] then return end
    SyncPeds[targetSource]:SendToSubscribers("prp-boxing:clearPedTasks", targetSource, ownerForce)
end)

RegisterNetEvent("prp-boxing:updateSyncData", function(data, isNpc, forceUpdate)
    local source = tonumber(source)
    local targetSource = tostring(source)
    if isNpc then
        targetSource = targetSource .. "_npc"
    end
    if not data then return end
    local ped = SyncPeds[targetSource]
    if not ped then return end
    local changed = false
    if ped.defending or ped.sprinting then
        local drain = ped.sprinting and Config.SprintStaminaCost/10 or Config.DefenseStaminaDrain/10
        local oldStamina = ped.stamina
        ped.stamina = math.max(0, ped.stamina - drain)
        ped.totalStaminaUsed = ped.totalStaminaUsed + (oldStamina - ped.stamina)
        changed = oldStamina ~= ped.stamina
    elseif not ped.isKo and not ped.isDown and GetTimeInMilis() - ped.lastAction > Config.StaminaRegenDelay then
        local oldStamina = ped.stamina
        ped.stamina = math.min(ped.maxStamina, ped.stamina + (Config.StaminaRegen/10)*ped.staminaRegenMultiplier)
        changed = oldStamina ~= ped.stamina
    end
    if ped.lastHit > 0 and GetTimeInMilis() - ped.lastHit >= Config.HealthRegenDelay and not ped.isKo and not ped.isDown then
        local oldHealth = ped.health
        ped.health = math.min(ped.maxHealth, ped.health + Config.HealthRegen/10)
        changed = oldHealth ~= ped.health or changed
    end
    if #(data[1] - ped.position) > 0 or changed or forceUpdate then
        ped:SendToSubscribers("prp-boxing:syncPedData", targetSource, ped:GetSyncData())
        ped:SetPosition(data[1], (os.nanotime() / 1e6) - GetPlayerPeerStatistics(source, 3)/2)
    end
end)


function SyncPed:SetPosition(position, timestamp)
    self.position = position
    if not self.lastPositions then
        self.lastPositions = {}
    end
    table.insert(self.lastPositions, { position = position, timestamp = timestamp })
    if #self.lastPositions > 10 then
        table.remove(self.lastPositions, 1)
    end
end

RegisterNetEvent("prp-boxing:toggleDefend", function(defending, isNpc)
    local source = tostring(source)
    if isNpc then
        source = source .. "_npc"
    end
    local ped = SyncPeds[source]
    if not ped then return end
    ped.defending = defending
    if not defending then
        ped.lastAction = GetTimeInMilis()
    end
end)

RegisterNetEvent("prp-boxing:toggleSprint", function(sprinting, isNpc)
    local source = tostring(source)
    if isNpc then
        source = source .. "_npc"
    end
    local ped = SyncPeds[source]
    if not ped then return end
    ped.sprinting = sprinting
    if not sprinting then
        ped.lastAction = GetTimeInMilis()
    end
end)

RegisterNetEvent("prp-boxing:attackStaminaDrain", function(actionType, isNpc)
    local source = tostring(source)
    if isNpc then
        source = source .. "_npc"
    end
    local ped = SyncPeds[source]
    if not ped then return end
    if ped.stamina < Config.AttackStaminaCost[actionType] then
        return
    end
    local staminaDrain = Config.AttackStaminaCost[actionType]
    if ped.isNpc then
        staminaDrain = 0
    end
    ped.stamina = math.max(0, ped.stamina - staminaDrain)
    ped.totalStaminaUsed = ped.totalStaminaUsed + staminaDrain
    ped.lastAction = GetTimeInMilis()
    ped:SendToSubscribers("prp-boxing:attackSoundEffect", ped.source, math.random(1, Config.WhooshSoundCount))
    ped:SendToSubscribers("prp-boxing:syncPedData", ped.source, ped:GetSyncData())
end)

RegisterNetEvent("prp-boxing:performAttack", function(actionType, boneCoords, isNpc)
    local source = tonumber(source)
    local match, tutorialMatch = GetPlayerBoxingMatch(source), GetPlayerTutorialMatch(source)
    match = match or tutorialMatch
    if not match then return end
    if match.firstSource ~= source and match.secondSource ~= source then
        return
    end
    local targetSource = match.firstSource == source and match.secondSource or match.firstSource
    local sourcePed = SyncPeds[isNpc and tostring(source) .. "_npc" or tostring(source)]
    if not sourcePed then return end
    if tutorialMatch then
        if isNpc then
            targetSource = tostring(source)
        else
            targetSource = source .. "_npc"
        end
    end
    sourcePed.lastAction = GetTimeInMilis()
    sourcePed:SendToSubscribers("prp-boxing:syncPedData", sourcePed.source, sourcePed:GetSyncData())
    local targetPed = SyncPeds[tostring(targetSource)]
    local isKo = targetPed:CheckHit(boneCoords, actionType, GetPlayerPeerStatistics(source, 3))
    if isKo and match and not tutorialMatch then
        match:OnKo(source, targetSource)
    end
end)

RegisterNetEvent("prp-boxing:subscribeToPed", function(targetSource)
    local playerSource = tostring(source)
    if not SyncPeds[targetSource] then return end
    if not SyncPeds[targetSource].subscribers then
        SyncPeds[targetSource].subscribers = {}
    end
    if not SyncPeds[targetSource].subscribers[playerSource] then
        SyncPeds[targetSource].subscribers[playerSource] = true
    end
end)

RegisterNetEvent("prp-boxing:unsubscribeFromPed", function(targetSource)
    local playerSource = tostring(source)
    if not SyncPeds[targetSource] then return end
    if SyncPeds[targetSource].subscribers then
        SyncPeds[targetSource].subscribers[playerSource] = nil
    end
end)

function string.split(inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end

function GetTimeInMilis()
    return GetGameTimer()
end