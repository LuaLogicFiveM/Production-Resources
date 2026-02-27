-- ┌──────────────────────────────────────────────────────────────────┐
-- │                           START EVENTS                           │
-- └──────────────────────────────────────────────────────────────────┘

local function HandleBridgeStart()
    TriggerServerEvent('cd_dispatch:PlayerLoaded')
end

AddEventHandler('cd_bridge:TriggerStartEvents', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    HandleBridgeStart()
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    HandleBridgeStart()
end)

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                            JOB CHANGED                           │
-- └──────────────────────────────────────────────────────────────────┘

RegisterNetEvent('cd_bridge:OnJobChanged', function(data)
    if not data or not data.old or not data.new then return end

    local oldName = data.old.name
    local newName = data.new.name

    local hadDispatchAccess = oldName and GetMultiJob(oldName) or false
    local hasDispatchAccess = newName and GetMultiJob(newName) or false

    if hadDispatchAccess and not hasDispatchAccess then
        TriggerServerEvent('cd_dispatch:UnloadPlayer')
        return
    end

    if not hasDispatchAccess then return end

    if data.job_changed or data.duty_changed then
        if data.new.on_duty then
            TriggerServerEvent('cd_dispatch:PlayerLoaded')
        else
            TriggerServerEvent('cd_dispatch:UnloadPlayer')
        end
    end
end)

RegisterNetEvent('cd_bridge:OnDutyChanged', function(data)
    if not data or not data.old or not data.new then return end
    if not data.duty_changed then return end

    local jobName = data.new.name
    local hasDispatchAccess = jobName and GetMultiJob(jobName) or false
    if not hasDispatchAccess then return end

    if data.new.on_duty then
        TriggerServerEvent('cd_dispatch:PlayerLoaded')
    else
        TriggerServerEvent('cd_dispatch:UnloadPlayer')
    end
end)

RegisterNetEvent('cd_bridge:OnGangChanged', function(data)
end)