local function ConvertDispatchData(source, data)
    data = data or {}
    local loc = data.location or {}
    local blip = data.blip or {}

    local job_table = {}
    if type(data.job) == 'string' and data.job ~= '' then
        job_table = { data.job }
    elseif type(data.job) == 'table' then
        job_table = data.job
    end

    local coords = nil
    if type(loc.coords) == 'vector2' then
        coords = vector3(loc.coords.x, loc.coords.y, 0.0)
    elseif type(loc.coords) == 'table' and loc.coords.x and loc.coords.y then
        coords = vector3(loc.coords.x + 0.0, loc.coords.y + 0.0, (loc.coords.z or 0.0) + 0.0)
    end

    if not coords then
        coords = GetEntityCoords(GetPlayerPed(source))
    end

    local title = data.title or data.code or 'Title'
    local message = data.description or 'No message provided'

    local sound = 1
    if data.sound == false then
        sound = 0
    end

    local blipTimeMinutes = 5
    if type(data.time) == 'number' then
        blipTimeMinutes = math.max(1, math.floor(data.time / 60))
    end

    return {
        job_table = job_table,
        coords = coords,
        title = title,
        message = message,
        flash = false,
        sound = sound,
        blip = {
            sprite = blip.sprite or 1,
            scale = (blip.size or 1.0) + 0.0,
            colour = blip.color or 1,
            flashes = false,
            text = blip.label or title,
            time = blipTimeMinutes,
            radius = false,
        }
    }
end


local function RegisterEvents()
    RegisterLegacyExport('lb-tablet', 'AddDispatch', function(source, data)
        local convertedData = ConvertDispatchData(source, data)
        TriggerEvent('cd_dispatch:AddNotification', convertedData)
    end)

    RegisterServerEvent('lb-tablet:addDispatch', function(data)
        local source = source
        local convertedData = ConvertDispatchData(source, data)
        TriggerEvent('cd_dispatch:AddNotification', convertedData)
    end)
end

local resourceRegistered = false
local function TryRegisterResource()
    if resourceRegistered then return end
    local state = GetResourceState('lb-tablet')
    if state ~= 'started' and state ~= 'starting' then
        resourceRegistered = true
        RegisterEvents()
    end
end

TryRegisterResource()

AddEventHandler('onResourceStart', function(resName)
    if resName == 'lb-tablet' then
        TryRegisterResource()
    end
end)