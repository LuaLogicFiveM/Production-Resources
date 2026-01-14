---@diagnostic disable: undefined-global

local Wait <const> = Wait
local IsDuplicityVersion <const> = IsDuplicityVersion
local CreateThread <const> = CreateThread

if not IsDuplicityVersion() then
    local NewDetection <const> = ReaperAC.API.NewDetection
    local IsExecutionValid <const> = ReaperAC.API.IsExecutionValid
    local IsExecutedFromCheat <const> = ReaperAC.API.IsExecutedFromCheat

    print("Loading pickle_rental patch version 1.0.0")

    CreateThread(function ()
        while _G.CreateVeh == nil or _G.CreateNPC == nil or _G.CreateProp == nil do
            Wait(1000)
            print("Waiting for _G.CreateVeh, _G.CreateNPC & _G.CreateProp to exist and fully init")
        end

        local CreateVeh <const> = _G.CreateVeh
        local CreateNPC <const> = _G.CreateNPC
        local CreateProp <const> = _G.CreateProp

        _G.CreateVeh = function (model_hash, ...)
            print("Verifying CreateVeh")

            if IsExecutedFromCheat() then
                return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run _G.CreateVeh('%s') from a cheat"):format(tostring(model_hash)) })
            end

            if not IsExecutionValid("CreateVeh", tostring(model_hash), 4) then
                return warn("^SCreateVeh^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
            end

            return CreateVeh(model_hash, ...)
        end

        _G.CreateNPC = function (model_hash, ...)
            print("Verifying CreateNPC")

            if IsExecutedFromCheat() then
                return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run _G.CreateNPC('%s') from a cheat"):format(tostring(model_hash)) })
            end

            if not IsExecutionValid("CreateNPC", tostring(model_hash), 4) then
                return warn("^SCreateNPC^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
            end

            return CreateNPC(model_hash, ...)
        end

        _G.CreateProp = function (model_hash, ...)
            print("Verifying CreateProp")

            if IsExecutedFromCheat() then
                return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run _G.CreateProp('%s') from a cheat"):format(tostring(model_hash)) })
            end

            if not IsExecutionValid("CreateProp", tostring(model_hash), 4) then
                return warn("^SCreateProp^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
            end

            return CreateProp(model_hash, ...)
        end
    end)
end