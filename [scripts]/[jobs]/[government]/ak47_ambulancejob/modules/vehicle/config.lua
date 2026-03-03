Config.Vehicles = {
	--PillBox
	--[[{
		zone 		= vector3(297.35, -606.62, 43.26),  		--zone position
		rotation 	= 68.43,									--zone rotation
		size 		= vector3(10.0, 6.0, 2.0),					--zone size
		spawn 		= vector4(295.05, -607.27, 43.01, 68.43), 	--vehicle spawn point with heading
		vehicles = {
			{model = 'ambulance', label = 'Ambulance', rank = 0, props = {modLivery = 0}}, --props is optional
			{model = 'fordambo',  label = 'Ford E450', rank = 0, props = {modLivery = 0}},
		}
	},
	{
		zone 		= vector3(326.18, -588.72, 28.8),
		rotation 	= 340.0,
		size 		= vector3(10.0, 6.0, 2.0),
		spawn 		= vector4(327.15, -585.89, 28.57, 340.0),
		vehicles = {
			{model = 'ambulance', label = 'Ambulance', rank = 0, props = {modLivery = 0}}, --props is optional
			{model = 'fordambo',  label = 'Ford E450', rank = 0, props = {modLivery = 0}},
		}
	},
	{
		zone 		= vector3(352.04, -588.14, 74.16),
		rotation 	= 0.0,
		size 		= vector3(10.0, 10.0, 5.0),
		spawn 		= vector4(351.82, -588.08, 74.16, 70.0),
		vehicles = {
			{model = 'polmav', label = 'EMS Helicopter', rank = 0, props = {modLivery = 1}},
		}
	},]]
}