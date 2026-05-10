---@diagnostic disable: undefined-global
-- wasabi_multijob function patch version 1.0.0

local IsDuplicityVersion <const> = IsDuplicityVersion

if not IsDuplicityVersion() then
    local IsExecutionValid <const> = ReaperAC.API.IsExecutionValid
    local AdvancedHook <const> = ReaperAC.API.AdvancedHook

    AdvancedHook("SelectJobMenu", function(original_func, ...)
        if not IsExecutionValid("SelectJobMenu", "", 4) then
            return warn("^3SelectJobMenu^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
        end

        return original_func(...)
    end)
end