function GetCustomGang()
    if GetResourceState('rcore_gangs') ~= 'started' then
        return nil
    end

    local ok, gang = pcall(function()
        return exports['rcore_gangs']:GetPlayerGang()
    end)

    if not ok or type(gang) ~= 'table' then
        return nil
    end

    local name = type(gang.name) == 'string' and gang.name:lower() or nil

    local label = nil
    if type(gang.tag) == 'string' and gang.tag ~= '' then
        label = gang.tag:sub(1, 1):upper() .. gang.tag:sub(2):lower()
    end

    local grade = tonumber(gang.rank)

    return {
        name  = name,
        label = label,
        grade = grade
    }
end
