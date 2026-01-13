Config = {}
Config.Locale = 'en'

Config.SocietyInManagement = false --enable if your society is inside qb-management
Config.TargetScript = 'qtarget'
Config.DebugPoly = false

Config.Marker = {
	plant = {
		showmarker = true,
		fontSize = 0.4,
		id = 22,
		size = vector3(0.3, 0.3, 0.2),
		color = {r = 255, g = 155, b = 0, a = 200},
	},
}

Config.Volume = 0.1

Config.Controls = {
	smoke = 23,
	exit = 47,
}

Config.Hookah = {
	{
		pos = vector3(-520.7226, 29.60126,44.38903),
		size = 1.0,
		price = 500,
		maxPuffInSession = 10,
		maxPuff = 100,
		availablePuff = 100,
		refill = {
			cost = 1200,
			items = {
				weed_leaf = 25,
			},
		}
	},
	{
		pos = vector3(-522.6793, 29.77244, 44.38568),
		size = 1.0,
		price = 500,
		maxPuffInSession = 10,
		maxPuff = 100,
		availablePuff = 100,
		refill = {
			cost = 1200,
			items = {
				weed_leaf = 25,
			},
		}
	},
}

