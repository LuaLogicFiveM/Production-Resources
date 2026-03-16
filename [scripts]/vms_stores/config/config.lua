Config = {}

-- █▀ █▀▄ ▄▀▄ █▄ ▄█ ██▀ █   █ ▄▀▄ █▀▄ █▄▀
-- █▀ █▀▄ █▀█ █ ▀ █ █▄▄ ▀▄▀▄▀ ▀▄▀ █▀▄ █ █
local frameworkAutoFind = function()
    if GetResourceState('es_extended') == 'started' then
        return "ESX"
    elseif GetResourceState('qb-core') == 'started' then
        return "QB-Core"
    end
end

Config.Core = frameworkAutoFind()
Config.CoreExport = function()
    if Config.Core == "ESX" then
        return exports['es_extended']:getSharedObject()
    elseif Config.Core == "QB-Core" then
        return exports['qb-core']:GetCoreObject()
    end
end

---@field PlayerLoaded string: ESX: "esx:playerLoaded" / QB-Core: "QBCore:Client:OnPlayerLoaded"
Config.PlayerLoaded = Config.Core == "ESX" and "esx:playerLoaded" or "QBCore:Client:OnPlayerLoaded"

---@field PlayerLogoutServer string: ESX: "esx:playerDropped" / QB-Core: "QBCore:Server:OnPlayerUnload"
Config.PlayerLogoutServer = Config.Core == "ESX" and "esx:playerDropped" or "QBCore:Server:OnPlayerUnload"

---@field PlayerSetJob string: ESX: "esx:setJob" / QB-Core: "QBCore:Client:OnJobUpdate"
Config.PlayerSetJob = Config.Core == "ESX" and "esx:setJob" or "QBCore:Client:OnJobUpdate"


Config.Notification = function(message, time, type)
    if type == "success" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("STORE", message, time, "#36f230", "fa-solid fa-shop")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'success', time)
        end
    elseif type == "error" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("STORE", message, time, "#f23030", "fa-solid fa-shop")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'error', time)
        end
    elseif type == "info" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("STORE", message, time, "#4287f5", "fa-solid fa-shop")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'primary', time)
        end
    elseif type == "police_notify" then
        if GetResourceState("vms_notify") == 'started' then
            exports['vms_notify']:Notification("STORE ROBBERY", message, 10000, "#2499ff", "fa-solid fa-user-secret")
        else
            TriggerEvent('esx:showNotification', message)
            TriggerEvent('QBCore:Notify', message, 'primary', 10000)
        end
    end
end

Config.Interact = {
    Enabled = false,
    Open = function(message)
        exports["interact"]:Open("E", message) -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
    end,
    Close = function()
        exports["interact"]:Close() -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
    end
}

Config.Hud = {
    Enable = function()
        if GetResourceState('vms_hud') ~= 'missing' then
            exports['vms_hud']:Display(true)
        end
    end,
    Disable = function()
        if GetResourceState('vms_hud') ~= 'missing' then
            exports['vms_hud']:Display(false)
        end
    end
}

---@field AutoExecuteQuery boolean: Automatic execution of the creation of the vms_business table in database
Config.AutoExecuteQuery = true

---@field DebugPolyZone boolean: Option only for developers to recognize the registration of polyzone store object, and facilitate the creation of new
Config.DebugPolyZone = false

---@field Debug boolean: By running debugging, you will receive prints at various activities, in case of any problems, this will be able to help you find the cause of the misconfiguration.
Config.Debug = true

---@field UseProgressbar boolean: If you want to use a progress-bar for the exercises you are doing, you can do so below.
Config.UseProgressbar = false -- (config.client.lua - CL.Progressbar)

---@field UseTarget boolean: Do you want to use target system
Config.UseTarget = false
Config.TargetResource = 'ox_target' -- Prepared for 'ox_target', 'qb-target', 'qtarget' (config.client.lua - CL.Target)

Config.UseMarkers = true -- Using a marker to display points
Config.UseText3D = false -- Using a 3D Text to display points
Config.UseHelpNotify = true -- Using a ESX.ShowHelpNotification (only for esx)

Config.MaxItemsWithoutBasket = 5
Config.MaxItemsInBasket = 100

---@class PurchaseProductsLimit This class allows you to put limits on product purchases per player.
Config.PurchaseProductsLimit = {
    -- ['coffee'] = 1
    -- ['ecola'] = 30
}

Config.DisableRunWithBoxInHands = false

---@field StoresLimitPerPlayer number: Limit of stores to be owned by one player
--[[
    -1 = Unlimited
    0 = No player can buy
]]
Config.StoresLimitPerPlayer = 1

---@field RequiredJobToBeHired string | nil: Do you want to prevent the employment of a player who has another job, if so, you can require the employment of only the person who has a job for example - unemployed
Config.RequiredJobToBeHired = nil

---@field SaveTimeout number: Time every time the stores should refresh to save the status or delete it when the liquidation time has passed
Config.SaveTimeout = 30 * 60000

---@field PurchasesTimeout number: Prevent multiple purchases of products by the same person so that fiends don't scoop up product sales for their own store
Config.PurchasesTimeout = 3600 -- 3600 seconds = 1 hour

Config.BasketManageKey = 246 -- Y

Config.Marker = {
    ['products'] = {
        distanceSee = 2.75,
        distanceAccess = 1.0,
        type = 20,
        color = {62, 78, 158, 180},
        rotation = vec(0.0, 180.0, 0.0),
        scale = vec(0.15, 0.15, 0.15),
        bobUpAndDown = false,
        rotate = true,
    },
    ['buy'] = {
        distanceSee = 2.75,
        distanceAccess = 1.0,
        type = 20,
        color = {142, 255, 77, 180},
        rotation = vec(0.0, 180.0, 0.0),
        scale = vec(0.15, 0.15, 0.15),
        bobUpAndDown = false,
        rotate = true,
    },
    ['cashier'] = {
        distanceSee = 2.75,
        distanceAccess = 1.0,
        type = 20,
        color = {252, 198, 3, 180},
        rotation = vec(0.0, 180.0, 0.0),
        scale = vec(0.15, 0.15, 0.15),
        bobUpAndDown = false,
        rotate = true,
    },
    ['basket'] = {
        distanceSee = 2.75,
        distanceAccess = 1.0,
        type = 20,
        color = {94, 252, 3, 180},
        rotation = vec(0.0, 180.0, 0.0),
        scale = vec(0.15, 0.15, 0.15),
        bobUpAndDown = false,
        rotate = true,
    },
    ['purchase'] = {
        distanceSee = 2.75,
        distanceAccess = 1.0,
        type = 20,
        color = {252, 198, 3, 180},
        rotation = vec(0.0, 180.0, 0.0),
        scale = vec(0.15, 0.15, 0.15),
        bobUpAndDown = false,
        rotate = true,
    },
    ['management'] = {
        distanceSee = 2.75,
        distanceAccess = 1.0,
        type = 20,
        color = {252, 198, 3, 180},
        rotation = vec(0.0, 180.0, 0.0),
        scale = vec(0.15, 0.15, 0.15),
        bobUpAndDown = false,
        rotate = true,
    },
    ['destroy_cameras'] = {
        distanceSee = 2.75,
        distanceAccess = 1.75,
        type = 20,
        color = {252, 198, 3, 180},
        rotation = vec(0.0, 180.0, 0.0),
        scale = vec(0.15, 0.15, 0.15),
        bobUpAndDown = false,
        rotate = true,
    },
}

Config.Blips = {
    ['store'] = {
        sprite = 313,
        display = 4,
        scale = 0.0,
        color = 59,
        name = "Store"
    },
    ['owned_store'] = {
        sprite = 313,
        display = 4,
        scale = 1.0,
        color = 45,
        name = "Your Store"
    },
    ['delivery'] = {
        sprite = 52,
        display = 4,
        scale = 1.2,
        color = 38,
        routeColor = 38,
        name = "Delivery"
    },
    ['wholesale'] = {
        sprite = 478,
        display = 6,
        scale = 1.2,
        color = 28,
        routeColor = 28,
        name = "Wholesale"
    },
}

Config.Wholesales = {
    ['A'] = {
        label = 'Automatics',
        vehicle = "mule3",
        orderLimitsDefault = {1, 5, 10},
        products = {
            ['WEAPON_SWP2BLACKAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BLUEAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BROWNAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GOLDAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GRAYAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GREENAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2LAVAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2MINTAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2ORANGEAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2PINKAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2PURPAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2REDAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2WHITEAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2YELLOWAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2NFAK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2AR15NS'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2ARPBULLDOG'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BTANARP'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2ARP3IN'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOBLACK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOBLUE'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOBROWN'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOGOLD'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOGRAY'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOGREEN'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOLAV'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOMINT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACONF'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOORANGE'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOPINK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOPURP'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACORED'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOWHITE'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DRACOYELLOW'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2NFDRACO'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2TEC9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2MCKGLOCK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2TSCAR'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GR300BO'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BLACKMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BLUEMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BROWNMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GOLDMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GRAYMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GREENMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2LAVMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2MINTMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2ORANGEMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2PINKMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2PURPMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2REDMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2WHITEMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2YELLOWMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2NFMP9'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2MP5'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2P90'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2UZI'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2MPX'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            -- Premium Add-on Pack
            ['WEAPON_SWP23DGLOCK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BLACKM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BLUEM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BROWNM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GOLDM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GRAYM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GREENM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2LAVM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2MINTM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2NFM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2ORANGEM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2PINKM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2PURPM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2REDM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2WHITEM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2YELLOWM4'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2VECTOR'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BBGUN'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
        },
        points = {
            {
                coords = vector4(971.6671, -2220.6541, 30.5969, 87.7768),
                packs = {
                    ['1'] = { -- Level 1
                        [1] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(986.479, -2218.444, 31.458, -55.712), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(987.492, -2218.557, 31.458, -92.448), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [3] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(988.451, -2218.597, 31.458, -136.390), attachToVeh = {0.5, -0.6, 0.1, 0.0, 0.0, 90.0}}
                    },
                    ['2'] = { -- Level 2
                        [1] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(987.492, -2218.557, 31.458, -92.448), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(988.451, -2218.597, 31.458, -136.390), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                    },
                    ['3'] = { -- Level 3
                        [1] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(988.451, -2218.597, 31.458, -136.390), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                    },
                }
            },
        },
    },
    ['B'] = {
        label = 'Shotguns',
        vehicle = "mule3",
        orderLimitsDefault = {1, 5, 10},
        products = {
            ['WEAPON_SWP2SAWNOFF'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
        },
        points = {
            {
                coords = vector4(971.6671, -2220.6541, 30.5969, 87.7768),
                packs = {
                    ['1'] = { -- Level 1
                        [1] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(986.479, -2218.444, 31.458, -55.712), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(987.492, -2218.557, 31.458, -92.448), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [3] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(988.451, -2218.597, 31.458, -136.390), attachToVeh = {0.5, -0.6, 0.1, 0.0, 0.0, 90.0}}
                    },
                    ['2'] = { -- Level 2
                        [1] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(987.492, -2218.557, 31.458, -92.448), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(988.451, -2218.597, 31.458, -136.390), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                    },
                    ['3'] = { -- Level 3
                        [1] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(988.451, -2218.597, 31.458, -136.390), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                    },
                }
            },
        },
    },
    ['C'] = {
        label = 'Handguns',
        vehicle = "mule3",
        orderLimitsDefault = {1, 5, 10},
        products = {
            ['WEAPON_SWP2BAGGLOCK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2G17MOSMH'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2TG17S'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BG26'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2PG43XS'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2G18C'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2G19CS'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2G19T'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2G22S'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2G41CS'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2B57'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2DE'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2G23B'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2G21GC'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2RUGER'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2P22'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP238S'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2UGLOCK'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
        },
        points = {
            {
                coords = vector4(971.6671, -2220.6541, 30.5969, 87.7768),
                packs = {
                    ['1'] = { -- Level 1
                        [1] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(986.479, -2218.444, 31.458, -55.712), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(987.492, -2218.557, 31.458, -92.448), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [3] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(988.451, -2218.597, 31.458, -136.390), attachToVeh = {0.5, -0.6, 0.1, 0.0, 0.0, 90.0}}
                    },
                    ['2'] = { -- Level 2
                        [1] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(987.492, -2218.557, 31.458, -92.448), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(988.451, -2218.597, 31.458, -136.390), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                    },
                    ['3'] = { -- Level 3
                        [1] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(988.451, -2218.597, 31.458, -136.390), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                    },
                }
            },
        },
    },
    ['D'] = {
        label = 'Melees',
        vehicle = "mule3",
        orderLimitsDefault = {1, 5, 10},
        products = {
            ['WEAPON_SWP2BLACKBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BLUEBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BROWNBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GOLDBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GRAYBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2GREENBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2LAVBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2MINTBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2ORANGEBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2PINKBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2PURPBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2REDBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2WHITEBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2YELLOWBAT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2KNIFE'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2RPIPE'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2HATCHET'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BELT'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
            ['WEAPON_SWP2BOXCUTTER'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1,5,10}, ['2'] = {1,5,10,15}, ['3'] = {1,5,15,20} } },
        },
        points = {
            {
                coords = vector4(971.6671, -2220.6541, 30.5969, 87.7768),
                packs = {
                    ['1'] = { -- Level 1
                        [1] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(986.479, -2218.444, 31.458, -55.712), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(987.492, -2218.557, 31.458, -92.448), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [3] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(988.451, -2218.597, 31.458, -136.390), attachToVeh = {0.5, -0.6, 0.1, 0.0, 0.0, 90.0}}
                    },
                    ['2'] = { -- Level 2
                        [1] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(987.492, -2218.557, 31.458, -92.448), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(988.451, -2218.597, 31.458, -136.390), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                    },
                    ['3'] = { -- Level 3
                        [1] = {prop = 'ch_prop_ch_crate_full_01a', coords = vector4(988.451, -2218.597, 31.458, -136.390), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                    },
                }
            },
        },
    },
    ['E'] = {
        label = 'Ammunition',
        vehicle = "mule3",
        orderLimitsDefault = {50, 100, 150},
        products = {
            ['ammo-9']   = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {50, 100, 150}, ['2'] = {50, 100, 150, 200}, ['3'] = {50, 100, 150, 200, 250} } },
            ['ammo-10']  = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {50, 100, 150}, ['2'] = {50, 100, 150, 200}, ['3'] = {50, 100, 150, 200, 250} } },
            ['ammo-22']  = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {50, 100, 150}, ['2'] = {50, 100, 150, 200}, ['3'] = {50, 100, 150, 200, 250} } },
            ['ammo-40']  = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {50, 100, 150}, ['2'] = {50, 100, 150, 200}, ['3'] = {50, 100, 150, 200, 250} } },
            ['ammo-45']  = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {50, 100, 150}, ['2'] = {50, 100, 150, 200}, ['3'] = {50, 100, 150, 200, 250} } },
            ['ammo-556'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {50, 100, 150}, ['2'] = {50, 100, 150, 200}, ['3'] = {50, 100, 150, 200, 250} } },
            ['ammo-762'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {50, 100, 150}, ['2'] = {50, 100, 150, 200}, ['3'] = {50, 100, 150, 200, 250} } },
            ['ammo-50']  = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {50, 100, 150}, ['2'] = {50, 100, 150, 200}, ['3'] = {50, 100, 150, 200, 250} } },
            ['ammo-12']  = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {50, 100, 150}, ['2'] = {50, 100, 150, 200}, ['3'] = {50, 100, 150, 200, 250} } },
            ['ammo-bbs'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {50, 100, 150}, ['2'] = {50, 100, 150, 200}, ['3'] = {50, 100, 150, 200, 250} } },
        },
        points = {
            {
                coords = vector4(971.6671, -2220.6541, 30.5969, 87.7768), 
                packs = {
                    ['1'] = { -- Level 1
                        [1] = {prop = 'm23_1_prop_m31_roostercrate_03a', coords = vector4(986.688, -2217.266, 31.45, -3.95), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'm23_1_prop_m31_roostercrate_03a', coords = vector4(985.531, -2217.349, 31.45, -3.95), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [3] = {prop = 'm23_1_prop_m31_roostercrate_03a', coords = vector4(985.531, -2217.349, 31.45, -3.95), attachToVeh = {0.5, -0.6, 0.1, 0.0, 0.0, 90.0}},
                    },
                    ['2'] = { -- Level 2
                        [1] = {prop = 'm23_1_prop_m31_roostercrate_03a', coords = vector4(985.531, -2217.349, 31.45, -3.95), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'm23_1_prop_m31_roostercrate_03a', coords = vector4(985.531, -2217.349, 31.45, -3.95), attachToVeh = {0.5, -0.6, 0.1, 0.0, 0.0, 90.0}},
                    },
                    ['3'] = { -- Level 3
                        [1] = {prop = 'm23_1_prop_m31_roostercrate_03a', coords = vector4(985.531, -2217.349, 31.45, -3.95), attachToVeh = {0.5, -0.6, 0.1, 0.0, 0.0, 90.0}},
                    },
                }
            },
        },
    },
    ['F'] = {
        label = 'Attachments',
        vehicle = "mule3",
        orderLimitsDefault = {1, 5},
        products = {
            ['at_box_drum'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1, 5}, ['2'] = {1, 5, 10}, ['3'] = {1, 5, 10, 15} } },
            ['at_clear_drum'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1, 5}, ['2'] = {1, 5, 10}, ['3'] = {1, 5, 10, 15} } },
            ['at_clear_extended'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1, 5}, ['2'] = {1, 5, 10}, ['3'] = {1, 5, 10, 15} } },
            ['at_kriss_mag'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1, 5}, ['2'] = {1, 5, 10}, ['3'] = {1, 5, 10, 15} } },
            ['at_flashlight'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1, 5}, ['2'] = {1, 5, 10}, ['3'] = {1, 5, 10, 15} } },
            ['at_laser'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1, 5}, ['2'] = {1, 5, 10}, ['3'] = {1, 5, 10, 15} } },
            ['at_optic'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1, 5}, ['2'] = {1, 5, 10}, ['3'] = {1, 5, 10, 15} } },
            ['at_grip'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1, 5}, ['2'] = {1, 5, 10}, ['3'] = {1, 5, 10, 15} } },
            ['at_suppressor'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1, 5}, ['2'] = {1, 5, 10}, ['3'] = {1, 5, 10, 15} } },
            ['at_magazine'] = { orderPrice = 0.7, orderReward = 0.5, orderLimits = { ['1'] = {1, 5}, ['2'] = {1, 5, 10}, ['3'] = {1, 5, 10, 15} } },
        },
        points = {
            {
                coords = vector4(195.02, 6381.31, 30.63, 298.38), 
                packs = {
                    ['1'] = { -- Level 1
                        [1] = {prop = 'gr_prop_gr_rsply_crate01a', coords = vector4(187.982, 6376.274, 31.33, -81.93), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'gr_prop_gr_rsply_crate01a', coords = vector4(189.82, 6375.97, 31.33, 2.93), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [3] = {prop = 'gr_prop_gr_rsply_crate01a', coords = vector4(188.31, 6377.24, 31.34, 129.1), attachToVeh = {0.5, -0.6, 0.1, 0.0, 0.0, 90.0}},
                    },
                    ['2'] = { -- Level 2
                        [1] = {prop = 'gr_prop_gr_rsply_crate01a', coords = vector4(189.82, 6375.97, 31.33, 2.93), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'gr_prop_gr_rsply_crate01a', coords = vector4(188.31, 6377.24, 31.34, 129.1), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                    },
                    ['3'] = { -- Level 3
                        [1] = {prop = 'gr_prop_gr_rsply_crate01a', coords = vector4(189.82, 6375.97, 31.33, 2.93), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                    },
                }
            },
        },
    },
    ['G'] = {
        label = 'Other',
        vehicle = "mule3",
        orderLimitsDefault = {1},
        products = {
            ['switch'] = {orderPrice = 0.2, orderReward = 0.8, orderLimits = { ['1'] = {1}, ['2'] = {1, 5}, ['3'] = {1, 5, 10} }},
        },
        points = {
            {
                coords = vector4(1971.5334, 3847.6265, 32.3670, 300.0045), 
                packs = {
                    ['1'] = { -- Level 1
                        [1] = {prop = 'sm_prop_smug_crate_s_bones', coords = vector4(1959.504, 3840.429, 32.09, 110.0), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'sm_prop_smug_crate_s_bones', coords = vector4(1959.703, 3839.477, 31.528, 91.2), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [3] = {prop = 'sm_prop_smug_crate_s_bones', coords = vector4(1959.921, 3841.174, 33.056, 119.5), attachToVeh = {0.5, -0.6, 0.1, 0.0, 0.0, 90.0}},
                    },
                    ['2'] = { -- Level 2
                        [1] = {prop = 'sm_prop_smug_crate_s_bones', coords = vector4(1959.703, 3839.477, 31.528, 91.2), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                        [2] = {prop = 'sm_prop_smug_crate_s_bones', coords = vector4(1959.921, 3841.174, 33.056, 119.5), attachToVeh = {-0.25, 0.3, 0.1, 0.0, 0.0, 90.0}},
                    },
                    ['3'] = { -- Level 3
                        [1] = {prop = 'sm_prop_smug_crate_s_bones', coords = vector4(1959.921, 3841.174, 33.056, 119.5), attachToVeh = {0.5, 0.3, 0.1, 0.0, 0.0, 90.0}},
                    },
                }
            },
        },
    }
}

Config.ShelvesProducts = {
    ['Weapons'] = {
        -- V2
        -- AK-47 (Base + Color Flags)
        ['WEAPON_SWP2NFAK'] = { name = 'WEAPON_SWP2NFAK', label = 'AK-47', price = 110000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BBAK'] = { name = 'WEAPON_SWP2BBAK', label = 'AK-47 with Baby Blue Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BLACKAK'] = { name = 'WEAPON_SWP2BLACKAK', label = 'AK-47 with Black Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BLUEAK'] = { name = 'WEAPON_SWP2BLUEAK', label = 'AK-47 with Blue Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BROWNAK'] = { name = 'WEAPON_SWP2BROWNAK', label = 'AK-47 with Brown Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2GOLDAK'] = { name = 'WEAPON_SWP2GOLDAK', label = 'AK-47 with Gold Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2GRAYAK'] = { name = 'WEAPON_SWP2GRAYAK', label = 'AK-47 with Gray Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2GREENAK'] = { name = 'WEAPON_SWP2GREENAK', label = 'AK-47 with Green Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2LAVAK'] = { name = 'WEAPON_SWP2LAVAK', label = 'AK-47 with Lavender Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2MINTAK'] = { name = 'WEAPON_SWP2MINTAK', label = 'AK-47 with Mint Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2ORANGEAK'] = { name = 'WEAPON_SWP2ORANGEAK', label = 'AK-47 with Orange Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2PINKAK'] = { name = 'WEAPON_SWP2PINKAK', label = 'AK-47 with Pink Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2PURPAK'] = { name = 'WEAPON_SWP2PURPAK', label = 'AK-47 with Purple Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2REDAK'] = { name = 'WEAPON_SWP2REDAK', label = 'AK-47 with Red Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2WHITEAK'] = { name = 'WEAPON_SWP2WHITEAK', label = 'AK-47 with White Flag', price = 85000, tax = 'products.Automatics' },
        ['WEAPON_SWP2YELLOWAK'] = { name = 'WEAPON_SWP2YELLOWAK', label = 'AK-47 with Yellow Flag', price = 85000, tax = 'products.Automatics' },
        -- AR / SMGs
        ['WEAPON_SWP2AR15NS'] = { name = 'WEAPON_SWP2AR15NS', label = 'AR-15 No Stock', price = 97529, tax = 'products.Automatics' },
        ['WEAPON_SWP2ARPBULLDOG'] = { name = 'WEAPON_SWP2ARPBULLDOG', label = 'ARP Bulldog', price = 92500, tax = 'products.Automatics' },
        ['WEAPON_SWP2BTANARP'] = { name = 'WEAPON_SWP2BTANARP', label = 'ARP Black Tan', price = 83000, tax = 'products.Automatics' },
        ['WEAPON_SWP2ARP3IN'] = { name = 'WEAPON_SWP2ARP3IN', label = 'ARP 3-Inch Shellcatcher', price = 84500, tax = 'products.Automatics' },
        -- Draco (Base + Flags)
        ['WEAPON_SWP2DRACONF'] = { name = 'WEAPON_SWP2DRACONF', label = 'Draco', price = 100000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOBB'] = { name = 'WEAPON_SWP2DRACOBB', label = 'Draco with Baby Blue Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOBLACK'] = { name = 'WEAPON_SWP2DRACOBLACK', label = 'Draco with Black Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOBLUE'] = { name = 'WEAPON_SWP2DRACOBLUE', label = 'Draco with Blue Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOBROWN'] = { name = 'WEAPON_SWP2DRACOBROWN', label = 'Draco with Brown Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOGOLD'] = { name = 'WEAPON_SWP2DRACOGOLD', label = 'Draco with Gold Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOGRAY'] = { name = 'WEAPON_SWP2DRACOGRAY', label = 'Draco with Gray Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOGREEN'] = { name = 'WEAPON_SWP2DRACOGREEN', label = 'Draco with Green Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOLAV'] = { name = 'WEAPON_SWP2DRACOLAV', label = 'Draco with Lavender Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOMINT'] = { name = 'WEAPON_SWP2DRACOMINT', label = 'Draco with Mint Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOORANGE'] = { name = 'WEAPON_SWP2DRACOORANGE', label = 'Draco with Orange Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOPINK'] = { name = 'WEAPON_SWP2DRACOPINK', label = 'Draco with Pink Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOPURP'] = { name = 'WEAPON_SWP2DRACOPURP', label = 'Draco with Purple Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACORED'] = { name = 'WEAPON_SWP2DRACORED', label = 'Draco with Red Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOWHITE'] = { name = 'WEAPON_SWP2DRACOWHITE', label = 'Draco with White Flag', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2DRACOYELLOW'] = { name = 'WEAPON_SWP2DRACOYELLOW', label = 'Draco with Yellow Flag', price = 75000, tax = 'products.Automatics' },
        -- Other Fullys
        ['WEAPON_SWP2BLACKOUTAK'] = { name = 'WEAPON_SWP2BLACKOUTAK', label = 'Blackout AK-47', price = 150000, tax = 'products.Automatics' },
        ['WEAPON_SWP2TEC9'] = { name = 'WEAPON_SWP2TEC9', label = 'Tec-9', price = 99000, tax = 'products.Automatics' },
        ['WEAPON_SWP2MCKGLOCK'] = { name = 'WEAPON_SWP2MCKGLOCK', label = 'Glock w/ MCK Kit', price = 92000, tax = 'products.Automatics' },
        ['WEAPON_SWP2TSCAR'] = { name = 'WEAPON_SWP2TSCAR', label = 'HK SCAR-H Tan', price = 165000, tax = 'products.Automatics' },
        ['WEAPON_SWP2GR300BO'] = { name = 'WEAPON_SWP2GR300BO', label = 'G-Rod 300 Blackout', price = 145000, tax = 'products.Automatics' },
        ['WEAPON_SWP2NFMP9'] = { name = 'WEAPON_SWP2NFMP9', label = 'MP9', price = 47200, tax = 'products.Automatics' },
        ['WEAPON_SWP2MP5'] = { name = 'WEAPON_SWP2MP5', label = 'HK MP5', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2P90'] = { name = 'WEAPON_SWP2P90', label = 'FN P90', price = 175000, tax = 'products.Automatics' },
        ['WEAPON_SWP2UZI'] = { name = 'WEAPON_SWP2UZI', label = 'Uzi 9mm', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_SWP2MPX'] = { name = 'WEAPON_SWP2MPX', label = 'MPX CQC Suppressed', price = 200000, tax = 'products.Automatics' },
        -- Premium Addon
        ['WEAPON_SWP23DGLOCK'] = { name = 'WEAPON_SWP23DGLOCK', label = '3D Printed Glock Switch Glowing', price = 150000, tax = 'products.Automatics' },
        -- M4A1 (Base + Color Flags)
        ['WEAPON_SWP2NFM4'] = { name = 'WEAPON_SWP2NFM4', label = 'M4A1', price = 100000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BBM4'] = { name = 'WEAPON_SWP2BBM4', label = 'M4A1 with Baby Blue Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BLACKM4'] = { name = 'WEAPON_SWP2BLACKM4', label = 'M4A1 with Black Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BLUEM4'] = { name = 'WEAPON_SWP2BLUEM4', label = 'M4A1 with Blue Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BROWNM4'] = { name = 'WEAPON_SWP2BROWNM4', label = 'M4A1 with Brown Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2GOLDM4'] = { name = 'WEAPON_SWP2GOLDM4', label = 'M4A1 with Gold Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2GRAYM4'] = { name = 'WEAPON_SWP2GRAYM4', label = 'M4A1 with Gray Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2GREENM4'] = { name = 'WEAPON_SWP2GREENM4', label = 'M4A1 with Green Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2LAVM4'] = { name = 'WEAPON_SWP2LAVM4', label = 'M4A1 with Lavender Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2MINTM4'] = { name = 'WEAPON_SWP2MINTM4', label = 'M4A1 with Mint Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2ORANGEM4'] = { name = 'WEAPON_SWP2ORANGEM4', label = 'M4A1 with Orange Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2PINKM4'] = { name = 'WEAPON_SWP2PINKM4', label = 'M4A1 with Pink Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2PURPM4'] = { name = 'WEAPON_SWP2PURPM4', label = 'M4A1 with Purple Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2REDM4'] = { name = 'WEAPON_SWP2REDM4', label = 'M4A1 with Red Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2WHITEM4'] = { name = 'WEAPON_SWP2WHITEM4', label = 'M4A1 with White Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2YELLOWM4'] = { name = 'WEAPON_SWP2YELLOWM4', label = 'M4A1 with Yellow Flag', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2VECTOR'] = { name = 'WEAPON_SWP2VECTOR', label = 'Kriss Vector', price = 45000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BBGUN'] = { name = 'WEAPON_SWP2BBGUN', label = 'Plastic BB Gun', price = 10000, tax = 'products.Automatics' },

        -- Shotguns
        ['WEAPON_SWP2SAWNOFF'] = { name = 'WEAPON_SWP2SAWNOFF', label = 'Snub Nose Shotty', price = 250000, tax = 'products.Automatics' },

        -- Handguns
        ['WEAPON_SWP2BAGGLOCK'] = { name = 'WEAPON_SWP2BAGGLOCK', label = 'Glock with Plastic Bag Shellcatcher', price = 92000, tax = 'products.Automatics' },
        ['WEAPON_SWP2G17MOSMH'] = { name = 'WEAPON_SWP2G17MOSMH', label = 'Glock 17 MOS w/ Mag Holder', price = 35200, tax = 'products.Automatics' },
        ['WEAPON_SWP2TG17S'] = { name = 'WEAPON_SWP2TG17S', label = 'Glock 17 Tan Switch', price = 65400, tax = 'products.Automatics' },
        ['WEAPON_SWP2BG26'] = { name = 'WEAPON_SWP2BG26', label = 'Glock 26 Blue', price = 33200, tax = 'products.Automatics' },
        ['WEAPON_SWP2PG43XS'] = { name = 'WEAPON_SWP2PG43XS', label = 'Glock 43X (Pink Switch)', price = 73100, tax = 'products.Automatics' },
        ['WEAPON_SWP2G18C'] = { name = 'WEAPON_SWP2G18C', label = 'Glock 18C', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWP2G19CS'] = { name = 'WEAPON_SWP2G19CS', label = 'Glock 19 Custom Switch', price = 64200, tax = 'products.Automatics' },
        ['WEAPON_SWP2G19T'] = { name = 'WEAPON_SWP2G19T', label = 'Glock 19 Tan Binary', price = 45200, tax = 'products.Automatics' },
        ['WEAPON_SWP2G22S'] = { name = 'WEAPON_SWP2G22S', label = 'Glock 22 Switch', price = 73200, tax = 'products.Automatics' },
        ['WEAPON_SWP2G41CS'] = { name = 'WEAPON_SWP2G41CS', label = 'Glock 41 Custom Switch', price = 83500, tax = 'products.Automatics' },
        ['WEAPON_SWP2B57'] = { name = 'WEAPON_SWP2B57', label = 'FN 57 Black Switch', price = 73800, tax = 'products.Automatics' },
        ['WEAPON_SWP2DE'] = { name = 'WEAPON_SWP2DE', label = 'Desert Eagle', price = 250000, tax = 'products.Automatics' },
        ['WEAPON_SWP2G23B'] = { name = 'WEAPON_SWP2G23B', label = 'Glock 23 Binary', price = 28300, tax = 'products.Automatics' },
        ['WEAPON_SWP2G21GC'] = { name = 'WEAPON_SWP2G21GC', label = 'Glock 21 Ghost Custom', price = 23000, tax = 'products.Automatics' },
        ['WEAPON_SWP2RUGER'] = { name = 'WEAPON_SWP2RUGER', label = 'Ruger 5.7', price = 22000, tax = 'products.Automatics' },
        ['WEAPON_SWP2P22'] = { name = 'WEAPON_SWP2P22', label = 'Walther P22', price = 11000, tax = 'products.Automatics' },
        ['WEAPON_SWP238S'] = { name = 'WEAPON_SWP238S', label = '.38 Special', price = 23000, tax = 'products.Automatics' },
        ['WEAPON_SWP2UGLOCK'] = { name = 'WEAPON_SWP2UGLOCK', label = 'Unauthorized Glock', price = 15000, tax = 'products.Automatics' },

        -- V1
        ['WEAPON_3DGLOCK'] = { name = 'WEAPON_3DGLOCK', label = '3D Printed Glock', price = 5000, tax = 'products.Automatics' },
        ['WEAPON_300BO'] = { name = 'WEAPON_300BO', label = '300 Blackout', price = 100000, tax = 'products.Automatics' },
        ['WEAPON_357SNUB'] = { name = 'WEAPON_357SNUB', label = 'S&W .357 Snubnose', price = 7500, tax = 'products.Automatics' },
        ['WEAPON_AR15S'] = { name = 'WEAPON_AR15S', label = 'AR-15 Special', price = 83000, tax = 'products.Automatics' },
        ['WEAPON_AKCATCHER'] = { name = 'WEAPON_AKCATCHER', label = 'AK-47 CQC Shellcatcher', price = 125000, tax = 'products.Automatics' },
        ['WEAPON_BAGGLOCK'] = { name = 'WEAPON_BAGGLOCK', label = 'Bagged Glock', price = 13000, tax = 'products.Automatics' },
        ['WEAPON_SWPBLACKARP'] = { name = 'WEAPON_SWPBLACKARP', label = 'ARP Black Flag', price = 35000, tax = 'products.Automatics' },
        ['WEAPON_BLACKKNIFE'] = { name = 'WEAPON_BLACKKNIFE', label = 'Knife Black Flag', price = 10000, tax = 'products.Automatics' },
        ['WEAPON_BLACKSWITCH'] = { name = 'WEAPON_BLACKSWITCH', label = 'Glock 18 Black Switch', price = 56000, tax = 'products.Automatics' },
        ['WEAPON_SWPBLUEARP'] = { name = 'WEAPON_SWPBLUEARP', label = 'ARP Blue Flag', price = 35000, tax = 'products.Automatics' },
        ['WEAPON_BLUEKNIFE'] = { name = 'WEAPON_BLUEKNIFE', label = 'Knife Blue Flag', price = 10000, tax = 'products.Automatics' },
        ['WEAPON_BLUESWITCH'] = { name = 'WEAPON_BLUESWITCH', label = 'Glock 18 Blue Switch', price = 60000, tax = 'products.Automatics' },
        ['WEAPON_FN57B'] = { name = 'WEAPON_FN57B', label = 'FN-57 Binary', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_FN509HUNT'] = { name = 'WEAPON_FN509HUNT', label = 'FN-509 Hunting', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_GRAYARP'] = { name = 'WEAPON_GRAYARP', label = 'ARP Gray Flag', price = 35000, tax = 'products.Automatics' },
        ['WEAPON_GRAYKNIFE'] = { name = 'WEAPON_GRAYKNIFE', label = 'Knife Gray Flag', price = 10000, tax = 'products.Automatics' },
        ['WEAPON_GRAYSWITCH'] = { name = 'WEAPON_GRAYSWITCH', label = 'Glock 18 Gray Switch', price = 60000, tax = 'products.Automatics' },
        ['WEAPON_GREENARP'] = { name = 'WEAPON_GREENARP', label = 'ARP Green Flag', price = 35000, tax = 'products.Automatics' },
        ['WEAPON_GREENKNIFE'] = { name = 'WEAPON_GREENKNIFE', label = 'Knife Green Flag', price = 10000, tax = 'products.Automatics' },
        ['WEAPON_GREENSWITCH'] = { name = 'WEAPON_GREENSWITCH', label = 'Glock 18 Green Switch', price = 80000, tax = 'products.Automatics' },
        ['WEAPON_G19BEAM'] = { name = 'WEAPON_G19BEAM', label = 'Glock 19 with Beam', price = 39000, tax = 'products.Automatics' },
        ['WEAPON_G22'] = { name = 'WEAPON_G22', label = 'Glock 22', price = 15000, tax = 'products.Automatics' },
        ['WEAPON_G22B'] = { name = 'WEAPON_G22B', label = 'Glock 22 Binary', price = 34000, tax = 'products.Automatics' },
        ['WEAPON_G43X'] = { name = 'WEAPON_G43X', label = 'Glock 43X', price = 23000, tax = 'products.Automatics' },
        ['WEAPON_GHOSTG30'] = { name = 'WEAPON_GHOSTG30', label = 'Glock 30 Ghost Custom', price = 61000, tax = 'products.Automatics' },
        ['WEAPON_GP80C'] = { name = 'WEAPON_GP80C', label = 'Glock P80 Custom Switch', price = 63000, tax = 'products.Automatics' },
        ['WEAPON_KTECPLR'] = { name = 'WEAPON_KTECPLR', label = 'Kel-Tec PLR-16', price = 15000, tax = 'products.Automatics' },
        ['WEAPON_LILUZI'] = { name = 'WEAPON_LILUZI', label = 'Uzi', price = 33000, tax = 'products.Automatics' },
        ['WEAPON_MARP'] = { name = 'WEAPON_MARP', label = 'Micro ARP', price = 35000, tax = 'products.Automatics' },
        ['WEAPON_MDRACO'] = { name = 'WEAPON_MDRACO', label = 'Micro Draco', price = 75000, tax = 'products.Automatics' },
        ['WEAPON_MP5C'] = { name = 'WEAPON_MP5C', label = 'MP5 CQC', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_OPPSLUGGER'] = { name = 'WEAPON_OPPSLUGGER', label = 'Opp Slugger Bat', price = 10000, tax = 'products.Automatics' },
        ['WEAPON_ORANGEARP'] = { name = 'WEAPON_ORANGEARP', label = 'ARP Orange Flag', price = 35000, tax = 'products.Automatics' },
        ['WEAPON_ORANGEKNIFE'] = { name = 'WEAPON_ORANGEKNIFE', label = 'Knife Orange Flag', price = 10000, tax = 'products.Automatics' },
        ['WEAPON_ORANGESWITCH'] = { name = 'WEAPON_ORANGESWITCH', label = 'Glock 18 Orange Switch', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_PTX22'] = { name = 'WEAPON_PTX22', label = 'Taurus TX22 Pink', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_PINKARP'] = { name = 'WEAPON_PINKARP', label = 'ARP Pink Flag', price = 35000, tax = 'products.Automatics' },
        ['WEAPON_PINKKNIFE'] = { name = 'WEAPON_PINKKNIFE', label = 'Knife Pink Flag', price = 10000, tax = 'products.Automatics' },
        ['WEAPON_SWPPINKSWITCH'] = { name = 'WEAPON_SWPPINKSWITCH', label = 'Glock 18 Pink Switch', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_PURPLEARP'] = { name = 'WEAPON_PURPLEARP', label = 'ARP Purple Flag', price = 35000, tax = 'products.Automatics' },
        ['WEAPON_PURPLEKNIFE'] = { name = 'WEAPON_PURPLEKNIFE', label = 'Knife Purple Flag', price = 10000, tax = 'products.Automatics' },
        ['WEAPON_PURPLESWITCH'] = { name = 'WEAPON_PURPLESWITCH', label = 'Glock 18 Purple Switch', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWPREDARP'] = { name = 'WEAPON_SWPREDARP', label = 'ARP Red Flag', price = 35000, tax = 'products.Automatics' },
        ['WEAPON_REDKNIFE'] = { name = 'WEAPON_REDKNIFE', label = 'Knife Red Flag', price = 10000, tax = 'products.Automatics' },
        ['WEAPON_SWPREDSWITCH'] = { name = 'WEAPON_SWPREDSWITCH', label = 'Glock 18 Red Switch', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_R580'] = { name = 'WEAPON_R580', label = 'Remington 580', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SCORPIONX9'] = { name = 'WEAPON_SCORPIONX9', label = 'Scorpion X9 Evo', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SCREWD'] = { name = 'WEAPON_SCREWD', label = 'Rusty Screwdriver', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SLEDGEH'] = { name = 'WEAPON_SLEDGEH', label = 'Sledgehammer', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_STREETSWEEP'] = { name = 'WEAPON_STREETSWEEP', label = 'Street Sweeper', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SW357'] = { name = 'WEAPON_SW357', label = 'S&W .357 Revolver', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_SWMP9'] = { name = 'WEAPON_SWMP9', label = 'S&W M&P9', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_T247'] = { name = 'WEAPON_T247', label = 'Taurus 247', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_TANGLOCK'] = { name = 'WEAPON_TANGLOCK', label = 'Glock 17', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_UGLOCK'] = { name = 'WEAPON_UGLOCK', label = 'Unauthorized Glock', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_WHITEARP'] = { name = 'WEAPON_WHITEARP', label = 'ARP White Flag', price = 35000, tax = 'products.Automatics' },
        ['WEAPON_WHITEKNIFE'] = { name = 'WEAPON_WHITEKNIFE', label = 'Knife White Flag', price = 10000, tax = 'products.Automatics' },
        ['WEAPON_WHITESWITCH'] = { name = 'WEAPON_WHITESWITCH', label = 'Glock 18 White Switch', price = 50000, tax = 'products.Automatics' },
        ['WEAPON_WOODAXE'] = { name = 'WEAPON_WOODAXE', label = 'Wooden Axe', price = 10000, tax = 'products.Automatics' },
        ['WEAPON_YELLOWARP'] = { name = 'WEAPON_YELLOWARP', label = 'ARP Yellow Flag', price = 35000, tax = 'products.Automatics' },
        ['WEAPON_YELLOWKNIFE'] = { name = 'WEAPON_YELLOWKNIFE', label = 'Knife Yellow Flag', price = 10000, tax = 'products.Automatics' },
        ['WEAPON_YELLOWSWITCH'] = { name = 'WEAPON_YELLOWSWITCH', label = 'Glock 18 Yellow Switch', price = 50000, tax = 'products.Automatics' },
    },
    ['Melees'] = {
        -- Wooden Bats (All Colors)
        ['WEAPON_SWP2NFBAT'] = { name = 'WEAPON_SWP2NFBAT', label = 'Wooden Bat', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BBBAT'] = { name = 'WEAPON_SWP2BBBAT', label = 'Wooden Bat with Baby Blue Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BLACKBAT'] = { name = 'WEAPON_SWP2BLACKBAT', label = 'Wooden Bat with Black Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BLUEBAT'] = { name = 'WEAPON_SWP2BLUEBAT', label = 'Wooden Bat with Blue Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BROWNBAT'] = { name = 'WEAPON_SWP2BROWNBAT', label = 'Wooden Bat with Brown Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2GOLDBAT'] = { name = 'WEAPON_SWP2GOLDBAT', label = 'Wooden Bat with Gold Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2GRAYBAT'] = { name = 'WEAPON_SWP2GRAYBAT', label = 'Wooden Bat with Gray Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2GREENBAT'] = { name = 'WEAPON_SWP2GREENBAT', label = 'Wooden Bat with Green Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2LAVBAT'] = { name = 'WEAPON_SWP2LAVBAT', label = 'Wooden Bat with Lavender Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2MINTBAT'] = { name = 'WEAPON_SWP2MINTBAT', label = 'Wooden Bat with Mint Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2ORANGEBAT'] = { name = 'WEAPON_SWP2ORANGEBAT', label = 'Wooden Bat with Orange Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2PINKBAT'] = { name = 'WEAPON_SWP2PINKBAT', label = 'Wooden Bat with Pink Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2PURPBAT'] = { name = 'WEAPON_SWP2PURPBAT', label = 'Wooden Bat with Purple Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2REDBAT'] = { name = 'WEAPON_SWP2REDBAT', label = 'Wooden Bat with Red Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2WHITEBAT'] = { name = 'WEAPON_SWP2WHITEBAT', label = 'Wooden Bat with White Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2YELLOWBAT'] = { name = 'WEAPON_SWP2YELLOWBAT', label = 'Wooden Bat with Yellow Flag', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2KNIFE'] = { name = 'WEAPON_SWP2KNIFE', label = 'Kitchen Knife', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2RPIPE'] = { name = 'WEAPON_SWP2RPIPE', label = 'Rusty Bloody Pipe', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2HATCHET'] = { name = 'WEAPON_SWP2HATCHET', label = 'Hiking Hatchet', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BELT'] = { name = 'WEAPON_SWP2BELT', label = 'Leather Belt', price = 25000, tax = 'products.Automatics' },
        ['WEAPON_SWP2BOXCUTTER'] = { name = 'WEAPON_SWP2BOXCUTTER', label = 'Box Cutter', price = 25000, tax = 'products.Automatics' },
    },
    ['Attachments'] = {
        ['at_flashlight']      = { name = 'at_flashlight',      label = 'Flashlight',             price = 3700, tax = 'products.Attachments' },
        ['at_laser']           = { name = 'at_laser',           label = 'Laser',                  price = 3300, tax = 'products.Attachments' },
        ['at_optic']           = { name = 'at_optic',           label = 'Optic',                  price = 7300, tax = 'products.Attachments' },
        ['at_grip']            = { name = 'at_grip',            label = 'Grip',                   price = 3050, tax = 'products.Attachments' },
        ['at_suppressor']      = { name = 'at_suppressor',      label = 'Suppressor',             price = 7500, tax = 'products.Attachments' },
        ['at_magazine']        = { name = 'at_magazine',        label = 'Extended Magazine',      price = 5000, tax = 'products.Attachments' },
        ['swp2sdrum']        = { name = 'swp2sdrum',        label = 'Round Box Drum',      price = 10000, tax = 'products.Attachments' },
        ['swp2pistoldrum']        = { name = 'swp2pistoldrum',        label = 'Clear Drum',      price = 10000, tax = 'products.Attachments' },
        ['swp2clear30mag']        = { name = 'swp2clear30mag',        label = 'Clear Extended Mag',      price = 5000, tax = 'products.Attachments' },
        ['swp2krissmag']        = { name = 'swp2krissmag',        label = 'Kriss Magazine',      price = 5000, tax = 'products.Attachments' },
    },

    ['Ammunition'] = {
        ['ammo-bbs']        = { name = 'ammo-bbs',        label = 'BB Pellets Glowing', price = 1,   tax = 'products.Ammunition' },
        ['ammo-paintballs'] = { name = 'ammo-paintballs', label = 'Paintballs',         price = 1,   tax = 'products.Ammunition' },
        ['ammo-22']         = { name = 'ammo-22',         label = '.22',                price = 2,   tax = 'products.Ammunition' },
        ['ammo-57']         = { name = 'ammo-57',         label = '5.7mm',              price = 7,   tax = 'products.Ammunition' },
        ['ammo-45']         = { name = 'ammo-45',         label = '.45 ACP',            price = 4,   tax = 'products.Ammunition' },
        ['ammo-40']         = { name = 'ammo-40',         label = '.40',                price = 4,   tax = 'products.Ammunition' },
        ['ammo-9']          = { name = 'ammo-9',          label = '9mm',                price = 3,   tax = 'products.Ammunition' },
        ['ammo-10']         = { name = 'ammo-10',         label = '10mm',               price = 5,   tax = 'products.Ammunition' },
        ['ammo-556']        = { name = 'ammo-556',        label = '5.56',               price = 8,   tax = 'products.Ammunition' },
        ['ammo-762']        = { name = 'ammo-762',        label = '7.62',               price = 10,  tax = 'products.Ammunition' },
        ['ammo-44']         = { name = 'ammo-44',         label = '.44 Magnum',         price = 12,  tax = 'products.Ammunition' },
        ['ammo-12']         = { name = 'ammo-12',         label = '12 Gauge',           price = 15,  tax = 'products.Ammunition' },
        ['ammo-50']         = { name = 'ammo-50',         label = '50 BMG',             price = 100, tax = 'products.Ammunition' },
        ['ammo-357']        = { name = 'ammo-357',        label = '.357',               price = 15,  tax = 'products.Ammunition' },
    },
    ['Other'] = {
        ["switch"] = {name = "switch", label = "Switch", price = 500000, tax = 'products.Other'},
    },
}

Config.Fuel = {
    label = "Fuel",
    price = 8,
    tax = 'products.fuel'
}

Config.Stores = {
    ["gunstore_745"] = {
        type = 'shop',

        jobName = 'gunstore_745',
        cityhall_grades = { -- Grades for sections from vms_cityhall
            ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
            ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        },

        brand = "Gunstore 745",
        address = "745 Adams Apple Blvd, Pillbox Hill",
        price = 10000000,

        storeArea = { -- PolyZone
            vector2(29.3528, -1128.9122),
            vector2(64.9084, -1068.7656),
            vector2(1.8300, -1033.3740),
            vector2(-22.9193, -1121.3328)
        },
        minZ = 20.0,
        maxZ = 60.0,

        productsToOrder = {
            -- Automatics
            ['WEAPON_SWP2BLACKAK'] = true,
            ['WEAPON_SWP2BLUEAK'] = true,
            ['WEAPON_SWP2BROWNAK'] = true,
            ['WEAPON_SWP2GOLDAK'] = true,
            ['WEAPON_SWP2GRAYAK'] = true,
            ['WEAPON_SWP2GREENAK'] = true,
            ['WEAPON_SWP2LAVAK'] = true,
            ['WEAPON_SWP2MINTAK'] = true,
            ['WEAPON_SWP2ORANGEAK'] = true,
            ['WEAPON_SWP2PINKAK'] = true,
            ['WEAPON_SWP2PURPAK'] = true,
            ['WEAPON_SWP2REDAK'] = true,
            ['WEAPON_SWP2WHITEAK'] = true,
            ['WEAPON_SWP2YELLOWAK'] = true,
            ['WEAPON_SWP2NFAK'] = true,
            ['WEAPON_SWP2AR15NS'] = true,
            ['WEAPON_SWP2ARPBULLDOG'] = true,
            ['WEAPON_SWP2BTANARP'] = true,
            ['WEAPON_SWP2ARP3IN'] = true,
            ['WEAPON_SWP2DRACOBLACK'] = true,
            ['WEAPON_SWP2DRACOBLUE'] = true,
            ['WEAPON_SWP2DRACOBROWN'] = true,
            ['WEAPON_SWP2DRACOGOLD'] = true,
            ['WEAPON_SWP2DRACOGRAY'] = true,
            ['WEAPON_SWP2DRACOGREEN'] = true,
            ['WEAPON_SWP2DRACOLAV'] = true,
            ['WEAPON_SWP2DRACOMINT'] = true,
            ['WEAPON_SWP2DRACONF'] = true,
            ['WEAPON_SWP2DRACOORANGE'] = true,
            ['WEAPON_SWP2DRACOPINK'] = true,
            ['WEAPON_SWP2DRACOPURP'] = true,
            ['WEAPON_SWP2DRACORED'] = true,
            ['WEAPON_SWP2DRACOWHITE'] = true,
            ['WEAPON_SWP2DRACOYELLOW'] = true,
            ['WEAPON_SWP2NFDRACO'] = true,
            ['WEAPON_SWP2TEC9'] = true,
            ['WEAPON_SWP2MCKGLOCK'] = true,
            ['WEAPON_SWP2TSCAR'] = true,
            ['WEAPON_SWP2GR300BO'] = true,
            ['WEAPON_SWP2BLACKMP9'] = true,
            ['WEAPON_SWP2BLUEMP9'] = true,
            ['WEAPON_SWP2BROWNMP9'] = true,
            ['WEAPON_SWP2GOLDMP9'] = true,
            ['WEAPON_SWP2GRAYMP9'] = true,
            ['WEAPON_SWP2GREENMP9'] = true,
            ['WEAPON_SWP2LAVMP9'] = true,
            ['WEAPON_SWP2MINTMP9'] = true,
            ['WEAPON_SWP2ORANGEMP9'] = true,
            ['WEAPON_SWP2PINKMP9'] = true,
            ['WEAPON_SWP2PURPMP9'] = true,
            ['WEAPON_SWP2REDMP9'] = true,
            ['WEAPON_SWP2WHITEMP9'] = true,
            ['WEAPON_SWP2YELLOWMP9'] = true,
            ['WEAPON_SWP2NFMP9'] = true,
            ['WEAPON_SWP2MP5'] = true,
            ['WEAPON_SWP2P90'] = true,
            ['WEAPON_SWP2UZI'] = true,
            ['WEAPON_SWP2MPX'] = true,
            ['WEAPON_SWP23DGLOCK'] = true,
            ['WEAPON_SWP2BLACKM4'] = true,
            ['WEAPON_SWP2BLUEM4'] = true,
            ['WEAPON_SWP2BROWNM4'] = true,
            ['WEAPON_SWP2GOLDM4'] = true,
            ['WEAPON_SWP2GRAYM4'] = true,
            ['WEAPON_SWP2GREENM4'] = true,
            ['WEAPON_SWP2LAVM4'] = true,
            ['WEAPON_SWP2MINTM4'] = true,
            ['WEAPON_SWP2NFM4'] = true,
            ['WEAPON_SWP2ORANGEM4'] = true,
            ['WEAPON_SWP2PINKM4'] = true,
            ['WEAPON_SWP2PURPM4'] = true,
            ['WEAPON_SWP2REDM4'] = true,
            ['WEAPON_SWP2WHITEM4'] = true,
            ['WEAPON_SWP2YELLOWM4'] = true,
            ['WEAPON_SWP2VECTOR'] = true,
            ['WEAPON_SWP2BBGUN'] = true,

            -- Shotguns
            ['WEAPON_SWP2SAWNOFF'] = true,

            -- Handguns
            ['WEAPON_SWP2BAGGLOCK'] = true,
            ['WEAPON_SWP2G17MOSMH'] = true,
            ['WEAPON_SWP2TG17S'] = true,
            ['WEAPON_SWP2BG26'] = true,
            ['WEAPON_SWP2PG43XS'] = true,
            ['WEAPON_SWP2G18C'] = true,
            ['WEAPON_SWP2G19CS'] = true,
            ['WEAPON_SWP2G19T'] = true,
            ['WEAPON_SWP2G22S'] = true,
            ['WEAPON_SWP2G41CS'] = true,
            ['WEAPON_SWP2B57'] = true,
            ['WEAPON_SWP2DE'] = true,
            ['WEAPON_SWP2G23B'] = true,
            ['WEAPON_SWP2G21GC'] = true,
            ['WEAPON_SWP2RUGER'] = true,
            ['WEAPON_SWP2P22'] = true,
            ['WEAPON_SWP238S'] = true,
            ['WEAPON_SWP2UGLOCK'] = true,

            -- Melees
            ['WEAPON_SWP2BLACKBAT'] = true,
            ['WEAPON_SWP2BLUEBAT'] = true,
            ['WEAPON_SWP2BROWNBAT'] = true,
            ['WEAPON_SWP2GOLDBAT'] = true,
            ['WEAPON_SWP2GRAYBAT'] = true,
            ['WEAPON_SWP2GREENBAT'] = true,
            ['WEAPON_SWP2LAVBAT'] = true,
            ['WEAPON_SWP2MINTBAT'] = true,
            ['WEAPON_SWP2ORANGEBAT'] = true,
            ['WEAPON_SWP2PINKBAT'] = true,
            ['WEAPON_SWP2PURPBAT'] = true,
            ['WEAPON_SWP2REDBAT'] = true,
            ['WEAPON_SWP2WHITEBAT'] = true,
            ['WEAPON_SWP2YELLOWBAT'] = true,
            ['WEAPON_SWP2KNIFE'] = true,
            ['WEAPON_SWP2RPIPE'] = true,
            ['WEAPON_SWP2HATCHET'] = true,
            ['WEAPON_SWP2BELT'] = true,
            ['WEAPON_SWP2BOXCUTTER'] = true,

            -- Attachments
            ['at_flashlight'] = true,
            ['at_laser'] = true,
            ['at_optic'] = true,
            ['at_grip'] = true,
            ['at_suppressor'] = true,
            ['at_magazine'] = true,

            -- Ammunition
            ['ammo-9'] = true,
            ['ammo-10'] = true,
            ['ammo-22'] = true,
            ['ammo-40'] = true,
            ['ammo-45'] = true,
            ['ammo-556'] = true,
            ['ammo-762'] = true,
            ['ammo-50'] = true,
            ['ammo-12'] = true,
            ['ammo-bbs'] = true,

            -- Other
            ['switch'] = true,
        },

        blipId = 'store', -- Config.Blips (such a blip will be known to anyone who is not an employee or owner)
        blipOwnedId = 'owned_store', -- Config.Blips (if you are an employee or owner)
        blipPoint = vector3(15.7438, -1118.8442, 28.9880),

        vehiclePoint = vector4(-9.1247, -1114.3059, 28.2729, 160.1718),
        --trailerPoint = vector4(-0.3901, -1127.5902, 28.0072, 93.9015),
        deliveryPoint = vector3(-10.6473, -1119.2094, 27.5244),
        warehousePoint = {
            coords = vector3(30.5954, -1079.5264, 27.7232),
            targetCoords = vector3(30.5954, -1079.5264, 27.7232),
            targetHeading = 342.6291,
            targetSize = vec(2.2, 2.2, 3.75),
        },

        --[[basketPoint = {
            coords = vector3(13.0768, -1111.8622, 29.0955),
            targetCoords = vector3(13.0768, -1111.8622, 29.0955),
            targetHeading = 170.6180,
            targetSize = vec(0.5, 0.4, 0.65),
        },]]
        managementPoint = {
            coords = vector3(11.9956, -1094.6638, 33.2521),
            targetCoords = vector3(11.9956, -1094.6638, 33.2521),
            targetHeading = 339.3818,
            targetSize = vec(1.8, 1.0, 1.5),
        },
        safePoint = {
            coords = vector3(32.1930, -1075.8500, 27.7232),
            targetCoords = vector3(32.1930, -1075.8500, 27.7232),
            targetHeading = 347.1949,
            targetSize = vec(0.75, 0.7, 1.15),
        },

        moneyEscortSpawnPoint = vector4(46.0658, -990.1530, 29.2977, 249.6113), -- If you use onesync infinity, don't set the point too far away because it will cause problems.
        moneyEscortArrivalPoint = vector3(38.4250, -1106.5649, 29.1961),

        camerasPoints = {
            [1] = {
                coords = vector3(22.459, -1117.193, 29.021),
                rotation = vec(0, 0, 0),
                objHeading = 0.0, -- objHeading is reversed
                maxLeft = 325.0,
                maxRight = 70.0
            }
        },

        points = {
            ['Automatics'] = {
                coords = vector3(14.8049, -1106.8727, 29.1092),
                targetCoords = vector3(14.8049, -1106.8727, 29.1092),
                targetHeading = 338.4565,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Shotguns'] = {
                coords = vector3(10.7194, -1104.7212, 29.1093),
                targetCoords = vector3(10.7194, -1104.7212, 29.1093),
                targetHeading = 302.0342,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Handguns'] = {
                coords = vector3(6.2172, -1105.8766, 29.1092),
                targetCoords = vector3(6.2172, -1105.8766, 29.1092),
                targetHeading = 77.7632,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Melees'] = {
                coords = vector3(7.6936, -1107.2782, 29.1092),
                targetCoords = vector3(7.6936, -1107.2782, 29.1092),
                targetHeading = 158.8097,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Ammunition'] = {
                coords = vector3(10.0865, -1110.3837, 29.1093),
                targetCoords = vector3(10.0865, -1110.3837, 29.1093),
                targetHeading = 64.6486,
                targetSize = vec(2.1, 0.95, 1.65),
            },
            ['Attachments'] = {
                coords = vector3(9.7853, -1108.8062, 29.1093),
                targetCoords = vector3(9.7853, -1108.8062, 29.1093),
                targetHeading = 118.5212,
                targetSize = vec(2.9, 0.6, 2.5),
            },
            ['Other'] = {
                coords = vector3(12.6266, -1106.0591, 29.1092),
                targetCoords = vector3(12.6266, -1106.0591, 29.1092),
                targetHeading = 348.1986,
                targetSize = vec(2.9, 0.6, 2.5),
            },
            ['buy'] = {
                coords = {
                    [1] = vector3(18.0255, -1105.6848, 29.1092),
                },
                targetCoords = {
                    [1] = vector3(18.0255, -1105.6848, 29.1092),
                },
                targetHeading = 67.1704,
                targetSize = vec(0.7, 0.7, 0.5),
            },
        },
        cashierPoints = {
            [1] = {
                pedModel = "mp_m_shopkeep_01",
                coords = vector4(16.8471, -1105.1464, 28.1094, 261.0744)
            },
        },
    },
    ["gunstore_1"] = {
        type = 'shop',
        
        jobName = 'gunstore_1',
        cityhall_grades = { -- Grades for sections from vms_cityhall
            ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
            ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        },
        
        brand = "Gunstore 1",
        address = "687 Red Desert Avenue, Del Perro Beach",
        price = 10000000,

        storeArea = { -- PolyZone
            vector2(-1561.6028, -949.0826),
            vector2(-1595.5453, -921.8337),
            vector2(-1612.8018, -941.1080),
            vector2(-1575.9254, -967.0650)
        },
        minZ = -10.0,
        maxZ = 10.0,

        productsToOrder = {
            -- Weapons
            ['WEAPON_3DGLOCK'] = true,
            ['WEAPON_300BO'] = true,
            ['WEAPON_357SNUB'] = true,
            ['WEAPON_AR15S'] = true,
            ['WEAPON_AKCATCHER'] = true,
            ['WEAPON_BAGGLOCK'] = true,
            ['WEAPON_SWPBLACKARP'] = true,
            ['WEAPON_BLACKKNIFE'] = true,
            ['WEAPON_BLACKSWITCH'] = true,
            ['WEAPON_SWPBLUEARP'] = true,
            ['WEAPON_BLUEKNIFE'] = true,
            ['WEAPON_BLUESWITCH'] = true,
            ['WEAPON_FN57B'] = true,
            ['WEAPON_FN509HUNT'] = true,
            ['WEAPON_GRAYARP'] = true,
            ['WEAPON_GRAYKNIFE'] = true,
            ['WEAPON_GRAYSWITCH'] = true,
            ['WEAPON_GREENARP'] = true,
            ['WEAPON_GREENKNIFE'] = true,
            ['WEAPON_GREENSWITCH'] = true,
            ['WEAPON_G19BEAM'] = true,
            ['WEAPON_G22'] = true,
            ['WEAPON_G22B'] = true,
            ['WEAPON_G43X'] = true,
            ['WEAPON_GHOSTG30'] = true,
            ['WEAPON_GP80C'] = true,
            ['WEAPON_KTECPLR'] = true,
            ['WEAPON_LILUZI'] = true,
            ['WEAPON_MARP'] = true,
            ['WEAPON_MDRACO'] = true,
            ['WEAPON_MP5C'] = true,
            ['WEAPON_OPPSLUGGER'] = true,
            ['WEAPON_ORANGEARP'] = true,
            ['WEAPON_ORANGEKNIFE'] = true,
            ['WEAPON_ORANGESWITCH'] = true,
            ['WEAPON_PTX22'] = true,
            ['WEAPON_PINKARP'] = true,
            ['WEAPON_PINKKNIFE'] = true,
            ['WEAPON_SWPPINKSWITCH'] = true,
            ['WEAPON_PURPLEARP'] = true,
            ['WEAPON_PURPLEKNIFE'] = true,
            ['WEAPON_PURPLESWITCH'] = true,
            ['WEAPON_SWPREDARP'] = true,
            ['WEAPON_REDKNIFE'] = true,
            ['WEAPON_SWPREDSWITCH'] = true,
            ['WEAPON_R580'] = true,
            ['WEAPON_SCORPIONX9'] = true,
            ['WEAPON_SCREWD'] = true,
            ['WEAPON_SLEDGEH'] = true,
            ['WEAPON_STREETSWEEP'] = true,
            ['WEAPON_SW357'] = true,
            ['WEAPON_SWMP9'] = true,
            ['WEAPON_T247'] = true,
            ['WEAPON_TANGLOCK'] = true,
            ['WEAPON_UGLOCK'] = true,
            ['WEAPON_WHITEARP'] = true,
            ['WEAPON_WHITEKNIFE'] = true,
            ['WEAPON_WHITESWITCH'] = true,
            ['WEAPON_WOODAXE'] = true,
            ['WEAPON_YELLOWARP'] = true,
            ['WEAPON_YELLOWKNIFE'] = true,
            ['WEAPON_YELLOWSWITCH'] = true,

            -- Attachments
            ['at_flashlight'] = true,
            ['at_laser'] = true,
            ['at_optic'] = true,
            ['at_grip'] = true,
            ['at_suppressor'] = true,
            ['at_magazine'] = true,

            -- Ammunition
            ['ammo-9'] = true,
            ['ammo-10'] = true,
            ['ammo-22'] = true,
            ['ammo-40'] = true,
            ['ammo-45'] = true,
            ['ammo-556'] = true,
            ['ammo-762'] = true,
            ['ammo-50'] = true,
            ['ammo-12'] = true,
            ['ammo-bbs'] = true,

            -- Other
            ['switch'] = true,
        },

        blipId = 'store', -- Config.Blips (such a blip will be known to anyone who is not an employee or owner)
        blipOwnedId = 'owned_store', -- Config.Blips (if you are an employee or owner)
        blipPoint = vector3(-1587.6450, -946.8683, 3.0048),

        vehiclePoint = vector4(-1607.3082, -933.2452, 8.7185, 321.4225),
        trailerPoint = vector4(-1611.2678, -931.0168, 8.7012, 322.2932),
        deliveryPoint = vector3(-1613.5110, -936.1412, 8.6095),
        warehousePoint = {
            coords = vector3(-1579.8315, -942.2101, 3.1044),
            targetCoords = vector3(2-1579.8315, -942.2101, 3.1044),
            targetHeading = 48.2629,
            targetSize = vec(2.2, 2.2, 3.75),
        },

        basketPoint = {
            coords = vector3(-1580.0028, -943.9137, 3.1044),
            targetCoords = vector3(-1580.0028, -943.9137, 3.1044),
            targetHeading = 238.5770,
            targetSize = vec(0.5, 0.4, 0.65),
        },
        managementPoint = {
            coords = vector3(-1581.9952, -949.5764, 3.0577),
            targetCoords = vector3(-1581.9952, -949.5764, 3.0577),
            targetHeading = 57.2087,
            targetSize = vec(1.8, 1.0, 1.5),
        },
        safePoint = {
            coords = vector3(-1585.5466, -953.0327, 3.0034),
            targetCoords = vector3(-1585.5466, -953.0327, 3.0034),
            targetHeading = 131.8838,
            targetSize = vec(0.75, 0.7, 1.15),
        },

        moneyEscortSpawnPoint = vector4(-1578.1416, -865.4081, 10.1734, 138.7263), -- If you use onesync infinity, don't set the point too far away because it will cause problems.
        moneyEscortArrivalPoint = vector3(-1605.7626, -926.9241, 8.8185),

        camerasPoints = {
            [1] = {
                coords = vector3(-1596.3251, -937.1011, 8.7986),
                rotation = vec(0.0, 0.0, 0.0),
                objHeading = 48.4556, -- objHeading is reversed
                maxLeft = 25.0,
                maxRight = 175.0
            }
        },

        points = {
            ['Automatics'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Handguns'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Shotguns'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Melees'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Ammunition'] = {
                coords = vector3(-323.9787, 6092.2036, 25.6336),
                targetCoords = vector3(-323.9787, 6092.2036, 25.6336),
                targetHeading = 228.6832,
                targetSize = vec(2.1, 0.95, 1.65),
            },
            ['Attachments'] = {
                coords = vector3(-323.9787, 6092.2036, 25.6336),
                targetCoords = vector3(-323.9787, 6092.2036, 25.6336),
                targetHeading = 228.6832,
                targetSize = vec(2.1, 0.95, 1.65),
            },
            ['Other'] = {
                coords = vector3(-326.7701, 6095.0386, 25.6336),
                targetCoords = vector3(-326.7701, 6095.0386, 25.6336),
                targetHeading = 47.0224,
                targetSize = vec(2.9, 0.6, 2.5),
            },
            ['buy'] = {
                coords = {
                    [1] = vector3(-1583.4711, -948.7051, 3.0577),
                },
                targetCoords = {
                    [1] = vector3(-1583.4711, -948.7051, 3.0577),
                },
                targetHeading = 241.5880,
                targetSize = vec(0.7, 0.7, 0.5),
            },
        },
        cashierPoints = {
            [1] = {
                pedModel = "mp_m_shopkeep_01",
                coords = vector4(-1582.1703, -949.6790, 2.0577, 51.8526)
            },
        },
    },
    ["gunstore_2"] = {
        type = 'shop',
        
        jobName = 'gunstore_2',
        cityhall_grades = { -- Grades for sections from vms_cityhall
            ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
            ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        },
        
        brand = "Gunstore 2",
        address = "251 Marina Dr, Grand Senora Desert",
        price = 10000000,

        storeArea = { -- PolyZone
            vector2(887.2772, 3601.6431),
            vector2(884.5792, 3546.8123),
            vector2(922.7653, 3546.5693),
            vector2(921.3845, 3603.5103)
        },
        minZ = 20.0,
        maxZ = 40.0,

        productsToOrder = {
            -- Weapons
            ['WEAPON_3DGLOCK'] = true,
            ['WEAPON_300BO'] = true,
            ['WEAPON_357SNUB'] = true,
            ['WEAPON_AR15S'] = true,
            ['WEAPON_AKCATCHER'] = true,
            ['WEAPON_BAGGLOCK'] = true,
            ['WEAPON_SWPBLACKARP'] = true,
            ['WEAPON_BLACKKNIFE'] = true,
            ['WEAPON_BLACKSWITCH'] = true,
            ['WEAPON_SWPBLUEARP'] = true,
            ['WEAPON_BLUEKNIFE'] = true,
            ['WEAPON_BLUESWITCH'] = true,
            ['WEAPON_FN57B'] = true,
            ['WEAPON_FN509HUNT'] = true,
            ['WEAPON_GRAYARP'] = true,
            ['WEAPON_GRAYKNIFE'] = true,
            ['WEAPON_GRAYSWITCH'] = true,
            ['WEAPON_GREENARP'] = true,
            ['WEAPON_GREENKNIFE'] = true,
            ['WEAPON_GREENSWITCH'] = true,
            ['WEAPON_G19BEAM'] = true,
            ['WEAPON_G22'] = true,
            ['WEAPON_G22B'] = true,
            ['WEAPON_G43X'] = true,
            ['WEAPON_GHOSTG30'] = true,
            ['WEAPON_GP80C'] = true,
            ['WEAPON_KTECPLR'] = true,
            ['WEAPON_LILUZI'] = true,
            ['WEAPON_MARP'] = true,
            ['WEAPON_MDRACO'] = true,
            ['WEAPON_MP5C'] = true,
            ['WEAPON_OPPSLUGGER'] = true,
            ['WEAPON_ORANGEARP'] = true,
            ['WEAPON_ORANGEKNIFE'] = true,
            ['WEAPON_ORANGESWITCH'] = true,
            ['WEAPON_PTX22'] = true,
            ['WEAPON_PINKARP'] = true,
            ['WEAPON_PINKKNIFE'] = true,
            ['WEAPON_SWPPINKSWITCH'] = true,
            ['WEAPON_PURPLEARP'] = true,
            ['WEAPON_PURPLEKNIFE'] = true,
            ['WEAPON_PURPLESWITCH'] = true,
            ['WEAPON_SWPREDARP'] = true,
            ['WEAPON_REDKNIFE'] = true,
            ['WEAPON_SWPREDSWITCH'] = true,
            ['WEAPON_R580'] = true,
            ['WEAPON_SCORPIONX9'] = true,
            ['WEAPON_SCREWD'] = true,
            ['WEAPON_SLEDGEH'] = true,
            ['WEAPON_STREETSWEEP'] = true,
            ['WEAPON_SW357'] = true,
            ['WEAPON_SWMP9'] = true,
            ['WEAPON_T247'] = true,
            ['WEAPON_TANGLOCK'] = true,
            ['WEAPON_UGLOCK'] = true,
            ['WEAPON_WHITEARP'] = true,
            ['WEAPON_WHITEKNIFE'] = true,
            ['WEAPON_WHITESWITCH'] = true,
            ['WEAPON_WOODAXE'] = true,
            ['WEAPON_YELLOWARP'] = true,
            ['WEAPON_YELLOWKNIFE'] = true,
            ['WEAPON_YELLOWSWITCH'] = true,

            -- Attachments
            ['at_flashlight'] = true,
            ['at_laser'] = true,
            ['at_optic'] = true,
            ['at_grip'] = true,
            ['at_suppressor'] = true,
            ['at_magazine'] = true,

            -- Ammunition
            ['ammo-9'] = true,
            ['ammo-10'] = true,
            ['ammo-22'] = true,
            ['ammo-40'] = true,
            ['ammo-45'] = true,
            ['ammo-556'] = true,
            ['ammo-762'] = true,
            ['ammo-50'] = true,
            ['ammo-12'] = true,
            ['ammo-bbs'] = true,

            -- Other
            ['switch'] = true,
        },

        blipId = 'store', -- Config.Blips (such a blip will be known to anyone who is not an employee or owner)
        blipOwnedId = 'owned_store', -- Config.Blips (if you are an employee or owner)
        blipPoint = vector3(905.5493, 3587.0842, 33.3834),

        vehiclePoint = vector4(897.7847, 3581.3696, 33.3920, 3.6139),
        trailerPoint = vector4(891.3046, 3581.8145, 33.3866, 5.2205),
        deliveryPoint = vector3(895.4762, 3590.2979, 33.1613),
        warehousePoint = {
            coords = vector3(913.8831, 3570.3735, 27.8649),
            targetCoords = vector3(913.8831, 3570.3735, 27.8649),
            targetHeading = 358.1533,
            targetSize = vec(2.2, 2.2, 3.75),
        },

        basketPoint = {
            coords = vector3(909.2789, 3573.9463, 27.8100),
            targetCoords = vector3(909.2789, 3573.9463, 27.8100),
            targetHeading = 304.8037,
            targetSize = vec(0.5, 0.4, 0.65),
        },
        managementPoint = {
            coords = vector3(906.3292, 3567.3018, 27.8183),
            targetCoords = vector3(906.3292, 3567.3018, 27.8183),
            targetHeading = 27.3307,
            targetSize = vec(1.8, 1.0, 1.5),
        },
        safePoint = {
            coords = vector3(901.6314, 3567.7568, 27.7639),
            targetCoords = vector3(901.6314, 3567.7568, 27.7639),
            targetHeading = 77.3196,
            targetSize = vec(0.75, 0.7, 1.15),
        },

        moneyEscortSpawnPoint = vector4(855.1097, 3629.6055, 33.0497, 273.0327), -- If you use onesync infinity, don't set the point too far away because it will cause problems.
        moneyEscortArrivalPoint = vector3(919.6492, 3596.3247, 33.0816),

        camerasPoints = {
            [1] = {
                coords = vector3(901.1880, 3586.1575, 33.4246),
                rotation = vec(0.0, 0.0, 0.0),
                objHeading = 8.4463+180.0, -- objHeading is reversed
                maxLeft = 90.0,
                maxRight = 270.0
            }
        },

        points = {
            ['Automatics'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Handguns'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Shotguns'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Melees'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Ammunition'] = {
                coords = vector3(-323.9787, 6092.2036, 25.6336),
                targetCoords = vector3(-323.9787, 6092.2036, 25.6336),
                targetHeading = 228.6832,
                targetSize = vec(2.1, 0.95, 1.65),
            },
            ['Attachments'] = {
                coords = vector3(-323.9787, 6092.2036, 25.6336),
                targetCoords = vector3(-323.9787, 6092.2036, 25.6336),
                targetHeading = 228.6832,
                targetSize = vec(2.1, 0.95, 1.65),
            },
            ['Other'] = {
                coords = vector3(-326.7701, 6095.0386, 25.6336),
                targetCoords = vector3(-326.7701, 6095.0386, 25.6336),
                targetHeading = 47.0224,
                targetSize = vec(2.9, 0.6, 2.5),
            },
            ['buy'] = {
                coords = {
                    [1] = vector3(906.4628, 3569.0098, 27.8157),
                },
                targetCoords = {
                    [1] = vector3(906.4628, 3569.0098, 27.8157),
                },
                targetHeading = 163.2911,
                targetSize = vec(0.7, 0.7, 0.5),
            },
        },
        cashierPoints = {
            [1] = {
                pedModel = "mp_m_shopkeep_01",
                coords = vector4(906.6144, 3567.1697, 26.8183, 6.5784)
            },
        },
    },
    ["gunstore_3"] = {
        type = 'shop',
        
        jobName = 'gunstore_3',
        cityhall_grades = { -- Grades for sections from vms_cityhall
            ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
            ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        },
        
        brand = "Gunstore 3",
        address = "138 North Calafia Way, Galilee",
        price = 10000000,

        storeArea = { -- PolyZone
            vector2(1353.9011, 4328.9570),
            vector2(1338.3311, 4295.4473),
            vector2(1370.4604, 4281.4502),
            vector2(1382.7664, 4314.2837)
        },
        minZ = 30.0,
        maxZ = 50.0,

        productsToOrder = {
            -- Weapons
            ['WEAPON_3DGLOCK'] = true,
            ['WEAPON_300BO'] = true,
            ['WEAPON_357SNUB'] = true,
            ['WEAPON_AR15S'] = true,
            ['WEAPON_AKCATCHER'] = true,
            ['WEAPON_BAGGLOCK'] = true,
            ['WEAPON_SWPBLACKARP'] = true,
            ['WEAPON_BLACKKNIFE'] = true,
            ['WEAPON_BLACKSWITCH'] = true,
            ['WEAPON_SWPBLUEARP'] = true,
            ['WEAPON_BLUEKNIFE'] = true,
            ['WEAPON_BLUESWITCH'] = true,
            ['WEAPON_FN57B'] = true,
            ['WEAPON_FN509HUNT'] = true,
            ['WEAPON_GRAYARP'] = true,
            ['WEAPON_GRAYKNIFE'] = true,
            ['WEAPON_GRAYSWITCH'] = true,
            ['WEAPON_GREENARP'] = true,
            ['WEAPON_GREENKNIFE'] = true,
            ['WEAPON_GREENSWITCH'] = true,
            ['WEAPON_G19BEAM'] = true,
            ['WEAPON_G22'] = true,
            ['WEAPON_G22B'] = true,
            ['WEAPON_G43X'] = true,
            ['WEAPON_GHOSTG30'] = true,
            ['WEAPON_GP80C'] = true,
            ['WEAPON_KTECPLR'] = true,
            ['WEAPON_LILUZI'] = true,
            ['WEAPON_MARP'] = true,
            ['WEAPON_MDRACO'] = true,
            ['WEAPON_MP5C'] = true,
            ['WEAPON_OPPSLUGGER'] = true,
            ['WEAPON_ORANGEARP'] = true,
            ['WEAPON_ORANGEKNIFE'] = true,
            ['WEAPON_ORANGESWITCH'] = true,
            ['WEAPON_PTX22'] = true,
            ['WEAPON_PINKARP'] = true,
            ['WEAPON_PINKKNIFE'] = true,
            ['WEAPON_SWPPINKSWITCH'] = true,
            ['WEAPON_PURPLEARP'] = true,
            ['WEAPON_PURPLEKNIFE'] = true,
            ['WEAPON_PURPLESWITCH'] = true,
            ['WEAPON_SWPREDARP'] = true,
            ['WEAPON_REDKNIFE'] = true,
            ['WEAPON_SWPREDSWITCH'] = true,
            ['WEAPON_R580'] = true,
            ['WEAPON_SCORPIONX9'] = true,
            ['WEAPON_SCREWD'] = true,
            ['WEAPON_SLEDGEH'] = true,
            ['WEAPON_STREETSWEEP'] = true,
            ['WEAPON_SW357'] = true,
            ['WEAPON_SWMP9'] = true,
            ['WEAPON_T247'] = true,
            ['WEAPON_TANGLOCK'] = true,
            ['WEAPON_UGLOCK'] = true,
            ['WEAPON_WHITEARP'] = true,
            ['WEAPON_WHITEKNIFE'] = true,
            ['WEAPON_WHITESWITCH'] = true,
            ['WEAPON_WOODAXE'] = true,
            ['WEAPON_YELLOWARP'] = true,
            ['WEAPON_YELLOWKNIFE'] = true,
            ['WEAPON_YELLOWSWITCH'] = true,

            -- Attachments
            ['at_flashlight'] = true,
            ['at_laser'] = true,
            ['at_optic'] = true,
            ['at_grip'] = true,
            ['at_suppressor'] = true,
            ['at_magazine'] = true,

            -- Ammunition
            ['ammo-9'] = true,
            ['ammo-10'] = true,
            ['ammo-22'] = true,
            ['ammo-40'] = true,
            ['ammo-45'] = true,
            ['ammo-556'] = true,
            ['ammo-762'] = true,
            ['ammo-50'] = true,
            ['ammo-12'] = true,
            ['ammo-bbs'] = true,

            -- Other
            ['switch'] = true,
        },

        blipId = 'store', -- Config.Blips (such a blip will be known to anyone who is not an employee or owner)
        blipOwnedId = 'owned_store', -- Config.Blips (if you are an employee or owner)
        blipPoint = vector3(1367.5925, 4317.9868, 37.9244),

        vehiclePoint = vector4(1341.2039, 4322.2920, 38.0390, 346.9694),
        trailerPoint = vector4(1344.4722, 4317.1172, 37.9948, 345.0002),
        deliveryPoint = vector3(1351.1068, 4334.2637, 38.2366),
        warehousePoint = {
            coords = vector3(1367.9635, 4298.1514, 32.0087),
            targetCoords = vector3(1367.9635, 4298.1514, 32.0087),
            targetHeading = 7.7868,
            targetSize = vec(2.2, 2.2, 3.75),
        },

        basketPoint = {
            coords = vector3(1364.4147, 4302.6196, 31.9539),
            targetCoords = vector3(1364.4147, 4302.6196, 31.9539),
            targetHeading = 257.1647,
            targetSize = vec(0.5, 0.4, 0.65),
        },
        managementPoint = {
            coords = vector3(1359.8752, 4296.9790, 31.9621),
            targetCoords = vector3(1359.8752, 4296.9790, 31.9621),
            targetHeading = 7.4176,
            targetSize = vec(1.8, 1.0, 1.5),
        },
        safePoint = {
            coords = vector3(1355.3463, 4298.7944, 31.9078),
            targetCoords = vector3(1355.3463, 4298.7944, 31.9078),
            targetHeading = 55.1679,
            targetSize = vec(0.75, 0.7, 1.15),
        },

        moneyEscortSpawnPoint = vector4(1566.3004, 4575.6187, 49.0902, 114.0106), -- If you use onesync infinity, don't set the point too far away because it will cause problems.
        moneyEscortArrivalPoint = vector3(1365.3599, 4334.5488, 39.6601),

        camerasPoints = {
            [1] = {
                coords = vector3(1365.7578, 4314.9414, 37.7951),
                rotation = vec(0.0, 0.0, 0.0),
                objHeading = 346.0700, -- objHeading is reversed
                maxLeft = 25.0,
                maxRight = 175.0
            }
        },

        points = {
            ['Automatics'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Handguns'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Shotguns'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Melees'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Ammunition'] = {
                coords = vector3(-323.9787, 6092.2036, 25.6336),
                targetCoords = vector3(-323.9787, 6092.2036, 25.6336),
                targetHeading = 228.6832,
                targetSize = vec(2.1, 0.95, 1.65),
            },
            ['Attachments'] = {
                coords = vector3(-323.9787, 6092.2036, 25.6336),
                targetCoords = vector3(-323.9787, 6092.2036, 25.6336),
                targetHeading = 228.6832,
                targetSize = vec(2.1, 0.95, 1.65),
            },
            ['Other'] = {
                coords = vector3(-326.7701, 6095.0386, 25.6336),
                targetCoords = vector3(-326.7701, 6095.0386, 25.6336),
                targetHeading = 47.0224,
                targetSize = vec(2.9, 0.6, 2.5),
            },
            ['buy'] = {
                coords = {
                    [1] = vector3(1360.3616, 4298.6221, 31.9580),
                },
                targetCoords = {
                    [1] = vector3(1360.3616, 4298.6221, 31.9580),
                },
                targetHeading = 157.0333,
                targetSize = vec(0.7, 0.7, 0.5),
            },
        },
        cashierPoints = {
            [1] = {
                pedModel = "mp_m_shopkeep_01",
                coords = vector4(1360.1344, 4296.9004, 30.9621, 349.2256)
            },
        },
    },
    ["gunstore_4"] = {
        type = 'shop',
        
        jobName = 'gunstore_4',
        cityhall_grades = { -- Grades for sections from vms_cityhall
            ['resumes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
            ['taxes'] = {'manager', 'boss'}, -- string: 'name', table: {'name', 'name2'}
        },
        
        brand = "Gunstore 4",
        address = "046 Great Ocean Hwy, Paleto Bay",
        price = 10000000,

        storeArea = { -- PolyZone
            vector2(-329.2065, 6113.8594),
            vector2(-361.1530, 6082.9224),
            vector2(-335.8484, 6052.0186),
            vector2(-298.4412, 6085.9180)
        },
        minZ = 15,
        maxZ = 35.0,

        productsToOrder = {
            -- Weapons
            ['WEAPON_3DGLOCK'] = true,
            ['WEAPON_300BO'] = true,
            ['WEAPON_357SNUB'] = true,
            ['WEAPON_AR15S'] = true,
            ['WEAPON_AKCATCHER'] = true,
            ['WEAPON_BAGGLOCK'] = true,
            ['WEAPON_SWPBLACKARP'] = true,
            ['WEAPON_BLACKKNIFE'] = true,
            ['WEAPON_BLACKSWITCH'] = true,
            ['WEAPON_SWPBLUEARP'] = true,
            ['WEAPON_BLUEKNIFE'] = true,
            ['WEAPON_BLUESWITCH'] = true,
            ['WEAPON_FN57B'] = true,
            ['WEAPON_FN509HUNT'] = true,
            ['WEAPON_GRAYARP'] = true,
            ['WEAPON_GRAYKNIFE'] = true,
            ['WEAPON_GRAYSWITCH'] = true,
            ['WEAPON_GREENARP'] = true,
            ['WEAPON_GREENKNIFE'] = true,
            ['WEAPON_GREENSWITCH'] = true,
            ['WEAPON_G19BEAM'] = true,
            ['WEAPON_G22'] = true,
            ['WEAPON_G22B'] = true,
            ['WEAPON_G43X'] = true,
            ['WEAPON_GHOSTG30'] = true,
            ['WEAPON_GP80C'] = true,
            ['WEAPON_KTECPLR'] = true,
            ['WEAPON_LILUZI'] = true,
            ['WEAPON_MARP'] = true,
            ['WEAPON_MDRACO'] = true,
            ['WEAPON_MP5C'] = true,
            ['WEAPON_OPPSLUGGER'] = true,
            ['WEAPON_ORANGEARP'] = true,
            ['WEAPON_ORANGEKNIFE'] = true,
            ['WEAPON_ORANGESWITCH'] = true,
            ['WEAPON_PTX22'] = true,
            ['WEAPON_PINKARP'] = true,
            ['WEAPON_PINKKNIFE'] = true,
            ['WEAPON_SWPPINKSWITCH'] = true,
            ['WEAPON_PURPLEARP'] = true,
            ['WEAPON_PURPLEKNIFE'] = true,
            ['WEAPON_PURPLESWITCH'] = true,
            ['WEAPON_SWPREDARP'] = true,
            ['WEAPON_REDKNIFE'] = true,
            ['WEAPON_SWPREDSWITCH'] = true,
            ['WEAPON_R580'] = true,
            ['WEAPON_SCORPIONX9'] = true,
            ['WEAPON_SCREWD'] = true,
            ['WEAPON_SLEDGEH'] = true,
            ['WEAPON_STREETSWEEP'] = true,
            ['WEAPON_SW357'] = true,
            ['WEAPON_SWMP9'] = true,
            ['WEAPON_T247'] = true,
            ['WEAPON_TANGLOCK'] = true,
            ['WEAPON_UGLOCK'] = true,
            ['WEAPON_WHITEARP'] = true,
            ['WEAPON_WHITEKNIFE'] = true,
            ['WEAPON_WHITESWITCH'] = true,
            ['WEAPON_WOODAXE'] = true,
            ['WEAPON_YELLOWARP'] = true,
            ['WEAPON_YELLOWKNIFE'] = true,
            ['WEAPON_YELLOWSWITCH'] = true,

            -- Attachments
            ['at_flashlight'] = true,
            ['at_laser'] = true,
            ['at_optic'] = true,
            ['at_grip'] = true,
            ['at_suppressor'] = true,
            ['at_magazine'] = true,

            -- Ammunition
            ['ammo-9'] = true,
            ['ammo-10'] = true,
            ['ammo-22'] = true,
            ['ammo-40'] = true,
            ['ammo-45'] = true,
            ['ammo-556'] = true,
            ['ammo-762'] = true,
            ['ammo-50'] = true,
            ['ammo-12'] = true,
            ['ammo-bbs'] = true,

            -- Other
            ['switch'] = true,
        },

        blipId = 'store', -- Config.Blips (such a blip will be known to anyone who is not an employee or owner)
        blipOwnedId = 'owned_store', -- Config.Blips (if you are an employee or owner)
        blipPoint = vector3(-338.4368, 6105.0552, 31.4056),

        vehiclePoint = vector4(-328.0927, 6095.9453, 31.4541, 227.5064),
        trailerPoint = vector4(-325.1099, 6101.4160, 31.4724, 226.5231),
        deliveryPoint = vector3(-324.5551, 6106.3530, 31.4834),
        warehousePoint = {
            coords = vector3(-325.3790, 6092.2129, 25.6336),
            targetCoords = vector3(-325.3790, 6092.2129, 25.6336),
            targetHeading = 45.5254,
            targetSize = vec(2.2, 2.2, 3.75),
        },

        basketPoint = {
            coords = vector3(-331.1898, 6091.4165, 25.5787),
            targetCoords = vector3(-331.1898, 6091.4165, 25.5787),
            targetHeading = 332.5284,
            targetSize = vec(0.5, 0.4, 0.65),
        },
        managementPoint = {
            coords = vector3(-328.4771, 6084.6597, 25.5869),
            targetCoords = vector3(-328.4771, 6084.6597, 25.5869),
            targetHeading = 84.7632,
            targetSize = vec(1.8, 1.0, 1.5),
        },
        safePoint = {
            coords = vector3(-332.3495, 6081.6553, 25.5326),
            targetCoords = vector3(-332.3495, 6081.6553, 25.5326),
            targetHeading = 120.4393,
            targetSize = vec(0.75, 0.7, 1.15),
        },

        moneyEscortSpawnPoint = vector4(-172.2480, 6222.7842, 31.2473, 140.8872), -- If you use onesync infinity, don't set the point too far away because it will cause problems.
        moneyEscortArrivalPoint = vector3(-312.8519, 6081.4268, 31.2240),

        camerasPoints = {
            [1] = {
                coords = vector3(-344.6740, 6095.4170, 31.2803),
                rotation = vec(0.0, 0.0, 0.0),
                objHeading = 45.8278, -- objHeading is reversed
                maxLeft = 0.0,
                maxRight = 150.0
            }
        },

        points = {
            ['Automatics'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Handguns'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Shotguns'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Melees'] = {
                coords = vector3(-325.7985, 6090.3032, 25.6336),
                targetCoords = vector3(-325.7985, 6090.3032, 25.6336),
                targetHeading = 228.4576,
                targetSize = vec(6.0, 0.9, 2.5),
            },
            ['Ammunition'] = {
                coords = vector3(-323.9787, 6092.2036, 25.6336),
                targetCoords = vector3(-323.9787, 6092.2036, 25.6336),
                targetHeading = 228.6832,
                targetSize = vec(2.1, 0.95, 1.65),
            },
            ['Attachments'] = {
                coords = vector3(-323.9787, 6092.2036, 25.6336),
                targetCoords = vector3(-323.9787, 6092.2036, 25.6336),
                targetHeading = 228.6832,
                targetSize = vec(2.1, 0.95, 1.65),
            },
            ['Other'] = {
                coords = vector3(-326.7701, 6095.0386, 25.6336),
                targetCoords = vector3(-326.7701, 6095.0386, 25.6336),
                targetHeading = 47.0224,
                targetSize = vec(2.9, 0.6, 2.5),
            },
            ['buy'] = {
                coords = {
                    [1] = vector3(-329.6123, 6085.9297, 25.5858),
                },
                targetCoords = {
                    [1] = vector3(-329.6123, 6085.9297, 25.5858),
                },
                targetHeading = 213.1930,
                targetSize = vec(0.7, 0.7, 0.5),
            },
        },
        cashierPoints = {
            [1] = {
                pedModel = "mp_m_shopkeep_01",
                coords = vector4(-328.3060, 6084.8262, 24.5869, 53.4137)
            },
        },
    },
}