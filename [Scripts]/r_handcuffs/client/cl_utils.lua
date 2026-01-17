/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-handcuffs-system
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Variables ]]

local keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

-- [[ Commands ]]

local function cuffs()
    local pedInFront = GetPedInFront()
    if pedInFront == 0 then return end

    TriggerServerEvent('r_handcuffs:server:cuffs', pedInFront)
end

local function uncuffs()
    local pedInFront = GetPedInFront()
    if pedInFront == 0 then return end

    TriggerServerEvent('r_handcuffs:server:uncuffs', pedInFront)
end

local function rope()
    local pedInFront = GetPedInFront()
    if pedInFront == 0 then return end

    TriggerServerEvent('r_handcuffs:server:rope', pedInFront)
end

local function unrope()
    local pedInFront = GetPedInFront()
    if pedInFront == 0 then return end

    TriggerServerEvent('r_handcuffs:server:unrope', pedInFront)
end

local function grinder()
    local pedInFront = GetPedInFront()
    if pedInFront == 0 then return end

    TriggerServerEvent('r_handcuffs:server:grinder', pedInFront)
end

if Config.EnableCommands then
    RegisterCommand('cuffs', function()
        cuffs()
    end)

    RegisterCommand('uncuffs', function()
        uncuffs()
    end)

    RegisterCommand('rope', function()
        rope()
    end)

    RegisterCommand('unrope', function()
        unrope()
    end)

    RegisterCommand('grinder', function()
        grinder()
    end)
end


local cooldown = false
local emsjob = exports['ak47_ambulancejob']

RegisterCommand('handsup', function()
    if cooldown and not LocalPlayer.state.handsup then
        return lib.notify({title = 'Handsup', description = 'You are on a cooldown.', position = 'top'})
    end

    if cache.vehicle then
        return lib.notify({title = 'Handsup', description = 'You are unable to do this while in a vehicle.', position = 'top'})
    end

    if cache.weapon then
        return lib.notify({title = 'Handsup', description = 'You are unable to do this with a weapon out.', position = 'top'})
    end

    if emsjob:IsPlayerDead() or emsjob:IsPlayerDown() then
        return lib.notify({title = 'Handsup', description = 'You are unable to do this while dead.', position = 'top'})
    end

	if not LocalPlayer.state.handsup and not IsPedArmed(cache.ped, 4) then
        cooldown = true
        LocalPlayer.state.handsup = true
        PlayAnim('rytrak@hangsup@clip', 'hangsup_clip', 50)
    else
        ClearPedTasks(cache.ped)
        LocalPlayer.state.handsup = nil
        SetTimeout(1000, function()
            cooldown = false
        end)
    end
end, false)

RegisterKeyMapping('handsup', 'Toggle Handsup', 'keyboard', 'x')

-- [[ Event ]]

RegisterNetEvent('r_handcuffs:client:execCuffs', function()
    cuffs()
end)

RegisterNetEvent('r_handcuffs:client:execUncuffs', function()
    uncuffs()
end)

RegisterNetEvent('r_handcuffs:client:execRope', function()
    rope()
end)

RegisterNetEvent('r_handcuffs:client:execUnrope', function()
    unrope()
end)

RegisterNetEvent('r_handcuffs:client:execGrinder', function()
    grinder()
end)

-- [[ Functions ]]

function Hint(message)
    AddTextEntry('r_handcuffs', message)
    BeginTextCommandDisplayHelp('r_handcuffs')
    EndTextCommandDisplayHelp(0, 0, 0, -1)
end

RegisterNetEvent('r_handcuffs:client:sendNotification', function(message)
    PlaySound(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0, 0, 1)
    
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(message)
    DrawNotification(false, true)
end)

function DisableControl()
    for _,id in pairs(Config.DisableKey) do
        DisableControlAction(0, id, true)
        DisableControlAction(2, id, true)
    end

    for _,v in pairs(Config.DisableInventoryKey) do
        DisableControlAction(0, keys[v], true)
    end

    DisablePlayerFiring(PlayerPedId(), true)
    SetPedPathCanUseLadders(PlayerPedId(), false)

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        DisableControlAction(0, 59, true)
        DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
        DisableControlAction(0, 70, true) -- INPUT_VEH_ATTACK2
        DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
    end
end

function FreezePlayer()
    DisableControlAction(0, 24, true)
    DisablePlayerFiring(PlayerPedId(), true)
    DisableControlAction(0, 142, true)
    DisableControlAction(0, 25, true)
    DisableControlAction(0, 30, true)
    DisableControlAction(0, 31, true)
    DisableControlAction(0, 32, true)
    DisableControlAction(0, 33, true)
    DisableControlAction(0, 34, true)
    DisableControlAction(0, 35, true)
    DisableControlAction(0, 36, true)
    DisableControlAction(0, 22, true)
end

-- [[ Thread ]]

if #Config.Framework.NeedItemToCutRope == 0 then
    if Config.Framework.ESX or Config.Framework.QBCore or Config.Framework.OXInventory then
        Citizen.CreateThread(function()
            while true do
                sleep = 500
        
                local pedInFront = GetPedInFront()
        
                if Player(pedInFront).state[Config.StatebagsName.rope] and IsPlayerBehind(pedInFront) then
                    sleep = 0
        
                    Hint(Config.Languages[Config.Language]['cutrope'])
        
                    if IsControlJustPressed(0, Config.Keys.CutRopeKey) then
                        TriggerServerEvent('r_handcuffs:server:unrope', pedInFront)
                        Wait(6000)
                    end
                end
                
                Wait(sleep)
            end
        end)
    end
end

if #Config.Framework.NeedWeaponToCutRope > 0 then
    Citizen.CreateThread(function()
        while true do
            sleep = 500

            for _,v in pairs(Config.Framework.NeedWeaponToCutRope) do
                local _, weaponPlayer = GetCurrentPedWeapon(PlayerPedId())
                
                if weaponPlayer == GetHashKey(v) then
                    local pedInFront = GetPedInFront()
            
                    if Player(pedInFront).state[Config.StatebagsName.rope] and IsPlayerBehind(pedInFront) then
                        sleep = 0
            
                        Hint(Config.Languages[Config.Language]['cutrope'])
            
                        if IsControlJustPressed(0, Config.Keys.CutRopeKey) then
                            TriggerServerEvent('r_handcuffs:server:unrope', pedInFront)
                            Wait(6000)
                        end
                    end

                    sleep = 0
                end
            end

            Wait(sleep)
        end
    end)
end