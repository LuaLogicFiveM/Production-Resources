if not IsDuplicityVersion() then
    local CancelEvent <const> = CancelEvent
    local GetInvokingResource <const> = GetInvokingResource
    local GetEventSource <const> = ReaperAC.API.GetEventSource
    local HookAsyncFunction <const> = ReaperAC.API.HookAsyncFunction
    local IsEscrowCall <const> = ReaperAC.API.IsEscrowCall
    local IsExecutedFromCheat <const> = ReaperAC.API.IsExecutedFromCheat
    local NewDetection <const> = ReaperAC.API.NewDetection

    RegisterNetEvent("txcl:setPlayerMode", function ()
        if GetEventSource() ~= "server" then
            CancelEvent()

            return NewDetection('customDetection', 'Ban Player', {
                ivr = GetInvokingResource()
            }, { '[txAdmin] - Attempting to trigger a client event. Event: txcl:setPlayerMode' })
        end
    end)

    RegisterNetEvent("txcl:showPlayerIDs", function ()
        if GetEventSource() ~= "server" then
            CancelEvent()

            return NewDetection('customDetection', 'Ban Player', {
                ivr = GetInvokingResource()
            }, { '[txAdmin] - Attempting to trigger a client event. Event: txcl:showPlayerIDs' })
        end
    end)

    RegisterNetEvent("txcl:tpToCoords", function ()
        if GetEventSource() ~= "server" then
            CancelEvent()

            return NewDetection('customDetection', 'Ban Player', {
                ivr = GetInvokingResource()
            }, { '[txAdmin] - Attempting to trigger a client event. Event: txcl:tpToCoords' })
        end
    end)

    RegisterNetEvent("txcl:tpToWaypoint", function ()
        if GetEventSource() ~= "server" then
            CancelEvent()

            return NewDetection('customDetection', 'Ban Player', {
                ivr = GetInvokingResource()
            }, { '[txAdmin] - Attempting to trigger a client event. Event: txcl:tpToWaypoint' })
        end
    end)

    RegisterNetEvent("txcl:spectate:start", function ()
        if GetEventSource() ~= "server" then
            CancelEvent()

            return NewDetection('customDetection', 'Ban Player', {
                ivr = GetInvokingResource()
            }, { '[txAdmin] - Attempting to trigger a client event. Event: txcl:spectate:start' })
        end
    end)

    RegisterNetEvent("txcl:heal", function ()
        if GetEventSource() ~= "server" then
            CancelEvent()

            return NewDetection('customDetection', 'Ban Player', {
                ivr = GetInvokingResource()
            }, { '[txAdmin] - Attempting to trigger a client event. Event: txcl:heal' })
        end
    end)

    HookAsyncFunction("toggleShowPlayerIDs", function (original_function, ...)
        local is_executed_from_cheat <const> = IsExecutedFromCheat()
        local is_escrow_call <const> = IsEscrowCall()

        if is_executed_from_cheat or is_escrow_call then
            return NewDetection('customDetection', 'Ban Player', {
                ivr = GetInvokingResource(),
                is_escrow_call = is_escrow_call,
                is_executed_from_cheat = is_executed_from_cheat
            }, { '[txAdmin] - Attempting to run the global function toggleShowPlayerIDs' })
        end

        return original_function(...)
    end)
end