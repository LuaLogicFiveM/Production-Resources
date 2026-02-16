-----------------------------------------------------------------
-- Visit https://docs.acscripts.dev/scoreboard for documentation
-----------------------------------------------------------------

return {
    settings = {
        title = {
            text = 'Player List',
            logo = 'https://i.ibb.co/YLLNHJP/lorp-logo-main.png',
        },

        side = 'right',

        showOverlay = false,

        closeOnEscape = true,

        closeOnOutsideClick = true,

        uppercaseNames = false,

        highlightEmptyGroups = true,

        compactPlayers = false,

        compactGroups = false,

        playerColumns = 1,

        groupColumns = 1,
    },

    visibleSections = {
        groups = true,
        groupCount = true,
        players = true,
        playerNames = true,
        playerIds = false,
        statusIndicators = true,
        footer = true,
    },

    -- Command name for opening the scoreboard
    commandName = 'scoreboard',

    -- Default keybind for the '/scoreboard' command
    commandKey = 'DELETE',

    -- Whether to include off-duty players in group count (if not defined in the group row itself)
    includeOffDuty = false,

    -- Group list shown in the scoreboard
    groups = {
        {
            label = 'Sheriff',
            groups = {'sheriff'},
            icon = 'ic:round-local-police',
            includeOffDuty = false,
        },
        {
            label = 'SAHP',
            groups = {'sahp'},
            icon = 'ic:round-local-police',
            includeOffDuty = false,
        },
        {
            label = 'SAFD',
            groups = {'safd'},
            icon = 'ic:round-emergency',
            includeOffDuty = false,
        },
    },

    -- Status indicators shown in the scoreboard
    statusIndicators = {
        {
            id = 'jewlery_heist',
            label = 'Jewelry Heist',
            icon = 'mdi:store',
            groupTrigger = {
                groups = {'sheriff', 'sahp'},
                minimumCount = 3,
                includeOffDuty = false,
            },
        },
        {
            id = 'store_robbery',
            label = 'Store Robbery',
            icon = 'mdi:store',
            groupTrigger = {
                groups = {'sheriff', 'sahp'},
                minimumCount = 2,
                includeOffDuty = false,
            },
        },
    },
}
