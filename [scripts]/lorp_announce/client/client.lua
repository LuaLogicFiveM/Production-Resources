local lastCoords = nil
local Config = lib.load('config')

RegisterNetEvent('lorp_announce:showAd')
AddEventHandler('lorp_announce:showAd', function(adData)
    lastCoords = adData.coords

    SendNUIMessage({
        type = adData.type,
        title = adData.title,
        content = adData.content,
        image = adData.image,
        coords = adData.coords,
        category = adData.category,
        gpsText = adData.gpsText or Config.Texts.Interface.GPSButtonText
    })
end)

-- New event to open creation interface
RegisterNetEvent('lorp_announce:openCreateInterface')
AddEventHandler('lorp_announce:openCreateInterface', function(jobData)
    SetNuiFocus(true, true)
    SendNUIMessage({ type = "openCreateInterface", jobData = jobData })
end)

local function MarkAnnouncementGPS()
    if lastCoords then
        SetNewWaypoint(lastCoords.x, lastCoords.y)
        lib.notify({ description = Config.Texts.GPS.LocationMarked, type = 'success', title = 'Announcements', position = 'top' })
    end
end

RegisterNUICallback('marcarGPS', function(data, cb)
    MarkAnnouncementGPS()
    cb({})
end)

-- Callback to close creation interface
RegisterNUICallback('closeCreateInterface', function(data, cb)
    SetNuiFocus(false, false)
    cb({})
end)

-- Callback to create announcement - FIXED to send all data
RegisterNUICallback('createAnnounce', function(data, cb)
    SetNuiFocus(false, false)
    TriggerServerEvent('lorp_announce:createAnnounce', data)
    cb({})
end)

RegisterNUICallback('closeAnnouncement', function(data, cb)
    SetTimeout(1000*60, function()
        lastCoords = nil
    end)
    cb({})
end)

RegisterCommand("markGPS", function()
    MarkAnnouncementGPS()
end, false)

RegisterKeyMapping('markGPS', Config.Texts.GPS.KeyMappingDescription, 'keyboard', 'H')