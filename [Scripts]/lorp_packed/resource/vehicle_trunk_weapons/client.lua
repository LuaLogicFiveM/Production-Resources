local lorp_packed = exports.lorp_packed

local function checkTrunk()
    if cache.vehicle or lorp_packed:hasBackpack() then return end

    local coords = GetEntityCoords(cache.ped)
    local vehicle = lib.getClosestVehicle(coords, 5.0, true)

    if not vehicle then
        TriggerEvent('ox_inventory:disarm', true)
        return lib.notify({ title = 'Weapon System', description = 'There is no vehicle nearby to pull this out from', type = 'error', position = 'top' })
    end

    local trunk = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
    local distanceToTrunk = #(coords - trunk)

    if distanceToTrunk > 2 then
        TriggerEvent('ox_inventory:disarm', true)
        lib.notify({ title = 'Weapon System', description = 'You have to equip this weapon from a trunk', type = 'error', position = 'top' })
    end
end

AddEventHandler('ox_inventory:usedItem', function(name, slotId, metadata)
    if name:sub(0, 7) == 'WEAPON_' and GetWeapontypeGroup(GetHashKey(name)) == 970310034 then
        checkTrunk()
    end
end)