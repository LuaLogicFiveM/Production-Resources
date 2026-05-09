local sv_utils = lib.require('utils.server')

RegisterNetEvent('lorp_chopshop:server:requestChoppedVehicle')
AddEventHandler('lorp_chopshop:server:requestChoppedVehicle', function()
    if GetInvokingResource() then return end
    local src = source
    local count = math.random(150, 350)

    sv_utils.addItem(src, 'black_money', count)
    exports['lorp_packed']:SendLog('Chop Shop', GetPlayerName(src).. ' has used the chop shop and made '..count..' dirty money.', '')
end)