function Notificaton(msg)
    lib.notify({
        title = 'Drunk',
        description = msg
    })
end

function RequestWalking(set)
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
        Wait(1)
    end
end

function isDrunk()
    return isDrunk
end
exports('isDrunk', isDrunk)

function GetDrunkLevel()
    return lib.callback.await('cs:drunk:fetch', false, 'get')
end
exports('GetDrunkLevel', GetDrunkLevel)

function SetDrunkLevel(valueS)
    local valueS = type(valueS) == 'table' and valueS.client.value or valueS
    if not valueS then return 0 end
    return lib.callback.await('cs:drunk:fetch', false, 'set', valueS)
end
exports('SetDrunkLevel', SetDrunkLevel)

function AddDrunkLevel(valueS)
    local valueS = type(valueS) == 'table' and valueS.client.value or valueS
    if not valueS then return 0 end
    return lib.callback.await('cs:drunk:fetch', false, 'add', valueS)
end
exports('AddDrunkLevel', AddDrunkLevel)

function RemoveDrunkLevel(valueS)
    local valueS = type(valueS) == 'table' and valueS.client.value or valueS
    if not valueS then return 0 end
    return lib.callback.await('cs:drunk:fetch', false, 'remove', valueS)
end
exports('RemoveDrunkLevel', RemoveDrunkLevel)


function DrinkBacardi(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Bacardi...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_bacardi',
            bone = 18905,
            pos = vec3(0.030000, -0.410000, 0.000000),
            rot = vec3(-89.151970, -5.821002, -14.300016)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'bacardi')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkBacardi', DrinkBacardi)

function DrinkBarefoot(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Barefoot Bubbly...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_barefoot_bubbly',
            bone = 18905,
            pos = vec3(0.030000, -0.410000, 0.000000),
            rot = vec3(-89.151970, -5.821002, -14.300016)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'barefoot')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkBarefoot', DrinkBarefoot)

function DrinkCasaDelSol(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Casa Del Sol...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_casa_del_sol',
            bone = 18905,
            pos = vec3(0.030000, -0.410000, 0.000000),
            rot = vec3(-89.151970, -5.821002, -14.300016)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'casadelsol')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkCasaDelSol', DrinkCasaDelSol)

function DrinkCasamigosA(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Casamigos...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_casamigos',
            bone = 18905,
            pos = vec3(0.080000, -0.280000, 0.040000),
            rot = vec3(-92.000000, 0.000000, -8.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'casamigos_a')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkCasamigosA', DrinkCasamigosA)

function DrinkCasamigosB(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Casamigos...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_casamigos',
            bone = 18905,
            pos = vec3(0.080000, -0.280000, 0.040000),
            rot = vec3(-92.000000, 0.000000, -8.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'casamigos_b')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkCasamigosB', DrinkCasamigosB)

function DrinkCasamigosC(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Casamigos...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_casamigos_c',
            bone = 18905,
            pos = vec3(0.080000, -0.280000, 0.040000),
            rot = vec3(-92.000000, 0.000000, -8.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'casamigos_c')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkCasamigosC', DrinkCasamigosC)

function DrinkCasamigosD(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Casamigos...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_casamigos_d',
            bone = 18905,
            pos = vec3(0.080000, -0.280000, 0.040000),
            rot = vec3(-92.000000, 0.000000, -8.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'casamigos_d')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkCasamigosD', DrinkCasamigosD)

function DrinkCirocPassion(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Ciroc (Passion)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_ciroc_passion',
            bone = 18905,
            pos = vec3(0.080000, -0.320000, 0.040000),
            rot = vec3(-96.000000, 0.000000, -8.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'ciroc_passion')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkCirocPassion', DrinkCirocPassion)

function DrinkCirocPomeranate(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Ciroc (Pomeranate)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_ciroc_pomeranate',
            bone = 18905,
            pos = vec3(0.080000, -0.320000, 0.040000),
            rot = vec3(-96.000000, 0.000000, -8.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'ciroc_pomeranate')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkCirocPomeranate', DrinkCirocPomeranate)

function DrinkCirocSummer(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Ciroc (Summer)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_ciroc_summer',
            bone = 18905,
            pos = vec3(0.080000, -0.320000, 0.040000),
            rot = vec3(-96.000000, 0.000000, -8.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'ciroc_summer')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkCirocSummer', DrinkCirocSummer)

function DrinkCrown(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Crown...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_crown',
            bone = 18905,
            pos = vec3(0.120000, -0.210000, 0.050000),
            rot = vec3(-96.000000, -52.000000, 6.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'crown')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkCrown', DrinkCrown)

function DrinkDonJulio(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Don Julio...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_don_julio',
            bone = 18905,
            pos = vec3(0.030000, -0.410000, 0.000000),
            rot = vec3(-89.151970, -5.821002, -14.300016)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'donjulio')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkDonJulio', DrinkDonJulio)

function DrinkDusse(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Dusse...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_dusse',
            bone = 18905,
            pos = vec3(0.210000, -0.230000, 0.460000),
            rot = vec3(-98.000000, 6.000000, -24.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'dusse')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkDusse', DrinkDusse)

function DrinkEverclear(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Everclear...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_everclear',
            bone = 18905,
            pos = vec3(0.030000, -0.410000, 0.000000),
            rot = vec3(-89.151970, -5.821002, -14.300016)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'everclear')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkEverclear', DrinkEverclear)

function DrinkHennessyBlack(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Hennessy (Black)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_hennessy_black',
            bone = 18905,
            pos = vec3(0.080000, -0.250000, 0.040000),
            rot = vec3(-96.000000, 0.000000, -12.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'hennessy_black')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkHennessyBlack', DrinkHennessyBlack)

function DrinkHennessyGold(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Hennessy (Gold)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_hennessy_gold',
            bone = 18905,
            pos = vec3(0.080000, -0.250000, 0.040000),
            rot = vec3(-96.000000, 0.000000, -12.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'hennessy_gold')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkHennessyGold', DrinkHennessyGold)

function DrinkHennessyNBA(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Hennessy (NBA)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_hennessy_original_nba',
            bone = 18905,
            pos = vec3(0.080000, -0.250000, 0.040000),
            rot = vec3(-96.000000, 0.000000, -12.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'hennessy_nba')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkHennessyNBA', DrinkHennessyNBA)

function DrinkHennessyVSOP(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Hennessy (VSOP)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_hennessy_vsop',
            bone = 18905,
            pos = vec3(0.080000, -0.250000, 0.040000),
            rot = vec3(-96.000000, 0.000000, -12.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'hennessy_vsop')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkHennessyVSOP', DrinkHennessyVSOP)

function DrinkJackOG(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Jack Daniels (Original)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_jack_daniel',
            bone = 18905,
            pos = vec3(0.030000, -0.410000, 0.000000),
            rot = vec3(-89.151970, -5.821002, -14.300016)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'jack_daniel_og')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkJackOG', DrinkJackOG)

function DrinkJackBerry(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Jack Daniels (Berry)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_jack_daniel_berry',
            bone = 18905,
            pos = vec3(0.110000, -0.070000, 0.040000),
            rot = vec3(-92.000000, 0.000000, -20.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'jack_daniel_berry')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkJackBerry', DrinkJackBerry)

function DrinkJackCola(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Jack Daniels (Cola)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_jack_daniel_coca',
            bone = 18905,
            pos = vec3(0.110000, -0.070000, 0.040000),
            rot = vec3(-92.000000, 0.000000, -20.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'jack_daniel_cola')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkJackCola', DrinkJackCola)

function DrinkJackDownhome(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Jack Daniels (Downhome)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_jack_daniel_d',
            bone = 18905,
            pos = vec3(0.110000, -0.070000, 0.040000),
            rot = vec3(-92.000000, 0.000000, -20.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'jack_daniel_downhome')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkJackDownhome', DrinkJackDownhome)

function DrinkJackLemonade(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Jack Daniels (Lemonade)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_jack_daniel_l',
            bone = 18905,
            pos = vec3(0.110000, -0.070000, 0.040000),
            rot = vec3(-92.000000, 0.000000, -20.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'jack_daniel_lemonade')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkJackLemonade', DrinkJackLemonade)

function DrinkJackPeach(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Jack Daniels (Peach)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_jack_daniel_peach',
            bone = 18905,
            pos = vec3(0.110000, -0.070000, 0.040000),
            rot = vec3(-92.000000, 0.000000, -20.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'jack_daniel_peach')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkJackPeach', DrinkJackPeach)

function DrinkRemy(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Remy Martin...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_remy_martin',
            bone = 18905,
            pos = vec3(0.120000, -0.240000, 0.040000),
            rot = vec3(-96.000000, -58.000000, 4.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'remy_martin')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkRemy', DrinkRemy)

function DrinkSkyyOrange(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Skyy (Blood Orange)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_skyy',
            bone = 18905,
            pos = vec3(0.100000, -0.290000, 0.060000),
            rot = vec3(-98.000000, 0.000000, -6.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'skyy_orange')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkSkyyOrange', DrinkSkyyOrange)

function DrinkSkyyCitrus(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Skyy (Citrus)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink_b', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_skyy_b',
            bone = 18905,
            pos = vec3(0.100000, -0.290000, 0.060000),
            rot = vec3(-98.000000, 0.000000, -6.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'skyy_citrus')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkSkyyCitrus', DrinkSkyyCitrus)

function DrinkSkyyStrawberry(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Skyy (Strawberry)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_skyy_c',
            bone = 18905,
            pos = vec3(0.100000, -0.290000, 0.060000),
            rot = vec3(-98.000000, 0.000000, -6.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'skyy_strawberry')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkSkyyStrawberry', DrinkSkyyStrawberry)

function DrinkSkyyPeach(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Skyy (Peach)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_skyy_d',
            bone = 18905,
            pos = vec3(0.100000, -0.290000, 0.060000),
            rot = vec3(-98.000000, 0.000000, -6.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'skyy_peach')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkSkyyPeach', DrinkSkyyPeach)

function DrinkSkyyPineapple(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Skyy (Pineapple)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_skyy_e',
            bone = 18905,
            pos = vec3(0.100000, -0.290000, 0.060000),
            rot = vec3(-98.000000, 0.000000, -6.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'skyy_pineapple')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkSkyyPineapple', DrinkSkyyPineapple)

function DrinkSkyyVanilla(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Skyy (Vanilla)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_skyy_f',
            bone = 18905,
            pos = vec3(0.100000, -0.290000, 0.060000),
            rot = vec3(-98.000000, 0.000000, -6.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'skyy_vanilla')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkSkyyVanilla', DrinkSkyyVanilla)

function DrinkSmirnoffLemonade(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Smirnoff (Pink Lemonade)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_smirnoff',
            bone = 18905,
            pos = vec3(0.030000, -0.410000, 0.000000),
            rot = vec3(-89.151970, -5.821002, -14.300016)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'smirnoff_lemonade')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkSmirnoffLemonade', DrinkSmirnoffLemonade)

function DrinkSmirnoffRasberry(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Smirnoff (Rasberry)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_smirnoff_rasperry',
            bone = 18905,
            pos = vec3(0.080000, -0.340000, 0.060000),
            rot = vec3(-98.000000, 0.000000, -10.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'smirnoff_rasberry')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkSmirnoffRasberry', DrinkSmirnoffRasberry)

function DrinkStellaBerry(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Stella (Berry)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_stella',
            bone = 18905,
            pos = vec3(0.120000, -0.310000, 0.080000),
            rot = vec3(-102.000000, 0.000000, -6.000000)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'stella_berry')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkStellaBerry', DrinkStellaBerry)

function DrinkStellaBlack(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Stella (Black)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_stella_black',
            bone = 18905,
            pos = vec3(0.050000, -0.360000, 0.080000),
            rot = vec3(-100.000000, 0.000000, -12.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'stella_black')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkStellaBlack', DrinkStellaBlack)

function DrinkStellaRose(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Stella (Rose)...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_stella',
            bone = 18905,
            pos = vec3(0.120000, -0.310000, 0.080000),
            rot = vec3(-102.000000, 0.000000, -6.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'stella_rose')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkStellaRose', DrinkStellaRose)

function DrinkTanqueray(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Tanqueray...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'set_drinks_tanqueray',
            bone = 18905,
            pos = vec3(0.070000, -0.240000, 0.020000),
            rot = vec3(-88.000000, 0.000000, -18.000000)
        },
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'tanqueray')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkTanqueray', DrinkTanqueray)

function DrinkTaylorPort(valueS)
    if lib.progressBar({
        duration = 10000,
        label = 'Drinking Taylor Port...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            combat = true
        },
        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
        prop = {
            model = 'atr_set_drinks_taylor_port',
            bone = 18905,
            pos = vec3(0.030000, -0.410000, 0.000000),
            rot = vec3(-89.151970, -5.821002, -14.300016)
        }
    }) then
        TriggerServerEvent('cs:drunk:updateUI', 'taylor_port')
        return AddDrunkLevel(valueS)
    else
        return false
    end
end exports('DrinkTaylorPort', DrinkTaylorPort)