Config = {}

-- Basic settings
Config.Framework = 'esx' -- 'esx' or 'qb'
Config.Locale = 'en' -- 'cs' or 'en'

-- GPS Item
Config.GPSItem = 'gps' -- GPS item name
Config.CommandName = 'gpscrew' -- Command name

-- Crew settings
Config.MaxCrewSize = 15 -- Maximum crew members
Config.MaxDistance = 10000 -- Max distance to show on map (0 = unlimited)

-- Blip settings
Config.Blips = {
    Leader = {
        sprite = 480, -- Blip icon for leader
        color = 5,    -- Blip color (yellow)
        scale = 0.9,
        label = 'Leader'
    },
    Member = {
        sprite = 480, -- Blip icon for members
        color = 3,    -- Blip color (blue)
        scale = 0.8,
        label = 'Crew Member'
    }
}

-- Notification settings
Config.NotificationDuration = 5000 -- Notification duration in ms
Config.NotificationPosition = 'top' -- Notification position

-- Auto accept timeout
Config.AutoAcceptTimeout = 30000 -- Timeout for auto-declining invites (30 seconds)

-- Refresh rate
Config.BlipUpdateInterval = 1000 -- How often to update blips (ms)
