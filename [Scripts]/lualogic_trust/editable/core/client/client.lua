local config = require 'config'

function Notify(message, type)
    return lib.notify({title = 'Trust System', description = message, type = type, position = 'top'})
end

lib.callback.register('lualogic_trust:client:loaded', function(vehicle)
    return IsModelInCdimage(vehicle) == 1 and IsModelValid(vehicle) == 1
end)

CreateThread(function()
	if config.modules.trust.give.locations.enabled then
		for _, blipData in pairs(config.modules.trust.give.locations.zones) do
			if blipData.radius.enable then
                local zone = AddBlipForRadius(blipData.coords.x, blipData.coords.y, blipData.coords.z, blipData.radius.radius)
                SetBlipColour(zone, blipData.radius.color)
                SetBlipAlpha(zone, blipData.radius.opacity)
            end

            if blipData.blip.enable then
                local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
                SetBlipColour(blip, blipData.blip.color)
                SetBlipSprite(blip, blipData.blip.sprite)
                SetBlipScale(blip, blipData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipData.blip.label)
                EndTextCommandSetBlipName(blip)
            end
		end
	end

    if config.modules.owner.trade.locations.enabled then
		for _, blipData in pairs(config.modules.owner.trade.locations.zones) do
			if blipData.radius.enable then
                local zone = AddBlipForRadius(blipData.coords.x, blipData.coords.y, blipData.coords.z, blipData.radius.radius)
                SetBlipColour(zone, blipData.radius.color)
                SetBlipAlpha(zone, blipData.radius.opacity)
            end

            if blipData.blip.enable then
                local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
                SetBlipColour(blip, blipData.blip.color)
                SetBlipSprite(blip, blipData.blip.sprite)
                SetBlipScale(blip, blipData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipData.blip.label)
                EndTextCommandSetBlipName(blip)
            end
		end
	end

    if config.modules.owner.transfer.locations.enabled then
		for _, blipData in pairs(config.modules.owner.transfer.locations.zones) do
			if blipData.radius.enable then
                local zone = AddBlipForRadius(blipData.coords.x, blipData.coords.y, blipData.coords.z, blipData.radius.radius)
                SetBlipColour(zone, blipData.radius.color)
                SetBlipAlpha(zone, blipData.radius.opacity)
            end

            if blipData.blip.enable then
                local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
                SetBlipColour(blip, blipData.blip.color)
                SetBlipSprite(blip, blipData.blip.sprite)
                SetBlipScale(blip, blipData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipData.blip.label)
                EndTextCommandSetBlipName(blip)
            end
		end
	end

    if config.modules.owner.set.locations.enabled then
		for _, blipData in pairs(config.modules.owner.set.locations.zones) do
			if blipData.radius.enable then
                local zone = AddBlipForRadius(blipData.coords.x, blipData.coords.y, blipData.coords.z, blipData.radius.radius)
                SetBlipColour(zone, blipData.radius.color)
                SetBlipAlpha(zone, blipData.radius.opacity)
            end

            if blipData.blip.enable then
                local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
                SetBlipColour(blip, blipData.blip.color)
                SetBlipSprite(blip, blipData.blip.sprite)
                SetBlipScale(blip, blipData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipData.blip.label)
                EndTextCommandSetBlipName(blip)
            end
		end
	end

    if config.modules.owner.remove.locations.enabled then
		for _, blipData in pairs(config.modules.owner.remove.locations.zones) do
			if blipData.radius.enable then
                local zone = AddBlipForRadius(blipData.coords.x, blipData.coords.y, blipData.coords.z, blipData.radius.radius)
                SetBlipColour(zone, blipData.radius.color)
                SetBlipAlpha(zone, blipData.radius.opacity)
            end

            if blipData.blip.enable then
                local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
                SetBlipColour(blip, blipData.blip.color)
                SetBlipSprite(blip, blipData.blip.sprite)
                SetBlipScale(blip, blipData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipData.blip.label)
                EndTextCommandSetBlipName(blip)
            end
		end
	end

    if config.modules.owner.clear.locations.enabled then
		for _, blipData in pairs(config.modules.owner.clear.locations.zones) do
			if blipData.radius.enable then
                local zone = AddBlipForRadius(blipData.coords.x, blipData.coords.y, blipData.coords.z, blipData.radius.radius)
                SetBlipColour(zone, blipData.radius.color)
                SetBlipAlpha(zone, blipData.radius.opacity)
            end

            if blipData.blip.enable then
                local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
                SetBlipColour(blip, blipData.blip.color)
                SetBlipSprite(blip, blipData.blip.sprite)
                SetBlipScale(blip, blipData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipData.blip.label)
                EndTextCommandSetBlipName(blip)
            end
		end
	end

    if config.modules.owner.spawn.locations.enabled then
		for _, blipData in pairs(config.modules.owner.spawn.locations.zones) do
            if blipData.radius.enable then
                local zone = AddBlipForRadius(blipData.coords.x, blipData.coords.y, blipData.coords.z, blipData.radius.radius)
                SetBlipColour(zone, blipData.radius.color)
                SetBlipAlpha(zone, blipData.radius.opacity)
            end

            if blipData.blip.enable then
                local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
                SetBlipColour(blip, blipData.blip.color)
                SetBlipSprite(blip, blipData.blip.sprite)
                SetBlipScale(blip, blipData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipData.blip.label)
                EndTextCommandSetBlipName(blip)
            end
		end
	end

    if config.modules.trust.spawn.locations.enabled then
		for _, blipData in pairs(config.modules.trust.spawn.locations.zones) do
			if blipData.radius.enable then
                local zone = AddBlipForRadius(blipData.coords.x, blipData.coords.y, blipData.coords.z, blipData.radius.radius)
                SetBlipColour(zone, blipData.radius.color)
                SetBlipAlpha(zone, blipData.radius.opacity)
            end

            if blipData.blip.enable then
                local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
                SetBlipColour(blip, blipData.blip.color)
                SetBlipSprite(blip, blipData.blip.sprite)
                SetBlipScale(blip, blipData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipData.blip.label)
                EndTextCommandSetBlipName(blip)
            end
		end
	end

    if config.modules.trust.set.locations.enabled then
		for _, blipData in pairs(config.modules.trust.set.locations.zones) do
			if blipData.radius.enable then
                local zone = AddBlipForRadius(blipData.coords.x, blipData.coords.y, blipData.coords.z, blipData.radius.radius)
                SetBlipColour(zone, blipData.radius.color)
                SetBlipAlpha(zone, blipData.radius.opacity)
            end

            if blipData.blip.enable then
                local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
                SetBlipColour(blip, blipData.blip.color)
                SetBlipSprite(blip, blipData.blip.sprite)
                SetBlipScale(blip, blipData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipData.blip.label)
                EndTextCommandSetBlipName(blip)
            end
		end
	end

    if config.modules.trust.give.locations.enabled then
		for _, blipData in pairs(config.modules.trust.give.locations.zones) do
			if blipData.radius.enable then
                local zone = AddBlipForRadius(blipData.coords.x, blipData.coords.y, blipData.coords.z, blipData.radius.radius)
                SetBlipColour(zone, blipData.radius.color)
                SetBlipAlpha(zone, blipData.radius.opacity)
            end

            if blipData.blip.enable then
                local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
                SetBlipColour(blip, blipData.blip.color)
                SetBlipSprite(blip, blipData.blip.sprite)
                SetBlipScale(blip, blipData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipData.blip.label)
                EndTextCommandSetBlipName(blip)
            end
		end
	end

    if config.modules.trust.remove.locations.enabled then
		for _, blipData in pairs(config.modules.trust.remove.locations.zones) do
			if blipData.radius.enable then
                local zone = AddBlipForRadius(blipData.coords.x, blipData.coords.y, blipData.coords.z, blipData.radius.radius)
                SetBlipColour(zone, blipData.radius.color)
                SetBlipAlpha(zone, blipData.radius.opacity)
            end

            if blipData.blip.enable then
                local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
                SetBlipColour(blip, blipData.blip.color)
                SetBlipSprite(blip, blipData.blip.sprite)
                SetBlipScale(blip, blipData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipData.blip.label)
                EndTextCommandSetBlipName(blip)
            end
		end
	end

    if config.modules.trust.trade.locations.enabled then
		for _, blipData in pairs(config.modules.trust.trade.locations.zones) do
			if blipData.radius.enable then
                local zone = AddBlipForRadius(blipData.coords.x, blipData.coords.y, blipData.coords.z, blipData.radius.radius)
                SetBlipColour(zone, blipData.radius.color)
                SetBlipAlpha(zone, blipData.radius.opacity)
            end

            if blipData.blip.enable then
                local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
                SetBlipColour(blip, blipData.blip.color)
                SetBlipSprite(blip, blipData.blip.sprite)
                SetBlipScale(blip, blipData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipData.blip.label)
                EndTextCommandSetBlipName(blip)
            end
		end
	end
end)

lib.onCache('seat', function(seat)
    if seat ~= -1 then return end
    TriggerServerEvent('lualogic_trust:server:enteredVehicle', VehToNet(cache.vehicle))
end)

--[[if config.modules.system.admin.menu.enabled then
    RegisterCommand(config.modules.system.admin.menu.command, function()
        local hasPermission = lib.callback.await('lualogic_trust:server:requestPermission', false, config.modules.system.admin.menu.permission)
        if not hasPermission then return Notify('You do not have permission to use this', 'error') end
        AdminMenu()
    end, false)
end]]