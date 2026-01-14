---@diagnostic disable: undefined-global

local Wait <const> = Wait
local IsDuplicityVersion <const> = IsDuplicityVersion
local CreateThread <const> = CreateThread

if not IsDuplicityVersion() then
    local NewDetection <const> = ReaperAC.API.NewDetection
    local IsExecutionValid <const> = ReaperAC.API.IsExecutionValid
    local IsExecutedFromCheat <const> = ReaperAC.API.IsExecutedFromCheat

    print("Loading xradio patch version 1.0.0")

    CreateThread(function ()
        while _G.CreateRadioObject == nil do
            Wait(1000)
            print("Waiting for _G.CreateRadioObject to exist and fully init")
        end

        local CreateRadioObject <const> = _G.CreateRadioObject

        _G.CreateRadioObject = function (model_hash, ...)
            print("Verifying CreateRadioObject")

            if IsExecutedFromCheat() then
                return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run _G.CreateRadioObject('%s') from a cheat"):format(tostring(model_hash)) })
            end

            if not IsExecutionValid("CreateRadioObject", tostring(model_hash), 4) then
                return warn("^SCreateRadioObject^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
            end

            return CreateRadioObject(model_hash, ...)
        end
    end)
end