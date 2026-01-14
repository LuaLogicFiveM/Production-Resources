---@diagnostic disable: undefined-global

local IsExecutionValid <const> = ReaperAC.API.IsExecutionValid

if not IsDuplicityVersion() then
    CreateThread(function ()
        while tryMine == nil or miningSellItems == nil do
            Wait(1000)
            print("Waiting for exploitable functions to exist and fully init")
        end

        local org_tryMine <const> = tryMine
        local org_miningSellItems <const> = miningSellItems

        tryMine = function (...)
            if not IsExecutionValid("tryMine", "", 4) then
                return
            end

            return org_tryMine(...)
        end

        miningSellItems = function (...)
            if not IsExecutionValid("org_miningSellItems", "", 4) then
                return
            end

            return org_miningSellItems(...)
        end
    end)
end