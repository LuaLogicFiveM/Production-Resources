-- you need to trigger this event every time your players route bucket changes, if you want device inside routes
---@param newRoute number
RegisterNetEvent("prp-security:client:client:routeChanged", function(newRoute)
    PlayerRouteChanged(newRoute)
end)

---@param state boolean is the camera on or not
function ToggleCamera(state)
end


function CanDestroyDevice()
    -- add any custom logic here to prevent destroying a device via target
    return true
end
