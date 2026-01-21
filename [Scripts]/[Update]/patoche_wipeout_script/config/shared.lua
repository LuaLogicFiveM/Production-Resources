return {
    system = {
        enablePassword = false, -- Enable the password requirement for configuring the wipeout course
        groups = false, -- Job-based restrictions. Example: {['your_job'] = 0}. You can assign multiple jobs like this: {['police'] = 0, ['ambulance'] = 0}
        protectStartGame = false, -- If enabled, the player must have the group defined above to start the course. Set to false if groups = false
        protectStopGame = false, -- If enabled, the player must have the group defined above to stop the course. Set to false if groups = false
        notification = 'ox', -- Notification system. Supports 'ox', 'qb', or 'custom'. If 'custom', you can add your own code in the bridge file (line 17)
        playerLoaded = 'esx:playerLoaded' -- Event to detect when a player has loaded. Change to 'esx:playerLoaded' if using ESX
    },

    games = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}, -- IDs of all regular parcours to spawn when script starts
    bigGames = {1, 2, 3}, -- IDs of the multiplayers games to spawn when script starts
}