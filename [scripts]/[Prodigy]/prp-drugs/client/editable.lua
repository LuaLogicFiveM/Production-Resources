---@param id number
---@param potName string
---@param pos vector3
---@param heading number
---@param locationId number
---@param lastWatered number
AddEventHandler("prp-drugs:client:potCreated", function(id, potName, pos, heading, locationId, lastWatered)
end)

---@param id number
AddEventHandler("prp-drugs:client:removePot", function(id)
end)

---@param potId number
---@param cropIds number[] list of all the crop ids harvested
AddEventHandler("prp-drugs:client:cropsHarvested", function(potId, cropIds)
end)

---@param allowlist DrugsAllowlistTypes
---@return boolean
function HasAllowlist(allowlist)
    if not Config.UseBridgeAllowlist then
        return true
    end

    return exports["prp-bridge"]:IsAllowlisted(allowlist)
end

CreateThread(function()
    Wait(100)
    SendNUIMessage({
        action = "setInventoryImgTemplate",
        data = bridge.inv.getItemImageUrl("{item}")
    })
end)