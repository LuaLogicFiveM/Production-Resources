-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

function DrawTextAboveHead(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(pX, pY, pZ, x, y, z, 1)
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

---@param type 'enemy'
function ShowMarker(type, coords)
    if type == 'enemy' then
        DrawMarker(27, coords.x, coords.y, coords.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 255, 0, 0, 100, false, false, 2, false, false, false, false)
    end
end