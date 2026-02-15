local config = require 'config'
local playerPermissions = {
    ['spawn'] = false,
    ['preview'] = false,
    ['trust_set'] = false,
    ['trust_give'] = false,
    ['trust_trade'] = false,
    ['trust_clear'] = false,
    ['trust_remove'] = false,
    ['owner_set'] = false,
    ['owner_trade'] = false,
    ['owner_transfer'] = false,
    ['owner_remove'] = false,
    ['owner_clear'] = false,
}

function zonePermission(action)
    local permGrade = action and playerPermissions[action] or false
    local playerJob = GetJob()
    return permGrade and playerJob and playerJob.grade >= permGrade or false
end

function Notify(message, type)
    return lib.notify({title = 'Trust System', description = message, type = type, position = 'top'})
end

lib.callback.register('lualogic_trust:client:loaded', function(vehicle)
    return IsModelInCdimage(vehicle) == 1
end)

--[[
local function onEnter(self)
    LocalPlayer.state.trustZone = self.id

    local zoneData = config.zones.locations[self.id]

    if zoneData and zoneData.permissions.enabled then
	    local playerJob = GetJob()
        local permData = playerJob and zoneData.permissions[playerJob.name] or false

        if permData then
            playerPermissions = permData
        end
    end
end

local function onExit(self)
    LocalPlayer.state.trustZone = nil

    local vehicle = cache.vehicle
    local zoneData = config.zones.locations[self.id]

    if zoneData and zoneData.permissions.enabled then
        if playerPermissions then
            playerPermissions = {
                ['spawn'] = false,
                ['preview'] = false,
                ['trust_set'] = false,
                ['trust_give'] = false,
                ['trust_trade'] = false,
                ['trust_clear'] = false,
                ['trust_remove'] = false,
                ['owner_set'] = false,
                ['owner_trade'] = false,
                ['owner_transfer'] = false,
                ['owner_remove'] = false,
                ['owner_clear'] = false,
            }
        end
    end

    if vehicle then
        local vehiclePlate = GetVehicleNumberPlateText(vehicle)

        if DoesEntityExist(vehicle) and not exports.wasabi_carlock:HasKey(vehiclePlate) then
            DeleteEntity(vehicle)
            Notify('You are not allowed to leave trust zones with owned or trusted vehicles unless spawned from a garage.', 'warning')
        end
    end
end

--local function inside(self)
--    --print('you are inside zone ' .. self.id)
--end

local function CreatePoint(points, thickness, debug)
    local poly = lib.zones.poly({
        points = points,
        thickness = thickness,
        debug = debug,
        --inside = inside,
        onEnter = onEnter,
        onExit = onExit
    })
end

function zonePermissionReset(jobData)
    local locationData = config.zones.locations[LocalPlayer.state.trustZone]

    if locationData.permissions[jobData.name] then
        local locationPerms = locationData.permissions[jobData.name]

        playerPermissions = locationPerms
    else
        playerPermissions = {
            ['spawn'] = false,
            ['preview'] = false,
            ['trust_set'] = false,
            ['trust_give'] = false,
            ['trust_trade'] = false,
            ['trust_clear'] = false,
            ['trust_remove'] = false,
            ['owner_set'] = false,
            ['owner_trade'] = false,
            ['owner_transfer'] = false,
            ['owner_remove'] = false,
            ['owner_clear'] = false,
        }
    end
end

CreateThread(function()
	if config.zones.enabled then
		for _, zoneData in ipairs(config.zones.locations) do
			if zoneData.radius.enabled then
                local zone = AddBlipForRadius(zoneData.blip.coords.x, zoneData.blip.coords.y, zoneData.blip.coords.z, zoneData.radius.radius)
                SetBlipColour(zone, zoneData.radius.color)
                SetBlipAlpha(zone, zoneData.radius.opacity)
            end

            if zoneData.blip.enabled then
                local blip = AddBlipForCoord(zoneData.blip.coords.x, zoneData.blip.coords.y, zoneData.blip.coords.z)
                SetBlipColour(blip, zoneData.blip.color)
                SetBlipSprite(blip, zoneData.blip.sprite)
                SetBlipScale(blip, zoneData.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(zoneData.blip.label)
                EndTextCommandSetBlipName(blip)
            end

            if zoneData.points then
                CreatePoint(zoneData.points, zoneData.thickness, zoneData.debug)
            end
		end
	end
end)
]]

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

--[[function IsInZone(type)
	local playerJob = GetJob()
    local permData = type and playerPermissions[type] or false

	return LocalPlayer.state.trustZone and permData and playerJob and permData <= playerJob.grade or false
end]]

lib.onCache('seat', function(seat)
    if seat ~= -1 then return end
    --if not LocalPlayer.state.trustZone then return end
    TriggerServerEvent('lualogic_trust:server:enteredVehicle', VehToNet(cache.vehicle))
end)