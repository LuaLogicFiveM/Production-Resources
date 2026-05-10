local ESX, QBCore
CreateThread(function()
    if GetResourceState('es_extended') == 'started' then ESX = exports['es_extended']:getSharedObject() end
    if GetResourceState('qb-core')    == 'started' then QBCore = exports['qb-core']:GetCoreObject() end
end)

local VM = require 'server.classes.manager'

local groups = {
    ['admin'] = true,
    ['manager'] = true,
    ['owner'] = true
}

---@param src number
---@return boolean
local function isAdmin(src)
    local x = ESX.GetPlayerFromId(src)
    local g = x:getGroup()
    return x and g and groups[g] or false
end

---@param src number
---@return string
local function idOf(src)
    local ids = GetPlayerIdentifiers(src)
    local best
    for i = 1, #ids do
        local v = ids[i]
        if v:sub(1, 8) == 'license:' then return v end
        if not best and (v:sub(1, 8) == 'discord:' or v:sub(1, 6) == 'steam:' or v:sub(1, 5) == 'fivem') then best = v end
    end
    return best or ('src:%s'):format(src)
end

local rate = {}

---@param src number
---@param key string
---@param max integer
---@param win integer
---@return boolean
local function ratelimit(src, key, max, win)
    local k   = ('%s_%s'):format(src, key)
    local now = os.time()
    local e   = rate[k]
    if not e or now - e.t > win then rate[k] = { c = 1, t = now } return true end
    e.c = e.c + 1
    return e.c <= max
end

AddEventHandler('playerDropped', function()
    local s = source
    for k in pairs(rate) do if k:find('^' .. s .. '_') then rate[k] = nil end end
end)

-- callbacks
lib.callback.register('lorp_polls:getActive', function()
    return VM:list()
end)

lib.callback.register('lorp_polls:create', function(src, data)
    if not isAdmin(src) then return false end
    if VM:hasActive() then return false end
    if not ratelimit(src, 'create', 10, 60) then return false end
    if type(data) ~= 'table' then return false end

    local title    = tostring(data.title or '')
    local duration = tonumber(data.duration) or Config.Durations.Default
    local options  = type(data.options) == 'table' and data.options or {}

    local ok, v = VM:create(title, options, duration, src)
    if not ok then return false end
    return v:toClient()
end)

lib.callback.register('lorp_polls:submit', function(src, data)
    if not ratelimit(src, 'submit', 15, 10) then return false end
    if type(data) ~= 'table' then return false end
    local id  = tostring(data.id or '')
    local opt = tonumber(data.option)
    if id == '' or not opt then return false end
    return VM:submit(id, src, opt, idOf(src))
end)

lib.callback.register('lorp_polls:canInteract', function()
    return VM:hasActive()
end)

---@param src number
---@param payload table
---@return boolean
lib.callback.register('lorp_polls:validatePush', function(src, payload)
    if type(payload) ~= 'table' or payload.kind == nil then return false end

    if payload.kind == 'state' then
        local v = payload.vote
        if type(v) ~= 'table' or not v.id or not v.endsAt then return false end
        local sv = VM.active[v.id]
        return (sv ~= nil) and (sv.endsAt == v.endsAt)

    elseif payload.kind == 'ended' then
        local v = payload.vote
        if type(v) ~= 'table' or not v.id or not v.endsAt then return false end
        local sv = VM.active[v.id]
        return (sv == nil) and (v.endsAt <= os.time())

    elseif payload.kind == 'announce' then
        local hasTs = (type(payload.ts) == 'number')
        return VM:hasActive() or (hasTs and (os.time() - payload.ts <= 10))

    elseif payload.kind == 'visibility' then
        return type(payload.on) == 'boolean'

    elseif payload.kind == 'openCreate' then
        return isAdmin(src) and not VM:hasActive()

    elseif payload.kind == 'interact' then
        return VM:hasActive()

    elseif payload.kind == 'toggle' then
        return true
    end

    return false
end)


-- commands
local function trim(s) return (s:gsub('^%s+', ''):gsub('%s+$', '')) end
local function splitOpts(s) local t = {} for part in s:gmatch('[^|]+') do t[#t+1] = trim(part) end return t end

lib.addCommand(Config.Commands.Start, {
    help = 'Start Poll: /pollstart <duration> <title> | <opt1> | <opt2> [...] (no args = creator)'
}, function(src, args)
    if not isAdmin(src) then
        lib.notify(src, { title='Poll', description='No permission', type='error', position=Config.Notify.Position, duration=Config.Notify.Duration })
        return
    end
    if VM:hasActive() then
        lib.notify(src, { title='Poll', description='A poll is already running.', type='error', position=Config.Notify.Position, duration=3000 })
        return
    end
    if #args == 0 then
        TriggerClientEvent('lorp_polls:push', src, { kind = 'openCreate' })
        return
    end

    local joined = table.concat(args, ' ')
    local dur, rest = joined:match('^(%d+)%s+(.+)$')
    dur = tonumber(dur or '') or Config.Durations.Default
    if not rest then
        lib.notify(src, { title='Poll', description='Usage: /startpoll <duration> <title> | <opt1> | <opt2> [...]', type='error', position=Config.Notify.Position, duration=Config.Notify.Duration })
        return
    end

    local parts = splitOpts(rest)
    if #parts < 3 then
        lib.notify(src, { title='Poll', description='Provide a title and at least 2 options separated by |', type='error', position=Config.Notify.Position, duration=Config.Notify.Duration })
        return
    end

    local title = parts[1]
    local opts  = {}
    for i = 2, #parts do opts[#opts+1] = parts[i] end

    local ok = VM:create(title, opts, dur, src)
    if not ok then
        lib.notify(src, { title='Poll', description='Failed to create poll.', type='error', position=Config.Notify.Position, duration=Config.Notify.Duration })
    else
        lib.notify(src, { title='Poll', description='Poll created.', type='success', position=Config.Notify.Position, duration=3000 })
    end
end)

lib.addCommand(Config.Commands.Open, { help = 'Toggle poll interaction' }, function(src)
    if not VM:hasActive() then
        lib.notify(src, { title='Poll', description='No active polls.', type='error', position=Config.Notify.Position, duration=2500 })
        return
    end
    TriggerClientEvent('lorp_polls:push', src, { kind = 'interact' })
end)

lib.addCommand(Config.Commands.Toggle, { help = 'Show/hide poll widget' }, function(src)
    TriggerClientEvent('lorp_polls:push', src, { kind = 'toggle' })
end)
