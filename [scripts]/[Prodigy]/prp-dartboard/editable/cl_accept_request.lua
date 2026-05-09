lib.callback.register("prp-dartboard:client:acceptRequest", function(requestor)
    local alert = nil

    Citizen.CreateThreadNow(function()
        alert = bridge.fw.confirmDialog(locale("JOIN_REQUEST_LABEL"), locale("LOBBY_REQUESTED_PROMPT", requestor.playerName))
    end)

    local timeout = 0

    while true do
        Wait(100)
        if alert ~= nil then break end

        timeout = timeout + 1
        if timeout >= 60 then
            break
        end
    end

    local requestReturn = alert == "confirm"

    return requestReturn
end)
