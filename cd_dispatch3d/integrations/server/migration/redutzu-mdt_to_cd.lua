local function ConvertDispatchData(source, data)
    data = data or {}
    local vehicle = data.vehicle or {}
    local coords = data.coords

    if type(coords) == 'table' and coords.x and coords.y and coords.z then
        coords = vector3(coords.x + 0.0, coords.y + 0.0, coords.z + 0.0)
    elseif not coords then
        coords = GetEntityCoords(GetPlayerPed(source))
    end

    local job_table = data.job_table or data.jobs or { 'police' }

    local minutes = 5
    if type(data.duration) == 'number' then
        minutes = math.max(1, math.floor((data.duration / 1000) / 60))
    end

    local parts = {}

    if data.street then
        parts[#parts + 1] = data.street
    end
    if data.gender then
        parts[#parts + 1] = ('Gender: %s'):format(data.gender)
    end
    if data.weapon then
        parts[#parts + 1] = ('Weapon: %s'):format(data.weapon)
    end
    if vehicle and type(vehicle) == 'table' then
        if vehicle.name then parts[#parts + 1] = ('Vehicle: %s'):format(vehicle.name) end
        if vehicle.plate then parts[#parts + 1] = ('Plate: %s'):format(vehicle.plate) end
        if vehicle.color then parts[#parts + 1] = ('Color: %s'):format(vehicle.color) end
    end

    local messageBase = data.title or data.code or 'DISPATCH'
    local messageExtra = (#parts > 0) and (' (%s)'):format(table.concat(parts, ' | ')) or ''
    local message = messageBase .. messageExtra

    return {
        job_table = job_table,
        coords = coords,
        title = data.code or 'DISPATCH',
        message = message,
        flash = 0,
        sound = 1,
        blip = {
            sprite = 1,
            scale = 1.0,
            colour = 1,
            flashes = false,
            text = data.code or 'DISPATCH',
            time = minutes,
            radius = false,
        }
    }
end

local function RegisterEvents()
    RegisterServerEvent('redutzu-mdt:server:addDispatchToMDT', function(data)
        local src = source or 0
        local converted = ConvertDispatchData(src, data)
        TriggerEvent('cd_dispatch:AddNotification', converted)
    end)

    RegisterServerEvent('redutzu-mdt:server:sendDispatchMessage', function(data)
        local src = source
        local converted = ConvertDispatchData(src, data)
        TriggerEvent('cd_dispatch:AddNotification', converted)
    end)
end

local resourceRegistered = false
local function TryRegisterResource()
    if resourceRegistered then return end
    local state = GetResourceState('redutzu-mdt')
    if state ~= 'started' and state ~= 'starting' then
        resourceRegistered = true
        RegisterEvents()
    end
end

TryRegisterResource()

AddEventHandler('onResourceStart', function(resName)
    if resName == 'redutzu-mdt' then
        TryRegisterResource()
    end
end)