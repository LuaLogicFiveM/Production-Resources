UI = {
    isEditorOpen = false,
    cachedPreferences = nil,
    cachedStats = nil,
}

function UI.OpenEditor()
    if UI.isEditorOpen then return end
    UI.isEditorOpen = true
    SetNuiFocus(true, true)

    local data = lib.callback.await('eg_killfeed:server:getPreferences', false)

    SendNUIMessage({
        type = 'openEditor',
        data = data
    })
end

function UI.CloseEditor()
    if not UI.isEditorOpen then return end
    UI.isEditorOpen = false
    SetNuiFocus(false, false)

    SendNUIMessage({
        type = 'closeEditor'
    })
end

RegisterNetEvent('eg_killfeed:client:addKill', function(killData)
    SendNUIMessage({
        type = 'addKill',
        data = killData
    })
end)

RegisterNetEvent('eg_killfeed:client:updateStats', function(kills, deaths)
    SendNUIMessage({
        type = 'updateStats',
        data = { kills = kills, deaths = deaths }
    })
end)

RegisterNetEvent('eg_killfeed:client:updateStreak', function(streak)
    SendNUIMessage({
        type = 'updateStreak',
        data = { streak = streak }
    })
end)

RegisterNetEvent('eg_killfeed:client:loadData', function(preferences, stats)
    UI.cachedPreferences = preferences
    UI.cachedStats = stats
    SendNUIMessage({
        type = 'loadData',
        preferences = preferences,
        stats = stats
    })
end)

RegisterNetEvent('eg_killfeed:client:clanInvitation', function(data)
    SendNUIMessage({
        type = 'clanInvitation',
        data = data
    })
end)

RegisterNetEvent('eg_killfeed:client:clanUpdated', function()
    local data = lib.callback.await('eg_killfeed:server:getInitialData', false)
    if data then
        SendNUIMessage({
            type = 'loadData',
            preferences = data.preferences,
            stats = data.stats
        })
    end
end)

return UI
