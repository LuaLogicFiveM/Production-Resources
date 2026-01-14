Editable = {}

local function isStarted(resourceName)
    return GetResourceState(resourceName) == 'started'
end

---Used to check if player is dead
---@param ped number
function Editable.isDead(ped)
    return IsEntityDead(ped)
        or IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3)
end

function Editable.hackingMinigame(minigame)
    local success = lib.skillCheck({'easy', 'easy', {areaSize = 90, speedMultiplier = 2}, 'easy'}, {'w', 'a', 's', 'd'})
    return success
end

function Editable.lockpickMinigame(minigame)
    local success = lib.skillCheck({'easy', 'easy', {areaSize = 90, speedMultiplier = 2}, 'easy'}, {'w', 'a', 's', 'd'})
    return success
end

function Editable.setVehicleLockState(entity, state)
    SetVehicleDoorsLockedForAllPlayers(entity, state)
end

function Editable.addKeys(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)


end

function Editable.hideActiveWeapon()
    RemoveAllPedWeapons(cache.ped, false)
end

---@param name string
function Editable.openStash(name)
    if Editable.isDead(cache.ped) then
        return
    end

    if isStarted('ox_inventory') then
        exports.ox_inventory:openInventory('stash', name)
    elseif isStarted('qb-inventory')
        or isStarted('qs-inventory')
        or isStarted('ps-inventory')
        or isStarted('lj-inventory') then
        local data = Config.stash
        local name = data.shared and name or (name .. '_' .. Framework.getIdentifier())

        TriggerServerEvent('inventory:server:OpenInventory', 'stash', name, {
            label = Config.stash.label,
            maxweight = Config.stash.maxWeight,
            slots = Config.stash.slots
        })
        TriggerEvent("inventory:client:SetCurrentStash", name)
    else
        warn('Your inventory script doesn\t support stashes. ')
    end
end