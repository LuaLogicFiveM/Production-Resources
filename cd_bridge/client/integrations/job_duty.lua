function GetCustomJobDuty()
    if GetResourceState('origen_police') == 'started' then
        return exports['origen_police']:IsOnDuty()
    end

    return nil
end