local cl_utils = lib.require('utils.client')
local ak47_ambulancejob = exports.ak47_ambulancejob

local function combatMedic()
    if cl_utils.hasJobGrade({['sheriff'] = 10, ['sahp'] = 5}) then
        local playerCoords = GetEntityCoords(cache.ped)
        local targetPlayer = lib.getClosestPlayer(playerCoords, 3.0, false)
        if targetPlayer then
            local targetPlayerId = GetPlayerServerId(targetPlayer)
            if cl_utils.playerDead(targetPlayerId) then
                local targetDamages = ak47_ambulancejob:GetSkellyDamages(targetPlayerId)
                local targetDialog = lib.alertDialog({
                    header = 'Damage Report',
                    content = 'Head '..targetDamages.head..'  \n Chest '..targetDamages.chest..'  \n Left Arm '..targetDamages.larm..'  \n Right Arm '..targetDamages.rarm..'  \n Left Leg '..targetDamages.lleg..'  \n Right leg '..targetDamages.rleg,
                    labels = {confirm = 'Revive'},
                    centered = true,
                    cancel = true
                })

                if targetDialog == 'confirm' then
                    lib.notify({title = 'Combat Medic', description = 'You are reviving the player', type = 'success'})
                    if lib.progressBar({
                        duration = 10000,
                        label = 'Reviving Player...',
                        useWhileDead = false,
                        canCancel = false,
                        disable = {
                            car = true,
                            move = true,
                            combat = true
                        },
                        anim = {
                            scenario = 'CODE_HUMAN_MEDIC_TEND_TO_DEAD'
                        },
                    }) then
                        TriggerServerEvent('ak47_ambulancejob:revive', targetPlayerId)
                    end
                else
                    lib.notify({title = 'Combat Medic', description = 'You declined the revive', type = 'success'})
                end
            else
                lib.notify({title = 'Combat Medic', description = 'There is nobody nearby that is dead', type = 'error'})
            end
        else
            lib.notify({title = 'Combat Medic', description = 'There is nobody nearby', type = 'error'})
        end
    end
end

RegisterNetEvent('lorp_packed:client:combatMedic', function()
    combatMedic()
end)