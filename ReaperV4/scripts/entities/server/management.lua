-- Register Settings
local whitelist_enabled = false
local auto_whitelist_enabled = false
local under_attack_mode = false
local onesync_entities_enabled = false

-- Register settings listeners
local PICKUP_EVENTS = Convar.getByName("reaper_block_pickup_events")
Convar.getByName("reaper_entity_whitelist"):subscribe(function (convar) whitelist_enabled = convar:getAsBool() end)
Convar.getByName("reaper_auto_entity_whitelist"):subscribe(function (convar) auto_whitelist_enabled = convar:getAsBool() end)
Convar.getByName("reaper_under_attack_mode"):subscribe(function (convar) under_attack_mode = convar:getAsBool() end)
Convar.getByName("reaper_entity_npc_enabled"):subscribe(function (convar)
    local value <const> = convar:getAsBool()
    onesync_entities_enabled = value
    Entities:setOnesyncPopulation(convar:getAsBool())
end)

-- Pickups are abused by cheaters to spawn entity "models" on players
-- Server owners can enable/disable this feature by adjusting the convar
if PICKUP_EVENTS:get() == 1 then
    ExecuteCommand('block_net_game_event "GIVE_PICKUP_REWARDS_EVENT"')
    ExecuteCommand('block_net_game_event "PICKUP_DESTROYED_EVENT"')
    ExecuteCommand('block_net_game_event "REQUEST_MAP_PICKUP_EVENT"')
    ExecuteCommand('block_net_game_event "REQUEST_PICKUP_EVENT"') 
end

---@param entity EntityData
EntityManagement:addEvaluateHook(function (entity, mutate)
    -- Get player object and verify its existence, if player doesnt exist return
    local player <const> = Player(entity.creator_src)
    if not player then return { reason = "player_src_nil" } end

    -- Verify that underAttackMode isnt enabled. When enabled delete all entities and log
    if under_attack_mode then
        return { reason = "under_attack_mode_enabled", spawn_data = entity }
    end

    -- Check if the model is blacklisted
    local blacklisted_entry <const> = Entities:isModelBlacklisted(entity.model)
    
    if blacklisted_entry then
        player:newDetection("blacklistedEntity", {
            model = entity.model,
            auto_blacklisted = blacklisted_entry.auto_blacklisted
        }, { blacklisted_entry.model }, blacklisted_entry.action)

        return { reason = "model_blacklisted", spawn_data = entity }
    end

    -- Verify that the player is authorized, if not delete
    if whitelist_enabled then
        if (entity.model == 225514697 and entity.type == 1) or (entity.type == 3 and entity.model == 0) then
            return
        end

        -- Check if its a NPC entity and if they are enabled, allow the spawn
        if entity.is_npc and onesync_entities_enabled == true then
            return
        end
        if
            (auto_whitelist_enabled and ((player:getMeta("authorized_" .. entity.type_name .. ":" .. entity.model) or (Entities:isModelATrain(entity.model) and player:getMeta("authorized_train")))) or
            Entities:isModelWhitelisted(entity.model) or
            Entities:isModelTempAllowed(entity.model))
        then
            return
        end

        return { reason = "player_not_authorized", spawn_data = entity }
    end
end)