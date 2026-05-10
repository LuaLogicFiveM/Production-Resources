local spawnLimits <const> = {
    ["ped"] = RateLimit:new("Entities/Peds", 10, 10000, true),
    ["object"] = RateLimit:new("Entities/Objects", 10, 10000, true),
    ["vehicle"] = RateLimit:new("Entities/Vehicles", 10, 10000, true)
}

---@param entity EntityData
EntityManagement:addEvaluateHook(function(entity)
    local limiter = spawnLimits[entity.type_name]

    if not limiter or entity.is_npc or Entities:isModelWhitelisted(entity.model) then
        return
    end

    local allowed, remaining, resetIn = limiter:consume("id:" .. entity.creator_src)

    if not allowed then
        return {
            reason = "rate_limited",
            type = entity.type_name,
            reset_in = resetIn,
            spawn_data = entity
        }
    end
end)