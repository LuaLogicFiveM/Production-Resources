---@diagnostic disable: undefined-global
-- drc_uwucafe function patch version 1.0.0

local Wait <const> = Wait
local IsDuplicityVersion <const> = IsDuplicityVersion
local CreateThread <const> = CreateThread

if not IsDuplicityVersion() then
    local NewDetection <const> = ReaperAC.API.NewDetection
    local IsExecutionValid <const> = ReaperAC.API.IsExecutionValid
    local IsExecutedFromCheat <const> = ReaperAC.API.IsExecutedFromCheat

    print("Loading drc_uwucafe patch version 1.0.0")

    CreateThread(function ()
        while _G.SpawnVehicle == nil do
            Wait(1000)
        end

        local SpawnVehicle <const> = _G.SpawnVehicle

        _G.SpawnVehicle = function (vehicleData, ...)
            print("Verifying SpawnVehicle")

            if IsExecutedFromCheat() then
                return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run _G.SpawnVehicle('%s') from a cheat"):format(tostring(vehicleData.vehicle.model)) })
            end

            if not IsExecutionValid("SpawnVehicle", tostring(vehicleData.vehicle.model), 4) then
                return warn("^3SpawnVehicle^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
            end

            return SpawnVehicle(vehicleData, ...)
        end
    end)
end