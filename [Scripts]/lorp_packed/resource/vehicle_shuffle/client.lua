local r_handcuffs = exports.r_handcuffs
local mst_seatbelt = exports['mst_seatbelt']

local function disableAutoShuffle(seatIndex)
    SetPedConfigFlag(cache.ped, 184, true)

    if cache.vehicle and not cache.seat then
        SetPedIntoVehicle(cache.ped, cache.vehicle, seatIndex)
    end
end

lib.onCache('seat', disableAutoShuffle)

local function shuffleSeat(self)
    if r_handcuffs:IsPlayerCuffed(cache.serverId) then
        return lib.notify({title = 'Vehicle', description = 'You are unable to do this while handcuffed', type = 'error', position = 'top'})
    end

    if mst_seatbelt:HasSeatbelt() then
        return lib.notify({title = 'Vehicle', description = 'You are unable to do this with your seatbelt enabled', type = 'error', position = 'top'})
    end

    self:disable(true)

    if cache.vehicle and cache.seat then
        TaskShuffleToNextVehicleSeat(cache.ped, cache.vehicle)
        repeat Wait(0)
        until not GetIsTaskActive(cache.ped, 165)
    end

    self:disable(false)
end

lib.addKeybind({
    name = 'shuffleSeat',
    description = '[Vehicle] - Shuffle Seat',
    defaultKey = 'O',
    onPressed = shuffleSeat
})