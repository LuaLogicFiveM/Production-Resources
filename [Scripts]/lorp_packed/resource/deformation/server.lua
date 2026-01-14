local function FixVehicleDeformation(vehicle)
	assert(vehicle and DoesEntityExist(vehicle), "Parameter \"vehicle\" must be a valid vehicle entity!")

	Entity(vehicle).state:set("deformation", nil, true)
end

RegisterNetEvent("lorp_packed:server:fix", function(networkId)
	FixVehicleDeformation(NetworkGetEntityFromNetworkId(networkId))
end) exports("FixVehicleDeformation", FixVehicleDeformation)