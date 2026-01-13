function RoundDecimals(data) --converts to table and rounds to 2 decimal places.
    if type(data) == 'vector4' then
        local x = math.floor(data.x * 100 + 0.5) / 100
        local y = math.floor(data.y * 100 + 0.5) / 100
        local z = math.floor(data.z * 100 + 0.5) / 100
        local h = math.floor(data.w * 100 + 0.5) / 100
        return { x = x, y = y, z = z, h = h }

    elseif type(data) == 'vector3' then
        local x = math.floor(data.x * 100 + 0.5) / 100
        local y = math.floor(data.y * 100 + 0.5) / 100
        local z = math.floor(data.z * 100 + 0.5) / 100
        return { x = x, y = y, z = z }

    elseif type(data) == 'number' then
        return math.floor(data * 100 + 0.5) / 100

    elseif type(data) == 'table' then
        for c, d in pairs(data) do
            d = math.floor(d * 100 + 0.5) / 100
        end
        return data
    end
end

function Round(num)
    return num >= 0 and math.floor(num + 0.5) or math.ceil(num - 0.5)
end

function Trim(str)
    return str:match("^%s*(.-)%s*$")
end

function CapitalizeFirst(str)
    return (str:gsub("^%l", string.upper))
end

function IsBlankString(str)
    return type(str) ~= 'string' or str:match('^%s*$') ~= nil
end

local __uid_counter = 0
function GenerateUniqueId(length)
    length = length or 16
    __uid_counter = __uid_counter + 1

    local ALPH = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local parts = {}

    local blocks = math.ceil(length / 6)

    for _ = 1, blocks do
        local t = GetGameTimer()
        local salt = string.format(
            '%d:%d:%d:%d:%d:%d',
            t * math.random(17, 97),
            t + math.random(0, 0x7FFFFFFF),
            __uid_counter * math.random(3, 29),
            math.random(0, 0x7FFFFFFF),
            math.random(0, 0x7FFFFFFF),
            (t % 1000) * math.random(1, 1000)
        )

        local h = 2166136261
        for i = 1, #salt do
            h = (h ~ salt:byte(i)) & 0xFFFFFFFF
            h = (h * 16777619) % 0x100000000
        end

        local block = {}
        for i = 1, 6 do
            local idx = (h % #ALPH) + 1
            block[i] = ALPH:sub(idx, idx)
            h = math.floor(h / #ALPH)
        end

        parts[#parts + 1] = table.concat(block)
    end

    local raw = table.concat(parts):sub(1, length)

    local t = {}
    for i = 1, #raw do
        t[i] = raw:sub(i, i)
    end
    for i = #t, 2, -1 do
        local j = math.random(1, i)
        t[i], t[j] = t[j], t[i]
    end
    raw = table.concat(t)

    local out = {}
    for i = 1, length do
        out[#out + 1] = raw:sub(i, i)
        if i % 4 == 0 and i < length then
            out[#out + 1] = '-'
        end
    end

    return table.concat(out)
end