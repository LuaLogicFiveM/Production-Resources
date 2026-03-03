if Config.standaloneSettings.enabled then
    
    RegisterCommand('jackvehicle', function(source)
        TriggerClientEvent('kq_drifttires:client:useJackstand', source)
    end)
    
    
    if not Config.advancedMode or Config.debug then
        RegisterCommand('getdrifttire', function(source)
            TriggerClientEvent('kq_drifttires:client:takeOutTire', source, 1)
        end)
    
        RegisterCommand('getregulartire', function(source)
            TriggerClientEvent('kq_drifttires:client:takeOutTire', source, 0)
        end)
    end

    function RemovePlayerItem()
        return true
    end

    function AddPlayerItem()
        return true
    end

    function CanAfford()
        return true
    end

    function AddMoney()
        return true
    end

    function DoesPlayerHaveItem()
        return true
    end
end
