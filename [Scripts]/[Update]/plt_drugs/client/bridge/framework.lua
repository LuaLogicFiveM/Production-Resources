bridge = {}

local Framework, FrameworkType
bridge.PlayerLoadedEvent = nil

if GetResourceState("qb-core") == "started" then
    FrameworkType = "qbcore"
    Framework = exports["qb-core"]:GetCoreObject()
    bridge.PlayerLoadedEvent = "QBCore:Client:OnPlayerLoaded"
elseif GetResourceState("es_extended") == "started" then
    FrameworkType = "esx"
    Framework = exports["es_extended"]:getSharedObject()
    bridge.PlayerLoadedEvent = "esx:playerLoaded"
else
    print(
        '^1 FATAL ERROR: plt_drugs did not found your framework. Please head into "plt_drugs/server/client/framework.lua" and set your custom framework and make sure that your frameworks file are starting before plt_drugs!^7')
end
