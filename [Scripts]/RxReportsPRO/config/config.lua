--[[
BY RX Scripts © rxscripts.xyz
--]]

Config = {}

Config.Locale = 'en'
Config.SaveInterval = 29 -- Minutes to save reports to database
Config.ToggleNotifications = true -- Allow toggling of report notifications like new opened, chat of claimed tickets (default = disabled)
Config.MaxReports = 2 -- Max reports a player can have open at once
Config.HideAdminName = true -- Hide admin name for players in their reports (chat, claimed & closed by etc)

Config.Categories = {
    {
        name = 'Report Player',
        fields = {
            { label = 'ID of Reported Player', type = 'number', cols = 6, required = false, isReportedId = true },
            { label = 'Subject', type = 'text', cols = 6, required = true },
            { label = 'Detailed Report', type = 'textarea', cols = 12, required = true },
        },
    },
    {
        name = 'Report Bug',
        fields = {
            { label = 'Subject', type = 'text', cols = 12, required = true },
            { label = 'Detailed Report', type = 'textarea', cols = 12, required = true },
        },
    },
    {
        name = 'Report Other',
        fields = {
            { label = 'Subject', type = 'text', cols = 12, required = true },
            { label = 'Detailed Report', type = 'textarea', cols = 12, required = true },
        },
    },
}

Config.StaffActions = { -- For each action, a function needs to be made in config/sv_config.lua: Config.ActionsFunctions
    {
        name = 'heal',
        label = 'Heal',
        severity = 'success', -- Possibilities: 'primary' | 'secondary' | 'success' | 'info' | 'warn' | 'danger' | 'contrast'
        toReporter = true, -- Enable action to execute on the reporter
        toReported = false, -- Enable action to execute on the reported player (in case there is any)
    },
    {
        name = 'spectate',
        label = 'Spectate',
        severity = 'info',
        toReporter = true, -- Enable action to execute on the reporter
        toReported = true, -- Enable action to execute on the reported player (in case there is any)
    },
    {
        name = 'goto',
        label = 'Go To',
        severity = 'info',
        toReporter = true, -- Enable action to execute on the reporter
        toReported = true, -- Enable action to execute on the reported player (in case there is any)
    },
    {
        name = 'bring',
        label = 'Bring',
        severity = 'info',
        toReporter = true, -- Enable action to execute on the reporter
        toReported = true, -- Enable action to execute on the reported player (in case there is any)
    },
    {
        name = 'tpback',
        label = 'TP Back',
        severity = 'info',
        toReporter = true, -- Enable action to execute on the reporter
        toReported = true, -- Enable action to execute on the reported player (in case there is any)
    },
    --[[{
        name = 'customExample',
        label = 'Create Custom Action',
        severity = 'contrast',
        toReporter = true, -- Enable action to execute on the reporter
        toReported = true, -- Enable action to execute on the reported player (in case there is any)
    }]]
}

Config.Priorities = {
    {
        name = 'Low',
        severity = 'info', -- Possibilities: 'primary' | 'secondary' | 'success' | 'info' | 'warn' | 'danger' | 'contrast'
        playerAllowed = true, -- Allow players to set this priority themselves upon creating a report
    },
    {
        name = 'Medium',
        severity = 'warn',
        playerAllowed = true,
    },
    {
        name = 'High',
        severity = 'danger',
        playerAllowed = false,
    }
}

Config.QuickResponses = {
    {
        label = 'Recieved',
        text = 'We have recieved your report, and are actively looking into the situation. Please wait patiently and we will be with you soon!'
    },
    {
        label = 'More Info',
        text = 'We have reviewed your report, and decided we need more information in order to work on this matter. Please respond with extra information.'
    },
}

Config.BlacklistedWords = { -- Reports cannot include any of these words
    'nigge',
    'fagg',
}

Config.Commands = {
    reportPanel = 'report', -- /report | Report a player, bug or other, and see your reports
    staffPanel = 'reports', -- /reports | Open the reports staff panel
    toggleNotifications = 'reportnotify', -- /reportnotify | Toggle incoming report notifications
    clearReports = 'reports:clear', -- /reports:clear | Clear all reports from tablet & database as admin
}

Config.Keybinds = {
    reportPanel = '', -- Opens Report Panel
    staffPanel = 'F9', -- Opens Reports Staff Panel
}

--[[
    YOU CAN USE ACE PERMISSIONS TO ALLOW CERTAIN PLAYERS/GROUPS TO ACCESS THE REPORTS PANEL
    EXAMPLE:
        add_ace group.admin reports allow
        add_ace identifier.fivem:1432744 reports allow #Rejox

    OR YOU CAN USE THE STAFF GROUPS BELOW
--]]
Config.StaffGroups = {
    'owner',
    'manager',
    'admin',
    'mod',
    'tmod',
}

--[[
    ONLY CHANGE THIS PART IF YOU HAVE RENAMED SCRIPTS SUCH AS FRAMEWORK, TARGET, INVENTORY ETC
    RENAME THE SCRIPT NAME TO THE NEW NAME
--]]
---@type table Only change these if you have changed the name of a resource
Resources = {
    FM = { name = 'fmLib', export = 'new' },
    SCREENBASIC = { name = 'screenshot-basic', export = 'all' },
}
IgnoreScriptFoundLogs = false