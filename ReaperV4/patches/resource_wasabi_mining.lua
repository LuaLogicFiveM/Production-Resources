---@diagnostic disable: undefined-global
-- wasabi_mining function patch version 1.0.0

if not IsDuplicityVersion() then
    local IsExecutionValid <const> = ReaperAC.API.IsExecutionValid

    CreateThread(function ()
        while tryMine == nil or miningSellItems == nil do
            Wait(1000)
        end

        local org_tryMine <const> = tryMine
        local org_miningSellItems <const> = miningSellItems

        tryMine = function (...)
            if not IsExecutionValid("tryMine", "", 4) then
                return warn("^3tryMine^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
            end

            return org_tryMine(...)
        end

        miningSellItems = function (...)
            if not IsExecutionValid("org_miningSellItems", "", 4) then
                return warn("^3miningSellItems^7 was blocked from running due to it not being whitelisted. Check the server console for more details.")
            end

            return org_miningSellItems(...)
        end
    end)
end