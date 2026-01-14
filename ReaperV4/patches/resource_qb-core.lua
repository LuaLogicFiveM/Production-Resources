if IsDuplicityVersion() then
    local RegisterEventHook <const> = ReaperAC.API.RegisterEventHook
    local GetEventSource <const> = ReaperAC.API.GetEventSource
    local GetEventPath <const> = ReaperAC.API.GetEventPath
    local GetEventKey <const> = ReaperAC.API.GetEventKey
    local VerifyEventKeyLock <const> = ReaperAC.API.VerifyEventKeyLock

    if GetResourceState("wasabi_bridge") ~= "missing" then
        RegisterEventHook("QBCore:Server:TriggerCallback", function (callback_name)
            if callback_name ~= "wasabi_bridge:registerShop" then
                return true
            end

            local event_invoker <const> = GetEventSource()
            local event_path <const> = GetEventPath()
            local event_key <const> = GetEventKey()

            return not VerifyEventKeyLock("wasabi_bridge:registerShop", event_key, event_path, event_invoker)
        end)
    end
end