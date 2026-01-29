-- ┌──────────────────────────────────────────────────────────────────┐
-- │                              DEBUG                               │
-- └──────────────────────────────────────────────────────────────────┘

local function DebugPrints(source)
    Citizen.Trace('^6-----------------------^0\n')
    Citizen.Trace(string.format('^1CODESIGN DEBUG^0 (%s - v%s - %s)\n', GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'version', 0), source and 'client' or 'server'))

    Citizen.Trace('^3CONFIG^0\n')
    Citizen.Trace(string.format('^6Config.AutoInsertSQL:^0 %s\n', tostring(Config.AutoInsertSQL)))
    Citizen.Trace(string.format('^6Config.Debug:^0 %s\n', tostring(Config.Debug)))
    Citizen.Trace(string.format('^6Config.EnableTestCommand:^0 %s\n', tostring(Config.EnableTestCommand)))
    Citizen.Trace('^6-----------------------^0\n')

    if source then
        Citizen.Trace('^3PERMS^0\n')
        Citizen.Trace(string.format('^6Access Perms:^0 %s\n', GetMultiJob(GetJobName(source)) ~= nil))
        Citizen.Trace(string.format('^6Dispatcher Perms:^0 %s\n', IsAllowed_features(source, 'Dispatcher')))
        Citizen.Trace(string.format('^6Planner Perms:^0 %s\n', IsAllowed_features(source, 'Planner')))
        Citizen.Trace('^6-----------------------^0\n')
        Notification(source, 2, 'DEBUG INFO: OPEN F8 CONSOLE TO VIEW^0')
    end
end

RegisterCommand('debugdispatch', function(source)
    local isConsole = source == 0
    local isAdmin = HasAdminPerms(source, {'owner', 'superadmin', 'god', 'admin', 'moderator', 'mod'})
    local debugEnabled = Config.Debug

    if isConsole then
        DebugPrints(nil)
        return
    end

    if isAdmin or debugEnabled then
        DebugPrints(source)
        return
    end

    Citizen.Trace('You cannot use this command. You must have admin permissions, enable Config.Debug, or run it from the server console.\n')
end, false)

RegisterCommand('debugdispatchtable', function(source)
    local isConsole = source == 0
    local isAdmin = HasAdminPerms(source, { 'owner', 'superadmin', 'god', 'admin', 'moderator', 'mod' })
    local debugEnabled = Config.Debug
    local getSource = source > 0 and source or -1

    if isConsole or debugEnabled or isAdmin then
        if GetResourceState('cd_devtools') == 'started' then
            TriggerClientEvent('table', getSource, AllPlayers)
            Citizen.Trace('^6Devtools debug table sent.^0\n')
        else
            Citizen.Trace('^6cd_devtools is not started.^0\n')
        end
    else
        Citizen.Trace('You cannot use this command. You must have admin permissions, enable Config.Debug, or run it from the server console.\n')
    end
end, false)

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                        PRE START CHECKS                          │
-- └──────────────────────────────────────────────────────────────────┘

CreateThread(function()
    if GetResourceState('cd_bridge') ~= 'started' then
        BridgeDependancyMissingPrint()
    end
    if Config == nil then
        ERROR('configuration_error_found', 'Config.lua Syntax Error')
    end
    if LocalesTable[Config.Language] == nil then
        ERROR('configuration_error_found', 'Config.Language/locales.lua Typo : ['..Config.Language..']')
    end
    if GetCurrentResourceName() ~= 'cd_dispatch3d' then
        ERROR('configuration_error_found', 'Resource Name Changed : ['..GetCurrentResourceName()..']')
    end
end)

function BridgeDependancyMissingPrint()
    Citizen.Trace([[
        ^5===============================================================
        ^3[cd_dispatch3d] ^7Missing required dependency: ^1cd_bridge^7
        ^5===============================================================

        ^7This resource requires the ^2cd_bridge^7 framework bridge to function correctly.

        ^7Please download ^2cd_bridge^7 from the official source:
            ^3https://portal.cfx.re/assets/granted-assets?search=cd_bridge

        ^6After installing:
        • Ensure the ^2cd_bridge^7 resource is started ^4before^7 this resource
        • Verify it is named exactly ^2"cd_bridge"^7 in your resources folder
        • Restart your server after adding it

        ^5===============================================================
    ]] .. '^0\n')
end

function PreStartItemChecks()
    local needed = {}

    if Config.GpsTracker.ENABLE then
        table.insert(needed, Config.GpsTracker.item_name)
    end

    CheckAllItemsExist(needed)
end