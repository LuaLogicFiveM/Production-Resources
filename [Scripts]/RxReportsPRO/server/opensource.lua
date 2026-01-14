--[[
BY RX Scripts © rxscripts.xyz
--]]

---@param title string
---@param fields {name: string, value: string, inline: boolean}[]
---@param color number
---@param webhook string
function Log(title, fields, color, webhook)
    -- You can modify this function to send logs to your preferred service
    -- Default implementation uses Discord webhooks
    ToDiscord(title, fields, color, webhook)
end

function BringPlayer(staffId, reporterId)
    local c = GetEntityCoords(GetPlayerPed(staffId))
    SetEntityCoords(GetPlayerPed(reporterId), c)
    return true
end

function GoToPlayer(staffId, reporterId)
    local c = GetEntityCoords(GetPlayerPed(reporterId))
    SetEntityCoords(GetPlayerPed(staffId), c)
    return true
end

function TeleportPlayer(reporterId, coords)
    SetEntityCoords(GetPlayerPed(reporterId), coords)
    return true
end

function NotifyStaff()
    local playerSources = GetPlayers()

    for _, src in pairs(playerSources) do
        src = tonumber(src)
        local p = FM.player.get(src)

        if p and IsStaff(src) and not NotificationsDisabled[p.getIdentifier()] then
            p.notify(_L('new_report'))
        end
    end
end

function CanDeleteReport(src, report)
    return false
end

-- Custom Permission check to see if the player can clear all reports in-game & from database
function CanClearReports(src)
    local p = FM.player.get(src)
    if not p or not IsStaff(src) then
        return false
    end

    return true
end