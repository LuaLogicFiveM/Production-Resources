function GetCustomGang(source)
    if GetResourceState('rcore_gangs') == 'started' then
        local gang = exports['rcore_gangs']:GetPlayerGang(source)
        if not gang then return nil end

        local name = type(gang.name) == 'string' and gang.name:lower() or nil

        local label
        if type(gang.tag) == 'string' and gang.tag ~= '' then
            label = gang.tag:sub(1, 1):upper() .. gang.tag:sub(2):lower()
        end

        return {
            name  = name,
            label = label,
            grade = tonumber(gang.rank)
        }
    end
end
