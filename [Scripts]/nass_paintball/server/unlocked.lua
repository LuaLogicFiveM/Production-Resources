function lobbyStarted(source)
    --Function called when lobby started
    
end

function lobbyFinished(source)
    --Function called when lobby finished

end

-- Config.checkPermFunction MUST be set to true
function permCheck(source)
    if not Config.checkPermFunction then return true end
    -- Add your permssion check here for creating a lobby.
    return false
end

function removeMoney(source, amount)
    nass.removeMoney(source, amount)
end

--This was added by request.
--This function is called when the players are paid out. This could be used for adding money to a society.
function payOut(amount)
    local partialAmount = amount * 0.3 --This is 30% of the total amount wagered.
end

--Would not use. Breaks script
if Config.leaveLobby.enabled then
    RegisterCommand(Config.leaveLobby.commandName,function(source)
        playerLeft(source, true)
    end)
end

nass.versionCheck(GetCurrentResourceName())