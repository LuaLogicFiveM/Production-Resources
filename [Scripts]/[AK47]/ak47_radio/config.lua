Config = {}
Config.Locale = 'en'

Config.UsableItem = "radio" -- The item name that will open the radio.
Config.ResetRadioCmd = "radioreset" -- The will reset radio cache setting

Config.MaxChannelLength = 4 -- The maximum character length for a channel (e.g., 999.99)

Config.DisconnectWhenDead = false

-- Default UI settings for first-time users or after cache is cleared.
-- These values will be sent to the UI when it opens.
Config.DefaultUISettings = {
    draggable = true,
    showPlayerList = true,
    uiZoom = 70,
    playerListZoom = 100,
    clickSound = true,
    uiVolume = 0.5,
    positions = {
        radio = { top = '60%', left = '70%' },
        playerList = { top = '26rem', right = '0rem' }
    },
    animationIndex = 1,
}

-- Channels restricted to specific jobs.
-- Players without the specified job will not be able to connect.
Config.JobOnlyChannels = {
    ['1'] = { 'sheriff', 'sahp', 'ems' }, -- Only players with the 'police' or 'lspd' job can access channel '1'
    ['2'] = { 'sheriff', 'sahp', 'ems' },
    ['3'] = { 'sheriff', 'sahp', 'ems' },
    ['4'] = { 'sheriff', 'sahp', 'ems' },
    ['5'] = { 'sheriff', 'sahp', 'ems' },
    ['6'] = { 'sheriff', 'sahp', 'ems' },
    ['7'] = { 'sheriff', 'sahp', 'ems' },
    ['8'] = { 'sheriff', 'sahp', 'ems', 'dot' },
    ['9'] = { 'sheriff', 'sahp', 'ems', 'dot' },
    ['10'] = { 'sheriff', 'sahp', 'ems', 'dot' },
}

Config.AllowCallSignChangeJobs = {
    sheriff = true,
    sahp = true,
    dot = true,
}

Config.Animations = {
    {
        label = 'Default',
        anim = {
            dict = 'random@arrests',
            clip = 'generic_radio_chatter'
        },
        prop = {
            model = 'prop_cs_hand_radio',
            bone = 60309,
            position = vector3(0.07, 0.02, 0.02),
            rotation = vector3(-96.0, -0.0, -40.0),
        }
    },
    {
        label = 'Mouth',
        anim = {
            dict = 'anim@male@holding_radio',
            clip = 'holding_radio_clip'
        },
        prop = {
            model = 'prop_cs_hand_radio',
            bone = 28422,
            position = vector3(0.075, 0.023, -0.023),
            rotation = vector3(-90.0, 0.0, -59.99),
        }
    },
    {
        label = 'Ear',
        anim = {
            dict = 'cellphone@',
            clip = 'cellphone_call_listen_base'
        },
        prop = {
            model = 'prop_cs_hand_radio',
            bone = 28422,
            position = vector3(0.0, 0.0, 0.0),
            rotation = vector3(0.0, 0.0, 0.0),
        }
    },
}