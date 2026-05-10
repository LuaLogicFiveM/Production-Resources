local lorp_discord_api = exports.lorp_discord_api

lib.addCommand('engines', {
    help = 'Open\'s a menu to view engine sounds',
    params = {},
    restricted = false
}, function(source, args, raw)
    TriggerClientEvent("lorp_packed:server:requestSoundMenu", source)
end)

local paidSounds = {
    -- Paid Cars
    ['dchallengerhellcat'] = '1408230925715898468',
    ['ferrarif140fe'] = '1408230925715898468',
    ['subaruej20'] = '1408230925715898468',
    -- Paid Cammed
    ['kc95chevls1cammed'] = '1407411577279348787',
    ['camls3v8'] = '1407411577279348787',
    ['kc44ls9cammed'] = '1407411577279348787',
    ['cammedcharger'] = '1407411577279348787',
    ['greynitcame'] = '1407411577279348787',
    ['lg267dragv8sc'] = '1407411577279348787',
    -- Paid Motorcycle
    ['kc113harleystglide'] = '1407411822184894587',
    ['kc125harleysofttail'] = '1407411822184894587',
    ['harleyvtwin'] = '1407411822184894587',
    ['aq15harvtwin'] = '1407411822184894587',
    ['lg13harleyftby'] = '1407411822184894587',
    ['lg22harleydv'] = '1407411822184894587',
    -- Paid Trucks
    ['kc67chevy427v8'] = '1407792335995142185',
    ['kc100vortec53st'] = '1407792335995142185',
    ['cummins5924v'] = '1407792335995142185',
    ['kc88fordv8fibrewrex'] = '1407792335995142185',
}

RegisterServerEvent("lorp_packed:server:changeSound", function(data)
    local src = source
    local entity = NetworkGetEntityFromNetworkId(data.net)
    if not DoesEntityExist(entity) then return end
    if paidSounds[data.sound] then
        local playerRoles = lorp_discord_api:GetUserRoles(src)
        local roleCheck = paidSounds[data.sound]
        if playerRoles[roleCheck] then
            Entity(entity).state['lorp_packed:sound:change'] = data.sound
            lib.notify(src, {title = 'Sound Menu', description = 'You have changed your vehicle sound to '..data.sound, type = 'success', position = 'top'})
        else
            lib.notify(src, {title = 'Sound Menu', description = 'You do not have permission to use this paid sound', type = 'error', position = 'top'})
        end
    else
        Entity(entity).state['lorp_packed:sound:change'] = data.sound
        lib.notify(src, {title = 'Sound Menu', description = 'You have changed your vehicle sound to '..data.sound, type = 'success', position = 'top'})
    end
end)