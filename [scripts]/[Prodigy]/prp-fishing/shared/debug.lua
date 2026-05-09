local ENABLED = false
local table = table

local function drawDebugLine(instance, line)
    BeginTextCommandDisplayText('STRING')
    SetTextCentre(false)
    SetTextJustification(1)
    SetTextScale(instance.scale, instance.scale)
    SetTextFont(instance.font)
    SetTextOutline()
    AddTextComponentSubstringPlayerName(line)
    DrawText(instance.x, instance.y)
    instance.y = instance.y + instance.lineHeight
end

local debugMethods = {
    add = function(instance, ...)
        local numElements = select('#', ...)
        local elements = { ... }
        local line = ''
        for i = 1, numElements do
            local element = tostring(elements[i])
            if i ~= 1 then
                line = line .. ' '
            end
            line = line .. element
        end
        table.insert(instance.buffer, line)
        while #instance.buffer > 25 do
            table.remove(instance.buffer, 1)
        end
    end,
    flush = function(instance)
        if instance.active then
            drawDebugLine(instance, instance.header)
            for i, debugEntry in ipairs(instance.buffer) do
                drawDebugLine(instance, debugEntry)
            end

            instance.y = instance.reset
        end
        instance.buffer = {}
    end,
}

local debugMeta = {
    __call = function(instance, ...)
        instance:add(...)
    end,
    __newindex = function(instance, key, value)
        -- Just drop. Ignore. Go away.
    end,
    __index = function(instance, key)
        return instance._methods[key]
    end,
}

debug = {
    active = ENABLED,
    header = '~y~[Debugging ' .. GetCurrentResourceName() .. ']',
    x = 0.02,
    y = 0.33,
    reset = 0.33,
    lineHeight = 0.015,
    font = 0,
    scale = 0.25,
    spacing = 0.2,
    buffer = {},
    _methods = debugMethods,
}
setmetatable(debug, debugMeta)

function DebugSphere(where, scale, r, g, b, a)
    scale = scale or 1.0
    r = r or 255
    b = b or 255
    g = g or 255
    a = a or 128
    DrawMarker(
        28,                  -- type
        where,               -- location
        0.0, 0.0, 0.0,       -- direction (?)
        0.0, 0.0, 0.0,       -- rotation
        scale, scale, scale, -- scale
        r, g, b, a,          -- color
        false,               -- bob
        false,               -- face camera
        2,                   -- dunno, lol, 100% cargo cult
        false,               -- rotates
        0, 0,                -- texture
        false                -- Projects/draws on entities
    )
end

function Debug3DText(coords, text, scale)
    if not scale then scale = 0.35 end

    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
end

function merge(a, b)
    if type(a) == 'table' and type(b) == 'table' then
        a = lib.table.deepclone(a)
        b = lib.table.deepclone(b)

        for k, v in pairs(b) do
            if type(v) == 'table' and type(a[k] or false) == 'table' then
                merge(a[k], v)
            else
                a[k] =
                    v
            end
        end
    end
    return a
end
