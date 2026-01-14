local function ConvertDispatchItem(old, idOverride)
    if type(old) ~= "table" then return nil end

    local function trim(s) return (tostring(s or ""):gsub("^%s+",""):gsub("%s+$","")) end
    local function slugify(s) s = tostring(s or ""):lower():gsub("[^%w%s%-_]",""):gsub("%s+","_"); return s end
    local function parseTitle(t)
        t = trim(t)
        local c,l = t:match("^([%d%-]+)%s*%-%s*(.+)$"); if c then return c, trim(l) end
        c,l = t:match("^([%d%-]+)%s+(.+)$"); if c then return c, trim(l) end
        return "NONE", (t ~= "" and t or "UNKNOWN")
    end
    local function mapJobs(js)
        local out = {}
        if type(js) == "table" then
            for _,j in pairs(js) do
                local jl = tostring(j or ""):lower()
                if jl == "police" or jl == "pd" or jl == "sheriff" or jl == "state" then
                    out[#out+1] = "leo"
                elseif jl == "ambulance" or jl == "ems" then
                    out[#out+1] = "ems"
                else
                    out[#out+1] = j
                end
            end
        end
        if #out == 0 then out[1] = "leo" end
        return out
    end
    local function coordsToVec3String(c)
        return vec3(c.x, c.y, c.z)
    end
    local function extractStreet(msg)
        local after = tostring(msg or ""):match("%sat%s(.+)$")
        return trim(after or "Unknown")
    end
    local function guessIcon(codeName)
        codeName = tostring(codeName or ""):lower()
        if codeName:find("fight") then return "fas fa-hand-fist" end
        if codeName:find("shoot") or codeName:find("gun") then return "fas fa-gun" end
        if codeName:find("rob") or codeName:find("theft") or codeName:find("store") then return "fas fa-store" end
        if codeName:find("explosion") or codeName:find("fire") then return "fas fa-fire" end
        if codeName:find("car") or codeName:find("vehicle") or codeName:find("speed") then return "fas fa-car" end
        return "fas fa-question"
    end

    local code, label   = parseTitle(old.title)
    local codeName      = slugify(label ~= "" and label or code)
    local jobs          = mapJobs(old.job_table)
    local timeMs        = (tonumber(old.epoch) or 0) * 1000
    local coordsStr     = coordsToVec3String(old.coords)
    local street        = extractStreet(old.message)
    local icon          = guessIcon(codeName)
    local msgText       = (label ~= "" and label) or (old.message or "Unknown")

    local newItem = {
        units    = {},
        gender   = "Male",
        message  = msgText,
        priority = 2,
        responses= {},
        jobs     = jobs,
        street   = (street ~= "" and street) or "Unknown",
        codeName = codeName,
        coords   = coordsStr,
        code     = code,
        time     = timeMs,
        icon     = icon,
        id       = idOverride or 1,
    }

    return newItem
end

function ConvertDispatchList(oldList)
    local out, i = {}, 0
    if type(oldList) ~= "table" then return out end
    for _, old in pairs(oldList) do
        i = i + 1
        out[i] = ConvertDispatchItem(old, i)
    end
    return out
end

function GetDispatchCalls_PS()
    return ConvertDispatchList(AllDispatchCalls)
end