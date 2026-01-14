---@diagnostic disable: undefined-global
-- esx function patch version 1.0.0

local GetInvokingResource <const> = GetInvokingResource
local GetResourceState <const> = GetResourceState
local tostring <const> = tostring

if not IsDuplicityVersion() then
    local NewDetection <const> = ReaperAC.API.NewDetection
    local IsExecutionValidRaw <const> = ReaperAC.API.IsExecutionValidRaw
    local GetInvokingResourceData <const> = ReaperAC.API.GetInvokingResourceData
    local AppendExtraEntityData <const> = ReaperAC.API.AppendExtraEntityData
    local AdvancedHook <const> = ReaperAC.API.AdvancedHook

    AdvancedHook("ESX.Game.SpawnVehicle", function(original_func, model, ...)
        local invoking_execution_data <const> = GetInvokingResourceData()

        if invoking_execution_data == nil then
            return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run ESX.Game.SpawnVehicle('%s') from es_extended"):format(tostring(model)) })
        end

        if invoking_execution_data.ran_from_cheat then
            return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run ESX.Game.SpawnVehicle('%s') from a cheat"):format(tostring(model)) })
        end

        if not IsExecutionValidRaw("ESX.Game.SpawnVehicle", tostring(model), invoking_execution_data.path, invoking_execution_data.extended_hash) then
            return warn("^3ESX.Game.SpawnVehicle^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
        end

        AppendExtraEntityData(invoking_execution_data)
        return original_func(model, ...) or true
    end)

    AdvancedHook("ESX.Game.SpawnObject", function(original_func, model, ...)
        local invoking_execution_data <const> = GetInvokingResourceData()

        if invoking_execution_data == nil then
            return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run ESX.Game.SpawnObject('%s') from es_extended"):format(tostring(model)) })
        end

        if invoking_execution_data.ran_from_cheat then
            return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run ESX.Game.SpawnObject('%s') from a cheat"):format(tostring(model)) })
        end

        if not IsExecutionValidRaw("ESX.Game.SpawnObject", tostring(model), invoking_execution_data.path, invoking_execution_data.extended_hash) then
            return warn("^3ESX.Game.SpawnObject^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
        end

        AppendExtraEntityData(invoking_execution_data)
        return original_func(model, ...)
    end)

    local flagged_events <const> = {
        ["esx:spawnVehicle"] = true
    }

    AdvancedHook("ESX.TriggerServerCallback", function (original_func, eventName, ...)
        local invoking_execution_data <const> = GetInvokingResourceData()

        if invoking_execution_data and invoking_execution_data.ran_from_cheat then
            return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run ESX.TriggerServerCallback('%s') from a cheat"):format(eventName) })
        end

        if flagged_events[eventName] then
            if invoking_execution_data == nil then
                return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run ESX.TriggerServerCallback('%s') from es_extended"):format(eventName) })
            end

            if not IsExecutionValidRaw("ESX.TriggerServerCallback", eventName, invoking_execution_data.path, invoking_execution_data.execution_id) then
                return warn("^3ESX.TriggerServerCallback^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
            end

            return original_func(eventName, ...)
        end

        return original_func(eventName, ...)
    end)

    AdvancedHook("ESX.SetPlayerData", function (original_func, key, value)
        local resource <const> = GetInvokingResource()
        local invoking_execution_data <const> = GetInvokingResourceData()

        if invoking_execution_data and invoking_execution_data.ran_from_cheat then
            return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run ESX.SetPlayerData('%s', '%s') from a cheat"):format(tostring(key), tostring(value)) })
        end

        local flagged_keys <const> = {
            ["job"] = "job"
        }

        if flagged_keys[key] and resource ~= nil then
            if invoking_execution_data == nil then
                return warn(("Attempting to run ESX.SetPlayerData without any invoking_execution_data. resource: %s"):format(resource))
            end

            if not IsExecutionValidRaw("ESX.SetPlayerData", ("%s', '%s"):format(key, value), invoking_execution_data.path, invoking_execution_data.execution_id) then
                return warn("^3ESX.SetPlayerData^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
            end
        end

        return original_func(key, value)
    end)
else
    local RegisterEventHook <const> = ReaperAC.API.RegisterEventHook
    local VerifyEventKeyLock <const> = ReaperAC.API.VerifyEventKeyLock
    local GetEventSource <const> = ReaperAC.API.GetEventSource
    local GetEventPath <const> = ReaperAC.API.GetEventPath
    local GetEventKey <const> = ReaperAC.API.GetEventKey

    if GetResourceState("wasabi_bridge") ~= "missing" then
        RegisterEventHook("esx:triggerServerCallback", function (eventName, ...)
            if eventName ~= "wasabi_bridge:registerShop" then
                return true
            end

            local event_invoker <const> = GetEventSource()
            local event_path <const> = GetEventPath()
            local event_key <const> = GetEventKey()

            return not VerifyEventKeyLock("wasabi_bridge:registerShop", event_key, event_path, event_invoker)
        end)
    end
end