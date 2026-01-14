lib.locale()
local lastRobberyTime = 0
local atmRobberyState = {}

lib.callback.register('lorp_atm_heist:checkforpolice', function()
    return getCopCount() >= Config.Police.required
end)

lib.callback.register('lorp_atm_heist:checktime', function()
    local timePassed = os.time() - lastRobberyTime

    if lastRobberyTime ~= 0 and timePassed < Config.CooldownTimer then
        return false, Config.CooldownTimer - timePassed
    end

    lastRobberyTime = os.time()
    return true
end)

RegisterServerEvent('lorp_atm_heist:MinigameResult')
AddEventHandler('lorp_atm_heist:MinigameResult', function(success, method)
    local src = source
    if success and (method == 'drill' or method == 'hack') then
        atmRobberyState[src] = {
            minigamePassed = true,
            pickupcash = 0,
            method = method
        }
    else
        atmRobberyState[src] = nil
    end
end)

RegisterNetEvent('lorp_atm_heist:robbery')
AddEventHandler('lorp_atm_heist:robbery', function(atmCoords)
    local src = source
    local Player = getPlayer(src)
    local Identifier = getPlayerIdentifier(src)
    local PlayerName = getPlayerName(src)
    local ped = GetPlayerPed(src)
    local distance = GetEntityCoords(ped)

    if #(distance - atmCoords) <= 5 then
        if Player then
            local state = atmRobberyState[src]

            if state and state.minigamePassed then
                local method = state.method or 'drill'
                local maxCashPiles = method == 'hack' and Config.Reward.hack_cash_pile or Config.Reward.drill_cash_pile

                state.pickupcash = state.pickupcash + 1
                AddPlayerMoney(Player, Config.Reward.account, Config.Reward.cash_prop_value)

                TriggerClientEvent('lorp_atm_heist:notification', src, locale('server_pickup_cash', Config.Reward.cash_prop_value), 'success')

                if state.pickupcash >= maxCashPiles then
                    atmRobberyState[src] = nil
                else
                    atmRobberyState[src] = state
                end
            else
                print(('^1[Exploit Attempt]^0 %s (%s) tried to rob ATM without completing the minigame.'):format(PlayerName, Identifier))
            end
        end
    else
        print(('^1[Exploit Attempt]^0 %s (%s) triggered robbery too far from ATM.'):format(PlayerName, Identifier))
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    atmRobberyState[src] = nil
end)