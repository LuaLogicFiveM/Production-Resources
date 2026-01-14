---@diagnostic disable: undefined-global
-- wasabi_bridge function patch version 1.0.0

local json_encode <const> = json.encode
local IsExecutionValid <const> = ReaperAC.API.IsExecutionValid
local RegisterEventHook <const> = ReaperAC.API.RegisterEventHook
local GetEventSource <const> = ReaperAC.API.GetEventSource
local GetEventPath <const> = ReaperAC.API.GetEventPath
local GetEventKey <const> = ReaperAC.API.GetEventKey
local VerifyEventKeyLock <const> = ReaperAC.API.VerifyEventKeyLock

if not IsDuplicityVersion() then
    print("Loading wasabi_bridge patch version 1.0.0")

    CreateThread(function ()
        while WSB == nil or WSB.inventory == nil or WSB.inventory.openShop == nil do
            Wait(1000)
            print("Waiting for WSB to exist and fully init")
        end

        local inventory_openShop <const> = WSB.inventory.openShop

        WSB.inventory.openShop = function (data)
            if not IsExecutionValid("WSB.inventory.openShop", json_encode(data), 4) then
                return warn(("^3%s^7 was blocked from running due to it not being whitelisted. Check the server console for more details."):format("WSB.inventory.openShop"))
            end

            return inventory_openShop(data)
        end
    end)
else
    RegisterEventHook("wasabi_bridge:registerShop", function (data)
        local event_invoker <const> = GetEventSource()
        local event_path <const> = GetEventPath()
        local event_key <const> = GetEventKey()

        return not VerifyEventKeyLock("wasabi_bridge:registerShop", event_key, event_path, event_invoker)
    end)
end