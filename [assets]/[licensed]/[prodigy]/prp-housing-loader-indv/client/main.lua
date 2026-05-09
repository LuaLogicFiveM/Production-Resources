if not lib then
    error("ox_lib is required for prp-housing-loader")
end

---@class HouseData
---@field ipl string|string[]
---@field coords vector3
---@field outsideZoneIpl? string
---@field radius? number
---@field zone? CZone

---@class NearbyZone
---@field zoneName string
---@field index integer
---@field data HouseData

---@type table<string, HouseData[]>
local houses = {}

---@type NearbyZone[]
local nearbyZones = {}

---@param data HouseData
local function enableInterior(data)
    if not data.ipl or not data.coords then return end

    if type(data.ipl) == "table" then
        local count = 0
        for _, ipl in ipairs(data.ipl) do
            RequestIpl(ipl)
            count = count + 1
            if count % 5 == 0 then Wait(0) end
        end
    else
        RequestIpl(data.ipl)
    end

    if data.outsideZoneIpl and IsIplActive(data.outsideZoneIpl) then
        RemoveIpl(data.outsideZoneIpl)
    end
end

---@param data HouseData
local function disableInterior(data)
    if not data.ipl or not data.coords then return end

    if type(data.ipl) == "table" then
        local count = 0
        for _, ipl in ipairs(data.ipl) do
            RemoveIpl(ipl)
            count = count + 1
            if count % 5 == 0 then Wait(0) end
        end
    else
        RemoveIpl(data.ipl)
    end

    if data.outsideZoneIpl and not IsIplActive(data.outsideZoneIpl) then
        RequestIpl(data.outsideZoneIpl)
    end
end

---@param coords vector3|{x: number, y: number, z: number}
---@return {ipl: string|string[], coords: vector3}[]
local function getIplsForCoords(coords)
    if not coords then
        return {}
    end

    coords = vector3(coords.x, coords.y, coords.z)

    local insideIpls = {}
    for _, zoneData in pairs(houses) do
        for _, data in ipairs(zoneData) do
            if data.zone and data.zone:contains(coords) then
                insideIpls[#insideIpls+1] = {
                    ipl = data.ipl,
                    coords = data.coords
                }
            end
        end
    end

    return insideIpls
end

---@type number
local minSpeed = 30 -- mph
---@type number
local maxSpeed = 90 -- mph
---@type number
local maxRadius = 50.0
---@type number
local minRadius = 5.0
---@type number
local nearbyRadius = 300.0

---@param playerSpeed number
---@return number
local function calculateRadius(playerSpeed)
    if playerSpeed <= minSpeed then
        return maxRadius
    elseif playerSpeed >= maxSpeed then
        return minRadius
    else
        local t = (playerSpeed - minSpeed) / (maxSpeed - minSpeed)
        return maxRadius + t * (minRadius - maxRadius)
    end
end

local function getPlayerSpeedMph()
    return GetEntitySpeed(cache.ped) * 2.236936
end

local function updateNearbyZones()
    local playerCoords = GetEntityCoords(cache.ped)
    nearbyZones = {}
    for zoneName, zoneData in pairs(houses) do
        for k, data in ipairs(zoneData) do
            if #(playerCoords - data.coords) < nearbyRadius then
                nearbyZones[#nearbyZones+1] = { zoneName = zoneName, index = k, data = data }
            end
        end
    end
end

---@param name string
---@param radius number
---@param data (HouseData|{[1]: string|string[], [2]: number, [3]: number, [4]: number})[]
AddHouseZone = function(name, radius, data)
    for i = 1, #data do
        if data[i][1] then
            data[i] = {
                ipl = data[i][1],
                coords = vector3(data[i][2], data[i][3], data[i][4]),
                radius = radius,
            }
        else
            data[i].radius = radius
        end
    end
    houses[name] = data
end

CreateThread(function()
    Wait(0)
    for zoneName, zoneData in pairs(houses) do
        for k, data in ipairs(zoneData) do
            houses[zoneName][k].zone = lib.zones.sphere({
                coords = data.coords,
                ipl = data.ipl or "cz_"..tostring(k),
                outsideZoneIpl = data.outsideZoneIpl,
                radius = data.radius or maxRadius,
                debug = false,
                onEnter = enableInterior,
                onExit = disableInterior
            })

            if (data.radius or maxRadius) > maxRadius then
                maxRadius = data.radius or maxRadius
            end
        end
    end
end)

CreateThread(function()
    Wait(100)
    local lastRadius = 0.0
    local nearbyTimer = 0
    while true do
        local speed = getPlayerSpeedMph()
        local wait = speed < 1.0 and 1000 or 300

        local s, e = pcall(function()
            nearbyTimer = nearbyTimer + wait
            if nearbyTimer >= 2000 then
                updateNearbyZones()
                nearbyTimer = 0
            end

            local radius = calculateRadius(speed)
            if math.abs(radius - lastRadius) > 0.5 then
                lastRadius = radius

                for _, zone in ipairs(nearbyZones) do
                    houses[zone.zoneName][zone.index].zone.radius = math.min(radius, zone.data.radius or maxRadius)
                end
            end
        end)

        if not s then
            print(('[prp-housing-loader] Error: %s'):format(e))
        end

        Wait(wait)
    end
end)

exports("EnableInterior", enableInterior)
exports("DisableInterior", disableInterior)
exports("GetIplsForCoords", getIplsForCoords)