-- █▀▄ ▄▀▄ ██▄ ██▄ ██▀ █▀▄ █ ██▀ ▄▀▀
-- █▀▄ ▀▄▀ █▄█ █▄█ █▄▄ █▀▄ █ █▄▄ ▄██

Config.UseRobbery = true

---@class RobberiesAbility Configure stores for robbery opportunities
Config.RobberiesAbility = {
    ['server'] = true, -- Stores not owned by players, server stores
    ['owned'] = true -- Stores owned by players
}

---@field PoliceJobs string | table: Name of service jobs, if you have more than one job e.g. 'police' and 'sheriff' you can use the table {'police', 'sheriff'}, the values will add up 
Config.PoliceJobs = {'bcso', 'sasp', 'gov'}

---@field PoliceJobs number: Required number of online police officers to start a robbery
Config.RequiredPolices = 2


---@field StartRobberyOnShoot boolean: Start robbery when player shoot anywhere in the store
Config.StartRobberyOnShootInPolyZone = false

---@field StartRobberyOnAiming boolean: Start robbery when player aiming on the cashiers in the store
Config.StartRobberyOnAiming = true
Config.StartRobberyOnAimingTime = 5000 -- Time in miliseconds to start robbery when player aiming on the peds in the store

---@field StartRobberyOnTakeDamageByWeapon boolean: Start a robbery when the player deals damage with the cashiers ped weapon (list weapons in Config.StartRobberyWeaponsAllowed)
Config.StartRobberyOnTakeDamageByWeapon = true

---@field StartRobberyWeaponsAllowed table: Allowed weapons
Config.StartRobberyWeaponsAllowed = {
    -- Handguns
    [`weapon_pistol`] = true,
    [`weapon_pistol_mk2`] = true,
    [`weapon_combatpistol`] = true,
    [`weapon_appistol`] = true,
    [`weapon_pistol50`] = true,
    [`weapon_snspistol`] = true,
    [`weapon_snspistol_mk2`] = true,
    [`weapon_heavypistol`] = true,
    [`weapon_vintagepistol`] = true,
    [`weapon_marksmanpistol`] = true,
    [`weapon_revolver`] = true,
    [`weapon_revolver_mk2`] = true,
    [`weapon_doubleaction`] = true,
    [`weapon_ceramicpistol`] = true,
    [`weapon_navyrevolver`] = true,
    [`weapon_gadget_pistol`] = true,
    [`weapon_pistolxm3`] = true,

    -- Submachine Guns
    [`weapon_microsmg`] = true,
    [`weapon_smg`] = true,
    [`weapon_smg_mk2`] = true,
    [`weapon_assaultsmg`] = true,
    [`weapon_combatpdw`] = true,
    [`weapon_machinepistol`] = true,
    [`weapon_minismg`] = true,
    [`weapon_tecpistol`] = true,

    -- Shotguns
    [`weapon_pumpshotgun`] = true,
    [`weapon_pumpshotgun_mk2`] = true,
    [`weapon_sawnoffshotgun`] = true,
    [`weapon_assaultshotgun`] = true,
    [`weapon_bullpupshotgun`] = true,
    [`weapon_musket`] = true,
    [`weapon_heavyshotgun`] = true,
    [`weapon_dbshotgun`] = true,
    [`weapon_autoshotgun`] = true,
    [`weapon_combatshotgun`] = true,

    -- Assault Rifles
    [`weapon_assaultrifle`] = true,
    [`weapon_assaultrifle_mk2`] = true,
    [`weapon_carbinerifle`] = true,
    [`weapon_carbinerifle_mk2`] = true,
    [`weapon_advancedrifle`] = true,
    [`weapon_specialcarbine`] = true,
    [`weapon_specialcarbine_mk2`] = true,
    [`weapon_bullpuprifle`] = true,
    [`weapon_bullpuprifle_mk2`] = true,
    [`weapon_compactrifle`] = true,
    [`weapon_militaryrifle`] = true,
    [`weapon_heavyrifle`] = true,
    [`weapon_tacticalrifle`] = true,

    -- Light Machine Guns
    [`weapon_mg`] = true,
    [`weapon_combatmg`] = true,
    [`weapon_combatmg_mk2`] = true,
    [`weapon_gusenberg`] = true,

    -- Sniper Rifles
    [`weapon_sniperrifle`] = true,
    [`weapon_heavysniper`] = true,
    [`weapon_heavysniper_mk2`] = true,
    [`weapon_marksmanrifle`] = true,
    [`weapon_marksmanrifle_mk2`] = true,
    [`weapon_precisionrifle`] = true,

    -- Melee mainly used in Config.StartRobberyOnShoot
    [`weapon_dagger`] = true,
    [`weapon_bat`] = true,
    [`weapon_bottle`] = true,
    [`weapon_crowbar`] = true,
    [`weapon_flashlight`] = true,
    [`weapon_golfclub`] = true,
    [`weapon_hammer`] = true,
    [`weapon_hatchet`] = true,
    [`weapon_knife`] = true,
    [`weapon_machete`] = true,
    [`weapon_switchblade`] = true,
    [`weapon_nightstick`] = true,
    [`weapon_wrench`] = true,
    [`weapon_battleaxe`] = true,
    [`weapon_poolcue`] = true,
    [`weapon_stone_hatchet`] = true,

    [`weapon_`] = true,
    [`weapon_`] = true,
    [`weapon_`] = true,
    [`weapon_`] = true,
    [`weapon_`] = true,
    [`weapon_`] = true,
    [`weapon_`] = true,
    [`weapon_`] = true,
    [`weapon_`] = true,
    [`weapon_`] = true,

}


---@field DisableAbilityPurchaseOnRobbery boolean: Once the robbery begins, it will not be possible to purchase products from this store.
Config.DisableAbilityPurchaseOnRobbery = true

---@field AbilityPurchaseTimeAfterRobbery number: Time after robbery when the store will be active again given in milliseconds (default 20 minutes)
Config.AbilityPurchaseTimeAfterRobbery = 20 * 60 * 1000

---@field GlobalRobberyTimeout number | false: Global timeout, once you start robbing one store, other players cannot start robbing other stores for that period of time. (defualt 10 minutes)
Config.GlobalRobberyTimeout = 10 * 60

---@field AbilityRobItems boolean: When robbing a safe, does the player have the opportunity to get items
Config.AbilityRobItems = false
Config.RobberyItems = {
    {name = 'bread', count = {1, 6}, chances = 80}, -- item: bread, count random from 1 to 6, 80% chances to get that
}

---@field RobberyMoneyType string: 'cash' / 'bank' / 'dirty'
Config.RobberyMoneyType = 'dirty'

---@field RobMoneyFromBalance boolean: When robbing, is the money to be obtained from the safe balance from the store or is it to be generated by the server?
Config.RobMoneyFromBalance = true

---@field RobberyMoney number | table: Used only if you don't use Config.RobMoneyFromBalance or store is not owned (Can be used as a number, e.g. 2500 and a table to randomize the amount {1500, 2500})
Config.RobberyMoney = {1500, 2000}

---@field RobberyMoneyFromBags table: Random amount of money that cashiers intimidated by the player will pack (server-spawned money, does not take from the store's safe)
Config.RobberyMoneyFromBags = {250, 450}

---@field RobberyMoneyPercentage number: What percentage of the robbery is to be taken from the balance of the store's safe and given to the robber
Config.RobberyMoneyPercentage = 50

---@field RobberyMoneyPercentageWithInsurance number: What percentage of the robbery is to be taken from the balance of the store's safe when it has insurance and given to the robber
Config.RobberyMoneyPercentageWithInsurance = 20

---@field RobberyReturnMoneyWithInsurance number: What percentage of the stolen amount is to be refunded when the store has purchased insurance
Config.RobberyReturnMoneyWithInsurance = 75

---@class IntimidationPeds:
Config.IntimidationPeds = {
    timeout = 1000, -- Every what time is to be refreshed checking if the player performs any of the following actions (miliseconds) - the higher the value, the longer the robbery will take.
    actions = {
        ['shoot'] = {355, 655}, -- The range of values to be added when a player shoots in the store. (The value is divided by 10, if you enter {3, 6}, 0.3 - 0.6 will be added)
        ['aimingOnPed'] = {7, 10}, -- The range of values to be added when a player aiming on the peds. (The value is divided by 10, if you enter {7, 10}, 0.7 - 1.0 will be added)
    }
}


---@class RobberyPossibleTime The time in the game in which players can make a heist, for example if you don't want them to make heists during the day, you can use the following option using hours in hourRange from 0 to 7, then only from this hour to this hour players will be able to make a heist.
Config.RobberyPossibleTime = {
    -- For exmple from 00:00 to 06:00
    use = false,
    hourRange = {0, 6}
}

-- @SafeRobberyGame: 
Config.SafeRobberyGame = function(onSuccess, onFailed)
    local finished = exports["tgiann-skillbar"]:taskBar(200)
    if finished then
        local finished2 = exports["tgiann-skillbar"]:taskBar(50)
        if finished2 then
            onSuccess()
        else
            onFailed()
        end
    else
        onFailed()
    end
end

-- @RobberyOnAlarm: In this function you can put an event to your dispatch when a player starts robbing a store
Config.RobberyOnAlarm = function(storeData, storeId)
    if GetResourceState('qs-dispatch') ~= 'missing' then
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = {'police', 'sheriff'},
            callLocation = vector3(storeData.managementPoint.coords.x, storeData.managementPoint.coords.y, storeData.managementPoint.coords.z),
            callCode = {code = '??-??', snippet = '<CALL SNIPPED EX: 10-10>'},
            message = ("The %s store alarm at %s has just been triggered."):format(storeData.brand, storeData.address),
            flashes = false, -- you can set to true if you need call flashing sirens...
            blip = {
                sprite = 488, -- blip sprite
                scale = 1.5, -- blip scale
                colour = 1, -- blio colour
                flashes = true, -- blip flashes
                text = 'Store Robbery', -- blip text
                time = (20 * 1000), --blip fadeout time (1 * 60000) = 1 minute
            },
            otherData = {
                {
                    text = 'Red Obscure', -- text of the other data item (can add more than one)
                    icon = 'fas fa-user-secret', -- icon font awesome https://fontawesome.com/icons/
                }
            }
        })
    elseif GetResourceState('core_dispatch') ~= 'missing' then
        TriggerServerEvent("core_dispatch:addCall",
            "10-71",
            "Store Robbery",
            {{icon = "fa-venus-mars", info = "male"}},
            {storeData.managementPoint.coords.x, storeData.managementPoint.coords.y, storeData.managementPoint.coords.z},
            "police",
            5000,
            156,
            1
        )
    else
        TriggerServerEvent("vms_stores:policeNotify", {
            job = {'police', 'sheriff'},
            message = ("The %s store alarm at %s has just been triggered."):format(storeData.brand, storeData.address),
            storeId = storeId,
            brand = storeData.brand,
            address = storeData.address,
            coords = vector3(storeData.managementPoint.coords.x, storeData.managementPoint.coords.y, storeData.managementPoint.coords.z),
            blip = {
                sprite = 431,
                scale = 1.3,
                color = 1,
                text = 'Store Robbery',
                time = (60 * 1000),
                radius = true,
            },
        })
    end
end

---@field DestroyCamerasAbility boolean: Setting true will allow robbers to destroy the cameras which will result in the alarm not being triggered and the police not being notified of the robbery taking place
Config.DestroyCamerasAbility = true

---@field DestroyedCamerasTime number: Time after which the cameras will work again
Config.DestroyedCamerasTime = 5 * 60 * 1000

---@field DestoryCamerasRequiredItem string | nil: You can set the required item to destroy cameras
Config.DestoryCamerasRequiredItem = "hack_phone" -- if you don't want required item, set it as nil
Config.DestoryCamerasRequiredItemCount = 1
Config.DestoryCamerasRemoveItemOnUse = true

-- @DestoryCamerasGame: Camera destroy mini-game, you can plug in your custom game.
Config.DestoryCamerasGame = function(onSuccess, onFailed)
    local finished = exports["tgiann-skillbar"]:taskBar(200)
    if finished then
        local finished2 = exports["tgiann-skillbar"]:taskBar(50)
        if finished2 then
            onSuccess()
        else
            onFailed()
        end
    else
        onFailed()
    end
end