Config = {}
Config.Locale = 'en'

Config.UsableItem = "radio" -- The item name that will open the radio.
Config.ResetRadioCmd = "resetradio" -- The will reset radio cache setting

Config.MaxChannelLength = 5 -- The maximum character length for a channel (e.g., 999.99)

Config.DisconnectWhenDead = false

Config.VoiceJitterRange = 300.0
Config.RadioItems = {
    radio = -1, -- no range applied
    civradio = 1000,
}

-- Default UI settings for first-time users or after cache is cleared.
-- These values will be sent to the UI when it opens.
Config.DefaultUISettings = {
    draggable = true,
    showPlayerList = true,
    uiZoom = 70,
    playerListZoom = 100,
    clickSound = true,
    uiVolume = 0.3,
    positions = {
        radio = { top = '60%', left = '70%' },
        playerList = { top = '26rem', right = '0rem' }
    },
    animationIndex = 1,
}

-- Channels restricted to specific jobs.
-- Players without the specified job will not be able to connect.
Config.JobOnlyChannels = {
    ['1'] = { 'bcso', 'sasp', 'gov', 'safd',  }, -- Only players with the 'police' or 'lspd' job can access channel '1'
    ['2'] = { 'bcso', 'sasp', 'gov', 'safd',  },
    ['3'] = { 'bcso', 'sasp', 'gov', 'safd',  },
    ['4'] = { 'bcso', 'sasp', 'gov', 'safd',  },
    ['5'] = { 'bcso', 'sasp', 'gov', 'safd',  },
    ['6'] = { 'bcso', 'sasp', 'gov', 'safd',  },
    ['7'] = { 'bcso', 'sasp', 'gov', 'safd',  },
    ['8'] = { 'bcso', 'sasp', 'gov', 'safd', 'impound_ls' },
    ['9'] = { 'bcso', 'sasp', 'gov', 'safd', 'impound_ls' },
    ['10'] = { 'bcso', 'sasp', 'gov', 'safd', 'impound_ls' },
}

Config.AllowCallSignChangeJobs = {
    bcso = true,
    sasp = true,
    gov = true,
    ems = true,
    fire = true,
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