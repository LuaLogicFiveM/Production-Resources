---@diagnostic disable: undefined-global
-- drc_gardener function patch version 1.0.0

local Wait <const> = Wait
local IsDuplicityVersion <const> = IsDuplicityVersion

if not IsDuplicityVersion() then
    local NewDetection <const> = ReaperAC.API.NewDetection
    local IsExecutionValid <const> = ReaperAC.API.IsExecutionValid
    local IsExecutedFromCheat <const> = ReaperAC.API.IsExecutedFromCheat
    local AdvancedHook <const> = ReaperAC.API.AdvancedHook

    AdvancedHook("SpawnVehicleAndWarpPlayer", function(original_func, veh_model, ...)
        if IsExecutedFromCheat() then
            return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run _G.SpawnVehicleAndWarpPlayer('%s') from a cheat"):format(tostring(veh_model)) })
        end

        if not IsExecutionValid("SpawnVehicleAndWarpPlayer", tostring(veh_model), 4) then
            return warn("^3SpawnVehicleAndWarpPlayer^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
        end

        return original_func(vehicleData, ...)
    end)

    AdvancedHook("givekeys", function(original_func, veh_model, ...)
        if IsExecutedFromCheat() then
            return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run _G.givekeys('%s') from a cheat"):format(tostring(veh_model)) })
        end

        if not IsExecutionValid("givekeys", tostring(veh_model), 4) then
            return warn("^3givekeys^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
        end

        return original_func(vehicleData, ...)
    end)
end
