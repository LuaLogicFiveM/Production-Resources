---@diagnostic disable: undefined-global

local IsDuplicityVersion <const> = IsDuplicityVersion
local IsExecutionValid <const> = ReaperAC.API.IsExecutionValid
local AdvancedHook <const> = ReaperAC.API.AdvancedHook

if not IsDuplicityVersion() then
    AdvancedHook("SelectJobMenu", function(original_func, ...)
        if not IsExecutionValid("SelectJobMenu", "", 4) then
            return
        end

        return original_func(...)
    end)
end