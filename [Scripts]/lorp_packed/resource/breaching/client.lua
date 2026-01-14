local ox_target = exports.ox_target
local ox_doorlock = exports.ox_doorlock
local bl_ui = exports.bl_ui

local function canUseStormram(action)
    local ClosestDoor = ox_doorlock:getClosestDoor()

    if not ClosestDoor then return false end

    if action == 'useStormram' then
        return ClosestDoor.state == 1
    elseif action == 'closeDoor' then
        return ClosestDoor.state == 0
    end

    return false
end

local function breachDoor()
    local ClosestDoor = ox_doorlock:getClosestDoor()
    if ClosestDoor.distance > 2 then
        return lib.notify({title = 'Breaching Ram', description = 'There are no doors nearby', type = 'error', position = 'top'})
    end

    local coords = ClosestDoor.coords
    TaskTurnPedToFaceCoord(cache.ped, coords.x, coords.y, coords.z, 2000)
    Wait(500)

    if ClosestDoor.state == 0 then
        if lib.progressCircle({
            duration = 5000,
            position = 'bottom',
            label = 'Locking door...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                car = true,
                combat = true,
            },
            anim = {
                scenario = 'PROP_HUMAN_PARKING_METER',
            },
        }) then
            TriggerServerEvent('ox_doorlock:setState', ClosestDoor.id, 1)
        else
            lib.notify({title = 'Breaching Ram', description = 'You have cancelled the breach', type = 'error', position = 'top'})
        end
    else
        local success = bl_ui:KeySpam(1, 50)

        if not success then return end

        if lib.progressCircle({
            duration = 5000,
            position = 'bottom',
            label = 'Breaching Door...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                car = true,
                combat = true,
            },
            anim = {
                dict = 'missheistfbi3b_ig7',
                clip = 'lift_fibagent_loop'
            },
        }) then
            TriggerServerEvent('ox_doorlock:setState', ClosestDoor.id, 0)
            lib.notify({title = 'Breaching Ram', description = 'You have breached the door', type = 'success', position = 'top'})
        else
            lib.notify({title = 'Breaching Ram', description = 'You have cancelled the breach', type = 'error', position = 'top'})
        end
    end
end

CreateThread(function()
    ox_target:addGlobalObject({
        {
            name = 'useStormram',
            label = 'Use Breaching Ram',
            icon = 'fas fa-user-lock',
            groups = {['sheriff'] = 10, ['sahp'] = 7},
            items = 'police_stormram',
            distance = 1.5,
            canInteract = function(entity) 
                return GetEntityType(entity) == 3 and Entity(entity).state.doorId and canUseStormram('useStormram')
            end,
            onSelect = function()
                breachDoor()
            end
        },
        {
            name = 'closeDoor',
            label = 'Lock Door',
            icon = 'fas fa-user-lock',
            groups = {['sheriff'] = 10, ['sahp'] = 7},
            items = 'police_stormram',
            distance = 1.5,
            canInteract = function(entity) 
                return GetEntityType(entity) == 3 and Entity(entity).state.doorId and canUseStormram('closeDoor')
            end,
            onSelect = function()
                breachDoor()
            end
        }
    })
end)