Config = {}

Config.Framework = "esx"  -- types (standalone, qbcore, esx)

Config.ESXFramework = {
	newversion = true, -- use this if you using new esx version (if you get error with old esxsharedobjectmethod in console)
	getsharedobject = "esx:getSharedObject",
	resourcename = "es_extended",
}

Config.QBCoreFrameworkResourceName = "qb-core" -- qb-core resource name, change this if you have different name of main resource of qbcore

Config.InterfaceColor = "#ffffff" -- change interface color, color must be in hex

Config.Language = "English" -- text language from code, if you want translate interface, you need do it manually in html folder.

Config.LiftControlDistance = 2.5 -- lift control distance

Config.LiftOpenKey = "E" -- lift open key

Config.InteractionSystem = 1 -- 1 == Our custom interact system, 2 == 3D Text Interact, 3 == Gta V Online Interaction Style

Config.Target = false -- enable this if you want use target

Config.Targettype = "qtarget" -- types - qtarget, qbtarget, oxtarget

Config.TargetSystemsNames = {qtarget = "qtarget", qbtarget = "qb-target", oxtarget = "ox_target"}

Config.TargetIcon = "fas fa-box-circle-check"

Config.CarLiftCreator = true -- enable this only on dev server, you can open car lift creator via /carliftcreator command (https://www.youtube.com/watch?v=0KHiz_MKl2g)

Config.CustomJobEvent = false -- enable this if you want use custom job event for detect if player have a job (for lifts which have enabled onlyjoballowed function)

Config.CustomJobEventName = "rtx_carlift:SetJob" -- you can execute this event for set player job in car lift script (its clientside event) for example TriggerEvent("rtx_carlift:SetJob", "mechanic") (after that, script will know that player have job mechanic)

-- You can detect if vehicle is on lift via our function IsVehicleOnLift example: local vehicleonlift, liftheight = exports["rtx_carlift"]:IsVehicleOnLift(vehicle) (vehicleonlift return false or true, liftheight return height on which lift currently is)

-- for add new lift you need just copy line from 29 to 42 and paste it at under line 42

Config.Lifts = {
	{--726
		coords = vector3(-662.36798095703, -871.88299560547, 23.504999160767),
		rotation = vector3(0.0, 0.0, -179.57173156738),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 3,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{--346
		coords = vector3(2457.6279296875, 1473.9620361328, 35.352001190186),
		rotation = vector3(0.0, 0.0, 89.932716369629),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},
	
	{--346
		coords = vector3(2457.6279296875, 1466.9620361328, 35.352001190186),
		rotation = vector3(0.0, 0.0, 89.932716369629),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{--346
		coords = vector3(2457.6279296875, 1459.9620361328, 35.352001190186),
		rotation = vector3(0.0, 0.0, 89.932716369629),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{--588
		coords = vector3(847.47100830078, -192.41400146484, 71.624000549316),
		rotation = vector3(-1.9699343442917, -0.69999998807907, 147.43492126465),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{--588
		coords = vector3(854.39801025391, -181.38400268555, 71.71199798584),
		rotation = vector3(0.0, 0.0, -31.795015335083),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	--[[{--141
		coords = vector3(726.13201904297, 4190.8969726562, 39.889999389648),
		rotation = vector3(0.0, 0.0, 35.476657867432),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},]]--

	{--045
		coords = vector3(-267.79901123047, 6153.2421875, 30.496999740601),
		rotation = vector3(0.0, 0.0, 135.10813903809),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{--262
		coords = vector3(1323.16796875, 2634.1379394531, 38.290000915527),
		rotation = vector3(0.0, 0.0, -16.813098907471),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{--262
		coords = vector3(1328.3179931641, 2627.2639160156, 38.311000823975),
		rotation = vector3(0.0, 0.0, -105.75840759277),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{-- 262
		coords = vector3(1324.9880371094, 2622.1159667969, 38.31600189209),
		rotation = vector3(0.0, 0.0, 33.751041412354),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 1,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{--592
		coords = vector3(686.83001708984, 125.74700164795, 79.805999755859),
		rotation = vector3(0.0, 0.0, 160.32684326172),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{--592
		coords = vector3(670.52099609375, 149.02299499512, 79.781997680664),
		rotation = vector3(0.0, 0.0, 69.659370422363),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{--592
		coords = vector3(667.75, 141.34199523926, 79.785003662109),
		rotation = vector3(0.0, 0.0, 70.019493103027),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{--592
		coords = vector3(664.85101318359, 133.76400756836, 79.802001953125),
		rotation = vector3(0.0, 0.0, 70.059394836426),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{ --228
		coords = vector3(181.69999694824, 2786.8798828125, 42.521999359131),
		rotation = vector3(0.0, 0.0, 10.190871238708),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 3,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{ --228
		coords = vector3(181.69999694824, 2780.6420898438, 42.514999389648),
		rotation = vector3(0.0, 0.0, -79.390830993652),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{ --013
		coords = vector3(-758.67297363281, 5883.16796875, 15.840999603271),
		rotation = vector3(0.0, 0.0, -119.34027099609),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{ --013
		coords = vector3(-764.45098876953, 5879.7890625, 15.833000183105),
		rotation = vector3(0.0, 0.0, 59.927398681641),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{ --804
		coords = vector3(1027.6789550781, -2550.5610351562, 27.301000595093),
		rotation = vector3(0.0, 0.0, 174.70915222168),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},

	{ --542
		coords = vector3(1445.7469482422, 1712.3929443359, 109.90599822998),
		rotation = vector3(0.0, 0.0, -64.934860229492),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},
	{ --111
		coords = vector3(2011.6860351562, 4593.4448242188, 40.379001617432),
		rotation = vector3(0.0, 0.0, 113.45068359375),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},
	{ --111
		coords = vector3(2021.6800537109, 4589.955078125, 40.372001647949),
		rotation = vector3(0.0, 0.0, 25.85214805603),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},
	{ --876
		coords = vector3(-1138.4539794922, -2073.9150390625, 12.196000099182),
		rotation = vector3(0.0, 0.0, -45.037052154541),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 3,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
			["royals"] = true,
		},
	},
	{ --876
		coords = vector3(-1131.8830566406, -2067.5310058594, 12.196999549866),
		rotation = vector3(0.0, 0.0, -44.921089172363),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 3,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
			["royals"] = true,
		},
	},
	{ --574
		coords = vector3(1151.2330322266, -783.6240234375, 56.589000701904),
		rotation = vector3(0.0, 0.0, -179.25543212891),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
			["elevatedcustoms"] = true,
		},
	},
	{ --752
		coords = vector3(140.39700317383, -1103.8310546875, 28.160999298096),
		rotation = vector3(0.0, 0.0, -178.7473449707),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},
	{ --752
		coords = vector3(121.78399658203, -1101.541015625, 28.176000595093),
		rotation = vector3(0.0, 0.0, -91.793510437012),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 1,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},
	{ --099
		coords = vector3(2730.2829589844, 4921.5288085938, 32.686000823975),
		rotation = vector3(0.0, 0.0, -45.542293548584),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 1,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},
	{ --yellobelly
		coords = vector3(-2997.5029296875, 4297.3579101563, 23.868999481201),
		rotation = vector3(0.0, 0.0, -114.83355712891),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 1,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
			["yellobelly"] = true,
		},
	},
	{ --yellobelly
		coords = vector3(-2992.24609375, 4307.046875, 23.863000869751),
		rotation = vector3(0.0, 0.0, 66.958702087402),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
			["yellobelly"] = true,
		},
	},
	{ --yellobelly
		coords = vector3(-2990.6201171875, 4314.5791015625, 23.868999481201),
		rotation = vector3(0.0, 0.0, -112.95443725586),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 1,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
			["yellobelly"] = true,
		},
	},
	{ --685
		coords = vector3(-2057.5090332031, -475.4880065918, 11.093000411987),
		rotation = vector3(0.0, 0.0, 140.31483459473),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
			["highstreet"] = true,
		},
	},
	{ --685
		coords = vector3(-2048.9750976563, -482.21600341797, 11.092000007629),
		rotation = vector3(0.0, 0.0, 139.59016418457),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 1,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
			["highstreet"] = true,
		},
	},
	{ --538
		coords = vector3(1403.5980224609, 1053.0529785156, 113.3929977417),
		rotation = vector3(0.0, 0.0, 88.75959777832),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
			["allout"] = true,
		},
	},
	{ --538
		coords = vector3(1402.8520507813, 1059.1459960938, 113.40100097656),
		rotation = vector3(0.0, 0.0, 89.802871704102),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
			["allout"] = true,
		},
	},
	{ --260
		coords = vector3(1174.7049560547, 2639.3059082031, 36.751998901367),
		rotation = vector3(0.0, 0.0, 179.85299682617),
		currentheight = 0.0,
		objecthandler = {frame = nil, lift = nil},
		manipulating = false,
		manipulatingplayerid = nil,
		lifttype = 2,
		buttonuppress = false,
		buttondownpress = false,
		onlyjoballowed = false,
		jobs = {
		},
	},
}

function Notify(text)
	print(text)
	--exports["rtx_notify"]:Notify("Lift", text, 5000, "info") -- if you get error in this line its because you dont use our notify system buy it here https://rtx.tebex.io/package/5402098 or you can use some other notify system just replace this notify line with your notify system
	--exports["mythic_notify"]:SendAlert("inform", text, 5000)
end

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