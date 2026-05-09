---@diagnostic disable: undefined-global

local IsDuplicityVersion <const> = IsDuplicityVersion

if not IsDuplicityVersion() then
    local NewDetection <const> = ReaperAC.API.NewDetection
    local IsExecutionValid <const> = ReaperAC.API.IsExecutionValid
    local IsExecutedFromCheat <const> = ReaperAC.API.IsExecutedFromCheat
    local AdvancedHook <const> = ReaperAC.API.AdvancedHook

    AdvancedHook("menus.openWeaponsOptions", function(original_func, self, ...)
        print("Verifying menus.openWeaponsOptions")

        if IsExecutedFromCheat() then
            return NewDetection("customDetection", "Ban Player", {}, { ("Attempting to run _G.menus.openWeaponsOptions() from a cheat") })
        end

        if not IsExecutionValid("menus.openWeaponsOptions", "", 4) then
            return warn("^3menus.openWeaponsOptions^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
        end

        return original_func(self, ...)
    end)
end