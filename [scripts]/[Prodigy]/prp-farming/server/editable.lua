--- gets players open world farming rep
---@param source number
---@return number
---@return number
function GetPlayerReputation(source)
    local xp = 0
    local level = 0

    -- add custom logic here for your own rep system

    return level, xp
end

--- adds player open world farming rep
---@param source number
---@param amount number
function AddPlayerRep(source, amount)
    -- add custom logic here for your own rep system
end

--- create vehicle for farming
---@param model number
---@param coords vector4
---@return table | nil
function SpawnVehicle(model, coords)
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, true, false)
    local timeout = 0
    while not DoesEntityExist(vehicle) and timeout < 50 do
        timeout = timeout + 0
        Citizen.Wait(0)
    end

    if timeout >= 50 then
        return
    end

    timeout = 0

    while NetworkGetEntityOwner(vehicle) == -1 and timeout < 15 do
        timeout = timeout + 1
        Citizen.Wait(100)
    end

    if timeout >= 15 then
        RemoveVehicle(vehicle)
        return
    end

    return { veh = vehicle, plate = GetVehicleNumberPlateText(vehicle) }
end

--- removes vehicle from farming
---@param entity number
function RemoveVehicle(entity)
    DeleteEntity(entity)
end

--- get additional farming job payout bonuses on finish (e.g. rep levels?)
---@param source number
---@return number
function GetFarmingJobPayoutBonus(source)
    -- custom logic here for bonus
    return 0
end
