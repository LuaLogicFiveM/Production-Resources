-- init locales
lib.locale()

---@param num number
---@param numDecimalPlaces? number
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

---@param seedName string
function CanGrowInZone(seedName, zoneId)
    if not seedName or not zoneId then return false end
    local seed = Config.Seeds[seedName]
    if not seed then return false end
    if not Config.OWZones[zoneId] then return false end
    local canGrow = true
    if Config.OWZones[zoneId].humidity < seed.humidity then
        canGrow = false
    end
    if Config.OWZones[zoneId].sun < seed.sun then
        canGrow = false
    end
    return canGrow
end

---@param model number
---@return boolean
function LoadModel(model)
    if HasModelLoaded(model) then
        return true
    end

    local timeout = GetGameTimer() + 5000

    RequestModel(model)
    while not HasModelLoaded(model) and GetGameTimer() < timeout do
        Wait(0)
    end

    return HasModelLoaded(model)
end

---@param coords vector3
---@return string
function FormatVec3(coords)
    return ("vector3(%.2f, %.2f, %.2f)"):format(coords.x, coords.y, coords.z)
end
