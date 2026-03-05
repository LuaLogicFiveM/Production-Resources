---@script core/server/classes/Webhook.lua

---@class Webhook
---@field url string
Webhook = Webhook or {}
Webhook.url = "WEBHOOK_URL"

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

---@param source integer
---@param log_data {embed: table, data: table}
local function log_Action(source, log_data)
    local embed = log_data.embed
    local data = log_data.data

    if not cfg.discordLog.logActions[data.action] then return end

    local fields = {
        {
            name = "**Identifier:**",
            value = string.format([[*%s*]], data.particleId or "N/A"),
            inline = true
        }
    }

    if data.action == 'fire_creation_manual' or data.action == 'fire_creation_automatic' then
        embed[1]['title'] = data.action == 'fire_creation_manual' and "**Fire Created Manually**" or
            "**Fire Created Automatically**"
        table.insert(fields, {
            name = "**Position:**",
            value = string.format([[*%s*]], tostring(data.particleData.ptfxData.pos)),
            inline = true
        })
        table.insert(fields, {
            name = "**Scale:**",
            value = string.format([[*%s*]], tostring(data.particleData.ptfxData.scale)),
            inline = true
        })
        table.insert(fields, {
            name = "**Is Spreadable:**",
            value = string.format([[*%s*]], tostring(data.particleData.canSpread)),
            inline = true
        })
        table.insert(fields, {
            name = "**Behaviour Type:**",
            value = string.format([[*%s*]], tostring(data.particleData.behaviourType)),
            inline = true
        })
        table.insert(fields, {
            name = "**Effect Type:**",
            value = string.format([[*%s*]], tostring(data.particleData.ptfxData.type)),
            inline = true
        })
    elseif data.action == 'fire_extinguished' then
        embed[1]['title'] = "**Fire Extinguished**"
    elseif data.action == 'fire_deletion' then
        embed[1]['title'] = "**Fire Deleted**"
    elseif data.action == 'smoke_creation_manual' or data.action == 'smoke_creation_automatic' then
        embed[1]['title'] = data.action == 'smoke_creation_manual' and "**Smoke Created Manually**" or
            "**Smoke Created Automatically**"
        table.insert(fields, {
            name = "**Position:**",
            value = string.format([[*%s*]], tostring(data.particleData.ptfxData.pos)),
            inline = true
        })
        table.insert(fields, {
            name = "**Scale:**",
            value = string.format([[*%s*]], tostring(data.particleData.ptfxData.scale)),
            inline = true
        })
        table.insert(fields, {
            name = "**Can be Dispersed:**",
            value = string.format([[*%s*]], tostring(data.particleData.canDisperse)),
            inline = true
        })
    elseif data.action == 'smoke_deletion' then
        embed[1]['title'] = "**Smoke Deleted**"
    elseif data.action == 'duty_booking' then
        if data.duty ~= nil then
            embed[1]['title'] = "**User Booked On Duty**"
            table.insert(fields, {
                name = "**Booked As:**",
                value = string.format([[*Department: %s*]], tostring(data.department)),
                inline = false
            })
            table.insert(fields, {
                name = "**Time:**",
                value = os.date("%X %p"),
                inline = false
            })
        else
            embed[1]['title'] = "**User Booked Off Duty**"
            table.insert(fields, {
                name = "**Time:**",
                value = os.date("%X %p"),
                inline = true
            })
        end
    elseif data.action == 'incident_generation' then
        embed[1]['title'] = "**New Incident Created**"
        table.insert(fields, {
            name = "**Type:**",
            value = string.format([[*%s*]], data.type),
            inline = false
        })
        table.insert(fields, {
            name = "**Details:**",
            value = string.format([[*%s*]], data.details),
            inline = false
        })
        table.insert(fields, {
            name = "**Address:**",
            value = string.format([[*%s*]], data.address),
            inline = false
        })
    end

    embed[1]['fields'] = fields

    ---@param err integer
    ---@param text string
    ---@param headers table<string, string>
    PerformHttpRequest(Webhook.url, function(err, text, headers)
        value = true
    end, 'POST', json.encode({
        username = 'Zea Development - z_fire',
        embeds = embed,
        avatar_url = 'https://i.imgur.com/PYwCQBJ.png'
    }), { ['Content-Type'] = 'application/json' })
end

Webhook.log = log_Action

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------
