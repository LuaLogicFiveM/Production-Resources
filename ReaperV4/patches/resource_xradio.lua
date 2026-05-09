---@diagnostic disable: undefined-global
-- xradio function patch version 1.0.0

local Wait <const> = Wait
local IsDuplicityVersion <const> = IsDuplicityVersion
local CreateThread <const> = CreateThread

if not IsDuplicityVersion() then
    local NewDetection <const> = ReaperAC.API.NewDetection
    local IsExecutionValid <const> = ReaperAC.API.IsExecutionValid
    local IsExecutedFromCheat <const> = ReaperAC.API.IsExecutedFromCheat

    CreateThread(function ()
        while _G.CreateRadioObject == nil do
            Wait(1000)
        end

        local CreateRadioObject <const> = _G.CreateRadioObject

        _G.CreateRadioObject = function (model_hash, ...)
            if IsExecutedFromCheat() then
                return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run _G.CreateRadioObject('%s') from a cheat"):format(tostring(model_hash)) })
            end

            if not IsExecutionValid("CreateRadioObject", tostring(model_hash), 4) then
                return warn("^3CreateRadioObject^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
            end

            return CreateRadioObject(model_hash, ...)
        end
    end)
end