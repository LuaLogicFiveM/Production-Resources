BlipUtil = {}
local activeBlipHandles = {}

function BlipUtil.add(id, label, coords, sprite, colour, scale, display, category, flashes)
    if activeBlipHandles[id] then
        BlipUtil.remove(id)
    end

    local handle = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(handle, sprite)
    SetBlipColour(handle, colour)
    SetBlipScale(handle, scale)
    SetBlipDisplay(handle, display or 4)
    SetBlipCategory(handle, category or 1)
    SetBlipAsShortRange(handle, true)

    if flashes then
        SetBlipFlashes(handle, true)
    end

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label)
    EndTextCommandSetBlipName(handle)

    activeBlipHandles[id] = handle
    return handle
end

function BlipUtil.addRadius(id, coords, radius, colour, alpha)
    if activeBlipHandles[id] then
        BlipUtil.remove(id)
    end

    local handle = AddBlipForRadius(coords.x, coords.y, coords.z, radius)
    SetBlipColour(handle, colour)
    SetBlipAlpha(handle, alpha or 128)

    activeBlipHandles[id] = handle
    return handle
end

function BlipUtil.remove(id)
    local handle = activeBlipHandles[id]
    if not handle then return end

    if DoesBlipExist(handle) then
        RemoveBlip(handle)
    end

    activeBlipHandles[id] = nil
end
