---@diagnostic disable: undefined-global

local Wait <const> = Wait
local IsDuplicityVersion <const> = IsDuplicityVersion

if not IsDuplicityVersion() then
    local NewDetection <const> = ReaperAC.API.NewDetection
    local IsExecutionValid <const> = ReaperAC.API.IsExecutionValid
    local IsExecutedFromCheat <const> = ReaperAC.API.IsExecutedFromCheat
    local AdvancedHook <const> = ReaperAC.API.AdvancedHook

    print("Loading lb-phone patch version 1.0.0")

    AdvancedHook("CreateFrameworkVehicle", function(original_func, vehicleData, ...)
        print("Verifying CreateFrameworkVehicle")

        if IsExecutedFromCheat() then
            return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run _G.CreateFrameworkVehicle('%s') from a cheat"):format(tostring(vehicleData.hash)) })
        end

        if not IsExecutionValid("CreateFrameworkVehicle", tostring(vehicleData.hash), 4) then
            return warn("^3CreateFrameworkVehicle^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
        end

        return original_func(vehicleData, ...)
    end)
end