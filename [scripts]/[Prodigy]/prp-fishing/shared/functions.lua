function GetFishingZoneIndex(name)
    for id, zone in ipairs(FishingZones) do
        if zone.name == name then
            return id
        end
    end

    return false
end

function WeightedRandom(pool)
    local poolSize = 0

    for _, v in ipairs(pool) do
        poolSize = poolSize + v[1]
    end

    local selection = math.random(1, poolSize)

    for _, v in ipairs(pool) do
        selection = selection - v[1]

        if selection <= 0 then
            return v[2]
        end
    end
end
