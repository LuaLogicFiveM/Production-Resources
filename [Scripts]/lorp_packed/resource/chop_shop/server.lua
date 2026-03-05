local sv_utils = lib.require('utils.server')

RegisterNetEvent('lorp_chopshop:server:requestChoppedVehicle')
AddEventHandler('lorp_chopshop:server:requestChoppedVehicle', function()
    if GetInvokingResource() then return end
    local src = source
    local count = math.random(150, 350)

    sv_utils.addItem(src, 'black_money', count)
    exports['lorp_packed']:SendLog('Chop Shop', GetPlayerName(src).. ' has used the chop shop and made '..count..' dirty money.', 'https://discord.com/api/webhooks/1231453425246670939/BZFl46RzLIpbe-Ec6Tq3W2NExaLIqy_l05_x3-bH6F_fq07f08H60qTt9juVvs4x9g-E')
end)