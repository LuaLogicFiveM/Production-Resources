bridge = bridge or {}

local Framework, FrameworkType

if GetResourceState("qb-core") == "started" then
    FrameworkType = "qbcore"
    Framework = exports["qb-core"]:GetCoreObject()
elseif GetResourceState("es_extended") == "started" then
    FrameworkType = "esx"
    Framework = exports["es_extended"]:getSharedObject()
else
    print(
        '^1 FATAL ERROR: plt_drugs did not found your framework. Please head into "plt_drugs/server/bridge/framework.lua" and set your custom framework and make sure that your frameworks file are starting before plt_drugs!^7')
end

function bridge.createUsableItem(name, cb)
    -- Wait(100)
    if not Framework then
        return
    end

    if FrameworkType == "qbcore" then
        Framework.Functions.CreateUseableItem(name, cb)
    elseif FrameworkType == "esx" then
        Framework.RegisterUsableItem(name, cb)
    end
end

function bridge.removeMoney(src, amount)
    -- Wait(100)
    if not Framework then
        return
    end

    if FrameworkType == "qbcore" then
        local Player = Framework.Functions.GetPlayer(src)
        if not Player then return end
        return Player.Functions.RemoveMoney('cash', amount)
    elseif FrameworkType == "esx" then
        local xPlayer = Framework.GetPlayerFromId(src)
        if not xPlayer then return end
        local money = xPlayer.getMoney()
        if money >= amount then
            xPlayer.removeMoney(amount)
            return true
        else
            return false
        end
    end
end

function bridge.checkIsAdmin(src)
    if not Framework then
        return
    end

    if FrameworkType == "qbcore" then
        for i, v in pairs(Config.OnlyAdminsCanPickUpEquipment.adminGroups) do
            if Framework.Functions.HasPermission(src, v) then
                return true
            end
        end
    elseif FrameworkType == "esx" then
        for i, v in pairs(Config.OnlyAdminsCanPickUpEquipment.adminGroups) do
            local xPlayer = Framework.GetPlayerFromId(src)
            if xPlayer.getGroup() == v then
                return true
            end
        end
    end

    return false
end
