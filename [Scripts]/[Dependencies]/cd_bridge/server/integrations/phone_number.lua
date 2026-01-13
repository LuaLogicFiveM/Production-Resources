function GetPhoneNumber(source)
    if Cfg.Phone == 'gcphone' then
        return exports.gcphone:getPhoneNumber(source)

    elseif Cfg.Phone == 'lb-phone' then
        return exports['lb-phone']:GetEquippedPhoneNumber(source)

    elseif Cfg.Phone == 'npwd' then
        local Player = GetPlayer(source)
        if not Player then return end
        return Player.PlayerData.charinfo.phone

    elseif Cfg.Phone == 'okokPhone' then
        return exports.okokPhone:getPhoneNumberFromSource(source)

    elseif Cfg.Phone == 'qb-phone' then
        local Player = GetPlayer(source)
        if not Player then return end
        return Player.PlayerData.charinfo.phone

    elseif Cfg.Phone == 'esx' then
        local identifier = GetIdentifier(source)
        local Result = DatabaseQuery('SELECT phone_number FROM users WHERE identifier="'..identifier..'"')
        if Result and Result[1] and Result[1].phone_number then
            return Result[1].phone_number
        end
    end
end