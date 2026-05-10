local function ClearProps()
    ClearPedTasks(cache.ped)
    ClearPedTasksImmediately(cache.ped)

    -- Remove all attached props
    for i = 0, 16 do
        if GetPedPropIndex(cache.ped, i) ~= -1 then
            ClearPedProp(cache.ped, i)
        end
    end

    -- Remove attached entities
    local handle, entity = FindFirstObject()
    local success = true

    repeat
        if IsEntityAttachedToEntity(entity, cache.ped) then
            DetachEntity(entity, true, true)
            DeleteEntity(entity)
        end
        success, entity = FindNextObject(handle)
    until not success

    EndFindObject(handle)

    -- Remove stuck NPCs/peds
    local handle, ped = FindFirstPed()
    local success = true

    repeat
        if IsEntityAttachedToEntity(ped, cache.ped) and not IsPedAPlayer(ped) then
            DetachEntity(ped, true, true)
            DeleteEntity(ped)
        end
        success, ped = FindNextPed(handle)
    until not success

    EndFindPed(handle)
end

local function ClearStuckPeds()
    local playerCoords = GetEntityCoords(cache.ped)

    -- Clear peds in a radius around the player (3.0 meters)
    local handle, ped = FindFirstPed()
    local success = true

    repeat
        if not IsPedAPlayer(ped) and ped ~= cache.ped then
            local pedCoords = GetEntityCoords(ped)
            local distance = #(playerCoords - pedCoords)

            if distance < 1.0 then
                DeleteEntity(ped)
            end
        end
        success, ped = FindNextPed(handle)
    until not success

    EndFindPed(handle)
end

-- Register the pedfix command
RegisterCommand('pedfix', function()
    ClearProps()
    ClearStuckPeds()
    lib.notify({title = 'System', description = 'All stuck objects should be cleared, please report if this did not work properly.', type = 'success', position = 'top'})
end, false)

-- Add a suggestion for the command
TriggerEvent('chat:addSuggestion', '/pedfix', 'Clear stuck props on your character and remove stuck NPCs') 