local shownZones = {}

local function ShowZone(zoneName, hour, minute)
    SendNUIMessage({
        action = "show",
        location = zoneName,
        hour = hour,
        minute = minute
    })
    SetNuiFocus(false, false)
end

CreateThread(function()
    for i, zone in ipairs(Config.Locations) do
        local function onEnter(self)
            if not shownZones[i] then
                shownZones[i] = true
                local hour = GetClockHours()
                local minute = GetClockMinutes()
                ShowZone(self.label, hour, minute)
            end
        end

        local function onExit(self)
            shownZones[i] = false
        end

        local poly = lib.zones.poly({
            points = zone.points,
            label = zone.label,
            thickness = 20,
            debug = false,
            onEnter = onEnter,
            onExit = onExit
        })
    end
end)