---@class bridge
bridge = {}

---@param info { name: string, label: string, rank: { name: string, label: string, num: number }}
---@param type 'left' | 'joined' | 'updated'
AddEventHandler('spoodyGangs:clientGangUpdated', function(info, type)
    --- Used whenever a player's gang is updated
    --- You can use the 'type' to fork whichever functionality you want
    --- EXAMPLE: You can put your custom HUD system here instead of our included one!
end)

RegisterNetEvent('spoodyGangs:turfAlert', function(message)
    local cfg = Configuration.Settings.Alerts
    if not cfg.Enabled then return end

    PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", true)
    SendNUIMessage({
        action = 'showAnnouncement',
        data = {
            visible = true,
            style = cfg.Style,
            title = 'Turf Wars',
            description = message,
            timer = cfg.Timers.Turfs
        }
    })
end)

--- TURF RESPAWN MODE
--- This is the exact event that is triggered when a player is revived in a turf.
--- In case you use your own custom ambulance system, you can incorporate your revive function here
RegisterNetEvent('spoodyGangs:clientTurfRevive', function(turfId)
    local locations = Configuration.Turfs[turfId].coordinates.exitPoints
    local index     = locations[math.random(1, #locations)]

    if index then
        TriggerEvent('esx_ambulancejob:revive')

        --- Randomly select a new respawn point in the turf
        ---@diagnostic disable-next-line: missing-parameter
        SetEntityCoordsNoOffset(cache.ped, index.x, index.y, index.z)
    end
end)

---Fired on the killer when they eliminate a player inside a turf.
---turfId      : the turf the kill occurred in
---victimSource: server ID of the player that was killed
RegisterNetEvent('spoodyGangs:onKill', function(turfId, victimSource)
    -- Add any additional killer-side FX here (kill feed, sound, etc.)
end)

--- In case you use a custom ambulance job that doesn't use conventional death checks
--- You can implement compatability here.
function bridge.isPlayerDeceased(ped)
    local id = GetPlayerServerId(GetPlayerPed(ped))

    if GetResourceState('wasabi_ambulance') == 'started' or GetResourceState('wasabi_ambulance') == 'starting' then
        return exports.wasabi_ambulance:isPlayerDead(id)
    end

    return IsEntityDead(ped)
end

--- If you are on a custom framework, you can edit this function here
function bridge.hasPlayerInitiated()
    return ESX.IsPlayerLoaded()
end

---@param type 'inform' | 'error' | 'success' | 'warning'
function bridge.notifyClient(title, message, type)
    if not title then
        title = 'spoodyGangs'
    end

    lib.notify({
        title = title,
        description = message,
        type = type or 'inform',
        position = 'top',
        duration = 5000
    })
end

RegisterNetEvent('spoodyGangs:notifyClient', function(title, message, type)
    return bridge.notifyClient(title, message, type)
end)