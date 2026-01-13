Config = {}

Config.Framework = "esx"  -- types (standalone, qbcore, esx)

Config.ESXFramework = {
	newversion = true, -- use this if you using new esx version (if you get error with old esxsharedobjectmethod in console)
	getsharedobject = "esx:getSharedObject",
	resourcename = "es_extended"
}

Config.QBCoreFrameworkResourceName = "qb-core" -- qb-core resource name, change this if you have different name of main resource of qbcore

Config.OxInventory = true -- enable this if you use ox_inventory

Config.InterfaceColor = "#ffffff" -- change interface color, color must be in hex

Config.Language = "English" -- text language from code (English)

Config.ThemeParkTicketMachineSettings = {usedistance = 2.0, usekey = "E"}

Config.MaximumAttractionDistance = 200.0 -- distance of view of attractions

Config.Target = false -- enable this if you want use target

Config.Targettype = "qtarget" -- types - qtarget, qbtarget, oxtarget

Config.TargetSystemsNames = {qtarget = "qtarget", qbtarget = "qb-target", oxtarget = "ox_target"}

Config.TargetIcons = {ticketicon = "fa-solid fa-cart-shopping", dooricon = "fa-solid fa-door-open", seaticon = "fa-solid fa-chair"} 

Config.ThemeParkInteractionSystem = 1 -- 1 == Our custom interact system, 2 == 3D Text Interact, 3 == Gta V Online Interaction Style

Config.ThemeParkSeatKey = "E" -- theme park key for sit

Config.ThemeParkExitKey = "F" -- theme park key for exit

Config.ThemeParkAnimChangeKey = "E" -- theme park key for change anim

Config.ThemeParkDisableExit = true -- turn this feature on if you don't want players to leave the attraction during the ride.

Config.ThemeParkAttractionFallChance = false -- enable this feature if you want the chance that the player will fall from the attraction, you can set the chance in Config.ThemeParkFallSettings

Config.ThemeParkDisabledByDefault = false -- enable this feature if you want to disable all attractions when the server starts, to enable attractions you have to enable them via the /enablethemepark command which is for administrators. (permissions for this command is in other.lua file)

Config.ThemeParkDisableTicketSystem = false -- enable this feature if you want free entry to all attractions

Config.AttractionCreator = true -- Enable this function if you want to position attractions in the game

Config.AttractionCreatorCommand = "createattraction" -- command for creator

Config.Attractions = { -- If you want the attractions to be paid, put the ticket on true
	{--mlo141
		attractiontype = "shootingrange",
		coords = vector3(751.44500732422, 4181.875, 39.641998291016),
		rotation = vector3(0.0, 0.0, -49.550769805908),
		ticket = false,
	},
	{
		attractiontype = "gforce",
		coords = vector3(-1724.1059570312, -787.13299560547, 8.3229999542236),
		rotation = vector3(0.0, 0.0, -41.814491271973),
		ticket = false,
	},
	{
		attractiontype = "vortex",
		coords = vector3(-1735.2939453125, -842.95001220703, 19.107999801636),
		rotation = vector3(1.4194779396057, -0.20000000298023, -35.998947143555),
		ticket = false,
	},
	{
		attractiontype = "topscan",
		coords = vector3(-1791.2490234375, -800.48498535156, 9.0740003585815),
		rotation = vector3(1.3741586208344, -0.60000002384186, -38.076351165771),
		ticket = false,
	},
	{
		attractiontype = "detonator",
		coords = vector3(-1757.1130371094, -760.28900146484, 10.824999809265),
		rotation = vector3(0.35196846723557, 1.3115609884262, -134.43782043457),
		ticket = false,
	},
	{
		attractiontype = "boat",
		coords = vector3(-1734.0720214844, -811.28002929688, 16.159999847412),
		rotation = vector3(1.5434044599533, 0.10000000149012, -29.896362304688),
		ticket = false,
	},
	{
		attractiontype = "bumpercars",
		coords = vector3(-1803.0810546875, -749.45098876953, 8.4090003967285),
		rotation = vector3(1.3479399681091, -0.0, -42.153911590576),
		ticket = false,
	},
	{
		attractiontype = "ferris",
		coords = vector3(-1778.3249511719, -841.84698486328, 21.813999176025),
		rotation = vector3(0.0, 0.0, -79.653144836426),
		ticket = false,
	},
	{
		attractiontype = "shootingrange",
		coords = vector3(-1748.8819580078, -780.33801269531, 8.4569997787476),
		rotation = vector3(1.9887649357728e-16, -1.74123442173, 41.944484710693),
		ticket = false,
	},
}

Config.AttractionsSettings = {
	gforce = {
		disable = false, -- enable this if you dont want to use this attraction
		usedistance = 1.5,  -- distance for use attraction
		waitforplayers = 5000, -- in miliseconds
		exitcoords = {coords = vector3(0.0, 0.0, 1.5), heading = 0.0}, -- coordinates for exit the attraction
		animcooldown = 1000, -- in miliseconds
		ticketprice = math.random(100, 150), -- price for ticket
		speedmodifier = 1.0, -- attraction speed, default speed is 1.0
		maxrounds = 10, -- change this you want more rounds at maximum speed (changing this number to a higher number will change the duration of the attraction)
	},
	topscan = {
		disable = false, -- enable this if you dont want to use this attraction
		usedistance = 1.5, -- distance for use attraction
		waitforplayers = 5000, -- in miliseconds	
		exitcoords = {coords = vector3(0.0, 0.0, 1.5), heading = 0.0}, -- coordinates for exit the attraction
		animcooldown = 1000, -- in miliseconds		
		ticketprice = math.random(100, 150), -- price for ticket
		speedmodifier = 1.0, -- attraction speed, default speed is 1.0
		maxrounds = 20, -- change this you want more rounds at maximum speed (changing this number to a higher number will change the duration of the attraction)
		normalstyle = true, -- change this if you want different style of top scan (Top Scan starts spinning at a different angle)
	},	
	vortex = {
		disable = false, -- enable this if you dont want to use this attraction
		usedistance = 1.5, -- distance for use attraction
		waitforplayers = 5000, -- in miliseconds	
		exitcoords = {coords = vector3(0.0, 0.0, 1.5), heading = 0.0}, -- coordinates for exit the attraction
		animcooldown = 1000,			
		ticketprice = math.random(100, 150), -- price for ticket
		speedmodifier = 1.0, -- attraction speed, default speed is 1.0
		maxrounds = 2, -- change this you want more rounds at maximum speed (changing this number to a higher number will change the duration of the attraction)
	},	
	detonator = {
		disable = false, -- enable this if you dont want to use this attraction
		usedistance = 1.5, -- distance for use attraction
		waitforplayers = 5000, -- in miliseconds
		exitcoords = {coords = vector3(0.0, 0.0, 1.5), heading = 0.0}, -- coordinates for exit the attraction
		ticketprice = math.random(100, 150), -- price for ticket
		speedmodifier = 1.0, -- attraction speed, default speed is 1.0
		timeontop = 10000, -- in miliseconds (the time that the detonator will wait at the top before going down.)
	},	
	boat = {
		disable = true, -- enable this if you dont want to use this attraction
		usedistance = 1.5, -- distance for use attraction
		waitforplayers = 5000, -- in miliseconds
		exitcoords = {coords = vector3(0.0, 0.0, 1.5), heading = 0.0}, -- coordinates for exit the attraction
		animcooldown = 1000, -- in miliseconds		
		ticketprice = math.random(100, 150), -- price for ticket
		speedmodifier = 1.0, -- attraction speed, default speed is 1.0
		maxrounds = 5, -- change this you want more rounds at maximum speed (changing this number to a higher number will change the duration of the attraction)
	},	
	bumpercars = {
		disable = false, -- enable this if you dont want to use this attraction
		bumperdespawncoords = {coords = vector3(15.570196, -1.957926, 1.336596), heading = 0.0}, -- coordinates for exit the attraction
		buydistance = 1.5,  -- distance for buy ticket
		seatdistance = 2.0, -- distance for seat as a passenger.
		minminutes = 1, -- minimum minutes in bumper cars
		maxminutes = 10, -- max minutes in bumper cars
		priceperminute = math.random(100, 150), -- price for ticket per minute
		maxplayers = 15, -- maximum number of players for bumper cars
		bumperusekey = "E", -- bumper cars key for seat as a passenger.
		bumperleavekey = "E",-- bumper cars key for leave bumper cars
		disablebumperkeyboard = true, -- turning off the keyboard when driving bumper cars
	},	
	ferris = {
		disable = false, -- enable this if you dont want to use this attraction
		usedistance = 2.5, -- distance for use attraction
		waitforplayers = 5000, -- in miliseconds
		ferrisseatanimcooldown = 1000, -- in miliseconds
		ferrisseatwait = 5000, -- in miliseconds
		ferrisexitcoords = {coords = vector3(2.666939, -3.916842, -13.432882), heading = 0.0}, -- coordinates for exit the attraction
		ticketprice = math.random(100, 150), -- price for ticket
	},	
	shootingrange = { -- If you have some script which block weapons, you can add some bypass to allow weapon_musket to be used withount inventory item use, we also trigger this event when shooting range is started TriggerEvent("rtx_spawnableattractions:Shooter:Started", true) and when shooting range ends TriggerEvent("rtx_spawnableattractions:Shooter:Started", false), you can create event handler for our event in your script
		disable = false, -- enable this if you dont want to use this attraction
		usedistance = 2.0, -- distance for use attraction
		maxtargets = 5, -- maximum number of targets
		defaultspeed = 0.010, -- base speed of targets
		maxspeed = 0.035, -- max speed of targets
		maxpeektargets = 50, -- maximum number of target hits
		maxmistakes = 5, -- maximum number of mistakes before cancellation
		timetoshoot = 5, -- maximum number of seconds to hit the target
		shootingrangeweapon = "weapon_musket", -- weapon name which you want to use in shootin range
		ticketprice = math.random(100, 150), -- price for ticket
		shootingrangeusekey = "E", -- shooting range key for start game.
	},	
}

Config.BumperCarsSpawnPoints = {
	{coords = vector3(11.221574, -28.697319, 0.08), heading = 0.0, radius = 2.0},
	{coords = vector3(8.524499, -28.902832, 0.08), heading = 0.0, radius = 2.0},
	{coords = vector3(5.549406, -29.049639, 0.08), heading = 0.0, radius = 2.0},
	{coords = vector3(3.125188, -28.936161, 0.08), heading = 0.0, radius = 2.0},
	{coords = vector3(0.916006, -29.271908, 0.08), heading = 0.0, radius = 2.0},
	{coords = vector3(-1.543060, -29.266916, 0.08), heading = 0.0, radius = 2.0},
	{coords = vector3(-2.967319, -29.236168, 0.08), heading = 0.0, radius = 2.0},	
	{coords = vector3(-5.325474, -29.006685, 0.08), heading = 0.0, radius = 2.0},	
	{coords = vector3(-8.280594, -29.246466, 0.08), heading = 0.0, radius = 2.0},	
	{coords = vector3(-10.829285, -29.422598, 0.08), heading = 0.0, radius = 2.0},
}

Config.ThemeParkFallSettings = {
	fallchance = 10, -- in percentage 1-1000
	fallchancecheck = 5, -- in seconds (for example it will trigger fall chance every 10 seconds when player is on the attraction)
	attractions = {
		gforce = true, -- enable this if you want to have chance to fall from this attraction
		topscan = true, -- enable this if you want to have chance to fall from this attraction
		vortex = true, -- enable this if you want to have chance to fall from this attraction
		detonator = true, -- enable this if you want to have chance to fall from this attraction
		boat = true, -- enable this if you want to have chance to fall from this attraction
		rollercoaster = true, -- enable this if you want to have chance to fall from this attraction
	},
}

Config.ShootingRangePrizes = {
	{ -- score number
		minimumscore = 10, -- minimum score
		prizetype = "money",  -- prize type (you need add your types yourself in server/other.lua
		prizedata = 100, -- prize data example money amount
		prizelabel = "Money", -- prize label
	},
	{ -- score number
		minimumscore = 100, -- minimum score
		prizetype = "money",  -- prize type (you need add your types yourself in server/other.lua
		prizedata = 1000, -- prize data example money amount
		prizelabel = "Money", -- prize label
	},	
}

Config.PlayerLoadedEvent = { -- load methods of theme park
	esx = "esx:playerLoaded", 
	qbcore = "QBCore:Client:OnPlayerLoaded",
	standalone = "playerLoaded",
	customevent = true, -- enable this if you dont want load theme park after player loaded to server. (enable this for example for servers with multicharacter)
	standaloneevent = false, -- enable this if you dont want load theme park after player loaded to server. (for standalone version)
}

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 240
		DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 255, 102, 255, 150)
	end
end

function Notify(text)
	lib.notify({title = 'Theme Park', description = text, type = 'info', position = 'top'})
	--exports["rtx_notify"]:Notify("Theme Park", text, 5000, "info") -- if you get error in this line its because you dont use our notify system buy it here https://rtx.tebex.io/package/5402098 or you can use some other notify system just replace this notify line with your notify system
	--exports["mythic_notify"]:SendAlert("inform", text, 5000)
end

function AddBumperKey(vehicle)
	-- if you use some vehicle key system, add here your function for add keys (name of vehicle is rtxbumper)
end