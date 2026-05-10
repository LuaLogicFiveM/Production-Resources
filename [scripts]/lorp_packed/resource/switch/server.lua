local config = require 'resource.switch.shared'
local ox_inventory = exports.ox_inventory

RegisterCommand("switch", function(source)
    local weapon = ox_inventory:GetCurrentWeapon(source)
    if weapon and config.weapons[weapon.name] then
        if weapon.metadata.switch == nil then
            local switches = ox_inventory:Search(source, "count", "switch")
            if switches > 0 then
                weapon.metadata.switch = 'Installed'
                ox_inventory:SetMetadata(source, weapon.slot, weapon.metadata)
                TriggerClientEvent("lorp_packed:client:applySwitch", source, weapon)
                ox_inventory:RemoveItem(source, "switch", 1)
            else
                lib.notify(source, {title = 'Switches', description = "You do not have a switch", position = 'top'})
            end
        else
            weapon.metadata.switch = nil
            ox_inventory:SetMetadata(source, weapon.slot, weapon.metadata)
            TriggerClientEvent("lorp_packed:client:applySwitch", source, weapon, true)
            ox_inventory:AddItem(source, "switch", 1)
        end
    else
        lib.notify(source, {title = 'Switches', description = "You do not have a weapon out", position = 'top'})
    end
end, false)