function getRandomWeightedItem(pool)
    local poolsize = 0
    for k, v in pairs(pool) do
        poolsize = poolsize + v.weight
    end

    local selection = math.random(1, poolsize)
    for k, v in pairs(pool) do
        selection = selection - v.weight
        if (selection <= 0) then
            return v, k
        end
    end
end

function isAdmin(playerId)
    return bridge.fw.isAdmin(playerId)
end

-- Select up to `count` well-spaced points from a list of coords.
-- coords: array of {x=..., y=..., z=...} or vector3
-- count:  how many to pick (e.g., 9)
-- minDist: (optional) minimum allowed spacing between chosen points; if not met, selection stops early
-- use3D: (optional) set true to consider Z in distance
function selectWellSpaced(coords, count, minDist, use3D)
    local n = #coords
    if n == 0 or count <= 0 then return {} end

    local function getxy(p) -- works for either table or vector3
        local x = p.x or p[1] or p.X or p[0]
        local y = p.y or p[2] or p.Y or p[1]
        local z = p.z or p[3] or p.Z or p[2] or 0.0
        return x, y, z
    end

    local function dist2(a, b)
        local ax, ay, az = getxy(a)
        local bx, by, bz = getxy(b)
        local dx, dy = ax - bx, ay - by
        if use3D then
            local dz = az - bz
            return dx * dx + dy * dy + dz * dz
        else
            return dx * dx + dy * dy
        end
    end

    local selected = {}
    local used = {}      -- used[i] = true if coords[i] is already selected
    local nearestD2 = {} -- nearestD2[i] = squared distance from coords[i] to nearest selected

    -- Seed with a random point
    local firstIdx = math.random(n)
    table.insert(selected, coords[firstIdx])
    used[firstIdx] = true

    -- Initialize nearest distances to the first point
    for i = 1, n do
        if not used[i] then
            nearestD2[i] = dist2(coords[i], coords[firstIdx])
        else
            nearestD2[i] = 0.0
        end
    end

    local minD2 = (minDist and (minDist * minDist)) or 0.0

    -- Iteratively pick the point that maximizes distance to the current set
    while #selected < math.min(count, n) do
        local bestIdx, bestD2 = nil, -1.0

        for i = 1, n do
            if not used[i] then
                -- nearestD2[i] already tracks min distance to current selected set
                if nearestD2[i] > bestD2 then
                    bestD2 = nearestD2[i]
                    bestIdx = i
                end
            end
        end

        if not bestIdx then break end
        -- Enforce spacing if requested
        if minDist and bestD2 < minD2 then
            -- No remaining point satisfies the spacing; stop early
            break
        end

        -- Take the farthest candidate
        used[bestIdx] = true
        local chosen = coords[bestIdx]
        table.insert(selected, chosen)

        -- Update nearest distances with this newly added point
        for i = 1, n do
            if not used[i] then
                local d2 = dist2(coords[i], chosen)
                if d2 < nearestD2[i] then
                    nearestD2[i] = d2
                end
            end
        end
    end

    return selected
end

local ITEM_ID_LABEL_MAP = {}
function getItemLabel(itemId)
    if not ITEM_ID_LABEL_MAP[itemId] then
        local itemData = bridge.inv.getItemLabel(itemId)
        ITEM_ID_LABEL_MAP[itemId] = itemData or locale('UNKNOWN_ITEM_NAME')
    end

    return ITEM_ID_LABEL_MAP[itemId]
end

function getDebuffPerk(id)
    return lib.table.deepclone(svConfig.debuffs[id] or {})
end

function getShopPerk(id)
    return lib.table.deepclone(svConfig.shopPerks[id] or {})
end

local ITEM_ID_ITEM_DATA_MAP = {}
function getItem(itemId)
    if not ITEM_ID_ITEM_DATA_MAP[itemId] then
        local itemData = bridge.inv.getItemData(itemId)
        ITEM_ID_ITEM_DATA_MAP[itemId] = itemData or {}
    end

    return ITEM_ID_ITEM_DATA_MAP[itemId]
end

function reduceNumberByPercent(number, percent)
    local reductionFactor = 1 - (percent / 100)
    return number * reductionFactor
end

function increaseNumberByPercent(number, percent)
    local increaseFactor = 1 + (percent / 100)
    local result = number * increaseFactor
    return math.floor(result + 0.5)
end

function increaseFloatByPercent(float, percent)
    local increaseFactor = 1 + (percent / 100)
    local result = float * increaseFactor
    local power = 100
    return math.floor(result * power + 0.5) / power
end

function getMutation(mutationType)
    local allMutations = lib.table.deepclone(svConfig.mutations)

    for loopType, v in pairs(allMutations) do
        if loopType == mutationType then
            v.type = mutationType
            return v
        end
    end
end

function rollChance(chance)
    chance = math.max(0, math.min(100, math.floor(chance or 0)))
    return math.random(100) <= chance
end