-- [[ Exports ]]

-- Applies the gas effect to the player based on the specified command.
-- @param weaponName string The command identifying the type of gas effect to apply (e.g., pepper spray).
exports('SetGassedPlayer', function(weaponName)
    if Config.PepperSpray[weaponName] then
        applyGasEffect(weaponName)
    end
end)

-- Removes the gas effect from the player.
exports('RemoveGas', function()
    resetGassedPlayer()
end)

-- Sets the amount of spray available to the player (pepper spray or decontamination spray).
-- @param quantity number The amount of spray to set for the player.
exports('SetPepperQuantity', function(quantity)
    if currentPepperSpray then
        sprayQuantity[currentPepperSpray] = quantity
    end
end)

-- Returns whether the player is currently gassed or not.
-- @return boolean True if the player is gassed, false otherwise.
exports('IsGassed', function()
    if isPlayerGassed == nil then
        return false
    else
        return true
    end
end)