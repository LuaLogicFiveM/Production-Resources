local sv_utils = require 'utils.server'

RegisterNetEvent('lorp_packed:server:requestTransaction', function(type, amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    if (amount == nil or amount <= 0 or (type == 'withdraw' and amount > xPlayer.getAccount('bank').money) or (type == 'deposit' and amount > xPlayer.getAccount('money').money)) then
        return lib.notify(src, {title = 'Bank', description = 'You entered an invalid amount', type = 'error', position = 'top'})
    end

    sv_utils.bankTransaction(src, amount, type)
    SendLog('__**Banking Logs**__', '### Name: '..GetPlayerName(src)..'\n ### Type: ' ..type..'\n ### Amount: ' ..amount, 'https://discord.com/api/webhooks/1425928725933064223/xInnU_DpBrpBmdavG6wg_Z1lSbGIN-ZZXM5Uq31Mv_ayIth5Tw_tRs2s_SADaWMOAaHv')
    lib.notify(src, {title = 'Bank', description = 'You '..type..'ed $'..amount, type = 'success', position = 'top'})
end)