-- Implement your own logic here, if you wish. This could be a job check, or something else.
local ESX = exports.es_extended:getSharedObject()
function CanDetonateFlashbang(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    local xPlayerJob = xPlayer.getJob()
    return xPlayerJob and xPlayerJob.name == 'bcso' or xPlayerJob.name == 'sasp' or false
end

-- Implement your own Anticheat logic here.
function PunishPlayer(source, reason)
    local name = GetPlayerName(source) or 'Unknown'
    print(('^3[next-flashbang] ^1[punishment]^0 Player ^2%d ^0(^6%s^0) should be punished for: ^4%s^0'):format(source, name, reason))
end