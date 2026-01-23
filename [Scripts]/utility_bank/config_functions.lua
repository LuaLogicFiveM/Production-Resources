Config.Functions = {
    StartFramework = function()
        if GetResourceState("es_extended") ~= "missing" then
            ESX = exports["es_extended"]:getSharedObject()
        elseif GetResourceState("qb-core") ~= "missing" then
            QBCore = exports["qb-core"]:GetCoreObject()
        end
    end,

    HasPlayerLoaded = function()
        if ESX then
            return ESX.IsPlayerLoaded()
        elseif QBCore then
            return QBCore.Functions.GetPlayerData()
        end
    end,

    --------------------------------- Server ---------------------------------

    RegisterUsableItem = function(item, func)
        -- func: (source, item) => void
        -- source<number> Its the player id that uses the item
        -- item<string>   The name of the item that is being used

        if GetResourceState("es_extended") ~= "missing" then
            ESX.RegisterUsableItem(item, func)
        elseif GetResourceState("qb-core") ~= "missing" then
            QBCore.Functions.CreateUseableItem(item, func)
        end
    end,

    GiveTrollyMoney = function(source, amount)
        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/AddMoney/
        AddItem(source, "black_money", amount)
    end,

    HaveItem = function(source, item)
        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/HasItem/
        return HaveItem(source, item)
    end,
    
    RemoveItem = function(source, item, amount)
        -- https://utility-library.github.io/documentation/server/esx_integration/xplayer/RemoveItem/
        RemoveItem(source, item, amount)
    end,

    OnShuttersManagement = function(source)
        local bank = GetClosestBankInRadius(source, Config.ShuttersManagement.distance)
        if not bank then 
            TriggerClientAction("ShowNotify", source, Config.Translations["shutters_no_near_bank"])
            return
        end

        TriggerClientAction("ShowNotify", source, Config.Translations["shutters_toggling"])
        
        bank.door_shutters = not bank.door_shutters

        if bank.beingRobbed then
            bank.shuttersBroken = true
        end
    end,

    -- OnShutterHit: (bankId, source, weapon) => integer
    -- bankId<string> The id of the bank
    -- source<number> Its the player id that hit the shutter
    -- weapon<number> Current weapon hash that is being used

    -- Return the number of hits to add to the shutter
    OnShutterHit = function(bankId, source, weapon)
        -- Add your checks here
        return 1
    end,

    -- CanStartRobbery: (source, bankId) => boolean
    -- source<number> Its the player id that tries to start a robbery
    -- bankId<string> The id of the bank

    -- Return true if the player can start the robbery
    CanStartRobbery = function(source, bankId)
        local sheriff = ESX.GetExtendedPlayers('job', 'sheriff')
        local sahp = ESX.GetExtendedPlayers('job', 'sahp')
        local count = #sheriff + #sahp

        if count < Config.MinCops then
            local xPlayer = ESX.GetPlayerFromId(source)
            xPlayer.showNotification(Config.Translations["robbery_cant_start_notify"])
            return false
        end

        return true
    end,

    StartAlarm = function(bankId)
        if IsDuplicityVersion() then
            TriggerEvent('cd_dispatch:PreSet:JewelryRobbery')
        else
            TriggerServerEvent('cd_dispatch:PreSet:JewelryRobbery')
        end
    end,

    CanStartVaultHacking = function(source, bankId)
        if Config.VaultHackingItem and Config.VaultHackingItem ~= "" then
            return Config.Functions.HaveItem(source, Config.VaultHackingItem)
        else
            return true
        end
    end,

    -- Used to check validity of what the client is trying to do
    -- CanRaiseIntimidation: (source, bank) => boolean
    -- source<number> Its the player id that tries to raise the intimidation
    -- bank<Bank> The bank datas

    -- Return true if the player can raise the intimidation
    CanRaiseIntimidation = function(source, bank)
        local ped = GetPlayerPed(source)
        local weapon = GetSelectedPedWeapon(ped)

        -- Only allow if its using a weapon
        if weapon == `WEAPON_UNARMED` then
            return false
        end

        -- Only allow if the player is inside the bank
        if not InsideBank(source, bank) then
            return false
        end

        return true
    end,

    OnBankReset = function(bankId)
        -- You can use GetBank(bankId) to get the bank data
        local bank = GetBank(bankId)

        -- print(json.encode(bank)) -- REMEMBER to set Config.Debug to true!
        -- AnyPlayerInsideBank(bank) -- returns true if any player is inside the bank
        -- GetBankPlayerIsInside(bank) -- returns the bank id in which the player is in
        -- InsideBank(source, bank) -- returns true if the player is inside the bank
    end,

    --------------------------------- Client ---------------------------------

    -- NeedToRaiseIntimdation: () => boolean, boolean

    -- Return true if need to raise the intimidation
    NeedToRaiseIntimdation = function()
        return IsPedShooting(PlayerPedId())
    end,

    -- Called when the player raises the intimidation
    -- OnRaiseIntimidation: () => void
    OnRaiseIntimidation = function()
        PlayShootPainHostages() -- internal function to play the shooting pain animation
    end,

    -- This function is called every 1 second while the player is inside a bank and if it is not being robbed
    -- NeedToStartRobbery: () => boolean

    -- Return true if need to start the robbery
    NeedToStartRobbery = function()
        return IsPedArmed(PlayerPedId(), 7)
    end,

    -- OnVaultHackingMinigameStarted: (bankId) => boolean 
    -- bankId<string> The id of the bank

    --  Returns true if the hack was completed successfully 
    OnVaultHackingMinigameStarted = function(bankId)
        -- StartHackingMinigame: (lives) => boolean
        -- lives<number> The amount of lives for the minigame
        -- password<string> The password for the minigame (ONLY 8 CHARACTERS)

        -- Returns true if the hack was completed successfully
        local result = StartHackingMinigame(5, "MXCLOVEU")

        return result
    end,

    --[[
        TargetAddModel = function(models, options)
    
        end,
        TargetAddLocalEntity = function(entity, options)
    
        end,
        TargetRemoveLocalEntity = function(entity)
    
        end,
    ]]
}