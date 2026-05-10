local DisplayLabels = {}
local Index = 1

CreateThread(function()
    local DisplayHashs = {}
    local sounds = {
        ['BMW S63 4.4L V8'] = 's63b44',
        ['Desert RzR'] = 'kc86polarzr3desert',
        ['6.0L Powerstroke'] = 'kc129pstroke60in4',
        ['7.3L Ford'] = 'kc45diels70',
        ['12v Cummins'] = '12vCummins',
        ['Can-Am 1000 XMR'] = 'kc94can100xmrdualemp',
        ['Harley Davidson FTBY'] = 'lg13harleyftby',
        ['Harley Davidson'] = 'lg22harleydv',
        ['Detroit D60 Jakes'] = 'kc82detroitd60jake',
        ['Detroit D60'] = 'kc82detroitd60',
        ['Cammed LS9'] = 'kc44ls9cammed',
        ['Camaro LSA'] = 'kc44camaro12lsa',
        ['6.7 Powerstroke'] = 'aq07powerstroke67',
        ['Coyote F-150 5.0'] = 'aq02coyotef150',
        ['Chevrolet Duramax'] = 'chevydmaxeng',
        ['Corvette LS3'] = 'lg68ls3vette',
        ['Hellcat Redeye'] = 'lg81hcredeye',
        ['2 Stroke'] = '2strkbeng',
        ['426 Hemi Hellephant'] = '426hemi',
        ['Supra MK4'] = 'toysupmk4',
        ['Mustang 5.0'] = 'tascmustanggt50',
        ['Porche Flat 6'] = 'tagt3flat6',
        ['Cummins B'] = 'tacumminsb',
        ['Audi 4.0L v8'] = 'taaud40v8',
        ['GSXR 1000'] = 'suzukigsxr1k',
        ['Rotory 7'] = 'Rotory7',
        ['v8 Predator'] = 'predatorv8',
        ['LT4 Chrvrolet'] = 'chevroletlt4',
        ['Cammed Charger'] = 'cammedcharger',
        ['v10 Lamborghini'] = 'lamborghini52v10',
        ['6.4 Powerstroke'] = '64powerstroke',
        ['5.3 Vortec'] = '53vortec',
        ['Ninja H2R'] = 'ta103ninjah2r',
        ['Default Harley'] = 'monster',

        -- Paid Cars
        ['Hellcat'] = 'dchallengerhellcat',
        ['Ferrari F140'] = 'ferrarif140fe',
        ['Subaru J20'] = 'subaruej20',
        -- Paid Cammed
        ['LS1 Cammed'] = 'kc95chevls1cammed',
        ['LS3 Cammed'] = 'camls3v8',
        ['LS9 Cammed'] = 'kc44ls9cammed',
        ['Hemi Cammed'] = 'cammedcharger',
        ['4.8 Chevy'] = 'greynitcame',
        ['267 Drag V8'] = 'lg267dragv8sc',
        -- Paid Motorcycle
        ['Harley Glide'] = 'kc113harleystglide',
        ['Harley Softtail'] = 'kc125harleysofttail',
        ['Harley vTwin 1'] = 'harleyvtwin',
        ['Harley vTwin 2'] = 'aq15harvtwin',
        ['Harley FTBY'] = 'lg13harleyftby',
        ['Harley DV'] = 'lg22harleydv',
        -- Paid Trucks
        ['Chevy 427'] = 'kc67chevy427v8',
        ['Vortec 5.3'] = 'kc100vortec53st',
        ['24V Cummins'] = 'cummins5924v',
        ['5.0 Ford'] = 'kc88fordv8fibrewrex',
    }

    for k, v in pairs(sounds) do
        DisplayLabels[#DisplayLabels + 1] = k
        DisplayHashs[#DisplayHashs + 1] = v
    end

    lib.registerMenu({
        id = 'engine_sound_menu',
        title = 'Engine Sound Menu',
        position = 'bottom-right',
        onSideScroll = function(selected, scrollIndex, args)
            Index = scrollIndex
        end,
        options = {
            { label = 'Change Engine Sound', icon = 'arrows-up-down-left-right', values = DisplayLabels },
        }
    }, function(selected, scrollIndex, args)
        if not cache.vehicle or cache.seat ~= -1 then
            return lib.notify({title = 'Swap Menu', description = 'You have to be in a driver seat to use this', type = 'error', position = 'top'})
        end

        TriggerServerEvent('lorp_packed:server:changeSound', { net = VehToNet(cache.vehicle), sound = sounds[DisplayLabels[scrollIndex]] })
    end)
end)

RegisterNetEvent("lorp_packed:server:requestSoundMenu", function()
    if not cache.vehicle or cache.seat ~= -1 then
        return lib.notify({title = 'Swap Menu', description = 'You have to be in a driver seat to use this', type = 'error', position = 'top'})
    end

    lib.setMenuOptions('engine_sound_menu', { label = 'Change Engine Sound', icon = 'arrows-up-down-left-right', values = DisplayLabels, defaultIndex = Index }, 1)
    lib.showMenu('engine_sound_menu')
end)

AddStateBagChangeHandler("lorp_packed:sound:change", nil, function(bagName, key, value)
    local entity = GetEntityFromStateBagName(bagName)
    if entity == 0 then return end
    ForceUseAudioGameObject(entity, value)
end)