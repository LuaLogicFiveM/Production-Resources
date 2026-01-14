return {
    DoubleClickTreshold = 0.3, --| Wait time to check for double click

    Activation = {
        mapping = 'MOUSE_BUTTON',
        key = 'MOUSE_MIDDLE'
    },

    Icons = {
        normal = '📍',
        warning = '⚠️',
    },

    Jobs = {
        ['sheriff'] = {
            duration = 15000,
            color = { r = 0, g = 0, b = 255, a = 150 },
            blipColor = 4
        },

        ['sahp'] = {
            duration = 15000,
            color = { r = 0, g = 0, b = 255, a = 150 },
            blipColor = 4
        },

        ['ems'] = {
            duration = 15000,
            color = { r = 255, g = 0, b = 0, a = 150 },
            blipColor = 49
        },
    },

    Strings = {
        placed_title = 'Quick Ping',
        placed_desc = 'You have placed a marker',

        place_desc = 'Place a Quick Ping',
        display_text = '[%s] %s', --| arg1: player id - arg2: player name
        display_text_meter = '%d m', --| arg1: meter
    }
}