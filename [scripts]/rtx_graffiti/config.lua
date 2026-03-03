Config = {}

Config.Framework = "esx"  -- types (standalone, qbcore, esx)

Config.ESXFramework = {
	newversion = true, -- use this if you using new esx version (if you get error with old esxsharedobjectmethod in console)
	getsharedobject = "esx:getSharedObject",
	resourcename = "es_extended"
}

Config.QBCoreFrameworkResourceName = "qb-core" -- qb-core resource name, change this if you have different name of main resource of qbcore

Config.QBCoreNewInventoryVersion = false -- enable this if you have errors about items in console

Config.InterfaceColor = "#fffff" -- change interface color, color must be in hex

Config.Language = "English" -- text language from code (English)

Config.GraffitiCommandEnable = false -- enable this if you want to enable graffiti place via command

Config.GraffitiCommand = "graffiti" -- command for open the grafifit menu

Config.GraffitiItemEnable = false -- enable this if you want to enable graffiti place via item

Config.GraffitiItemSpray = "graffiti_spray" -- item name

Config.GraffitiItemRemove = "graffiti_remover" -- item name

Config.GraffitiSprayItem = false -- enable this if you want remove the item after spray the graffiti

Config.GraffitiEventEnable = true -- enable this if you want to enable graffiti place via event

Config.GraffitiEvent = "rtx_graffiti:OpenGraffiti" -- trigger event for open the grafifit menu

Config.GraffitiPrepareTime = 2 -- in seconds

Config.GraffitiRemoveTime = 15 -- in seconds

Config.GraffitiRemove = true -- enable this if you want to be able to remove a graffiti

Config.GraffitiRemoveCommand = "removegraffiti"

Config.GraffitiShowAdminCommand = "showgraffiti" -- configure permissions in server/other.lua file

Config.GraffitiRemoveItemNeeded = false  -- enable this if item is needed for a remove graffiti

Config.GraffitiRemoveCommandAdmin = "removegraffitiadmin" -- remove admin command - configure permissions in server/other.lua file

Config.GraffitiRemoveItem = false -- enable this if you want remove the item after cleaning the graffiti

Config.SprayColor = {r = 255, g = 255, b = 255, a = 10}

Config.SprayTime = {mintime = 10000, maxtime = 30000}

Config.GraffitiOffsets = {minsize = 0.01, maxsize = 0.2, step = 0.005, defaultx = 0.069, defaulty = 0.043}

Config.GraffitiDistance = {maxheight = 2.0, maxdistance = 5.0}

Config.GraffitiTeleportDistance = 1.0 -- distance

Config.GraffitiTeleportRemoveDistance = 0.65 -- distance

Config.GraffitiPlaceKey = "return" -- key for place graffiti

Config.GraffitiCancelKey = "f" -- key for cancel graffiti

Config.GraffitiCycleKey = "g" -- key for cycle

Config.MaxGraffitiOnScreen = 20 -- max graffiti on screen

Config.MaxGraffitiDistance = 100.0 -- max graffiti distance view

Config.TempGraffiti = true -- enable this if you want only graffiti until server restart

Config.GraffitiOnlyForPeopleWithPermission = false -- enable this if you want to allow graffiti spray only to specifed players

Config.GraffitiWebhook = true -- enable this if you want use webhooks (you need configure your webhook in server/other.lua file!)

Config.AllowPlayersInsertImagesViaLink = false -- enable this feature if you want players to be able to upload their images via a link not just from the list in Config.GraffitiImages

Config.GraffitiTypesEnabled = { -- If you want to disable a graffiti type, just put false on that type. 
	[1] = true, -- Draw Type
	[2] = true, -- Text Type
	[3] = true, -- Image Type
}

Config.GratfitiPermissionsSettings = {
	acepermissionsforspraygraffiti = {enable = false, permission = "graffiti.use"}, -- enable this if you want to use ace permissions
	jobpermissionsforspraygraffiti = {enable = false, jobname = "gang"},  -- enable this if you want to use job permissions (you need create job with name sphere or change the job title to something else)
	identifierspermissionsforgraffitiuse = false, -- enable this if you want to use identifiers permissions
	permissionsviaidentifiers = { -- permisisontypes - license, steam, xbox, live, discord, ip
		{permissiontype = "steam", permisisondata = "steam:11000013cc73739"}, -- this is example line
	},
}

Config.GraffitiImages = {
    {name = "graffiti1", label = "Graffiti 1", path = "nui://rtx_graffiti/html/graffiti/graffiti_11.png"},
    {name = "graffiti1", label = "Graffiti 1", path = "nui://rtx_graffiti/html/graffiti/graffiti_12.png"},
    {name = "grovestreetgraffiti1", label = "Grove Street Graffiti 1", path = "nui://rtx_graffiti/html/graffiti/grove_street_graffiti_1.png"},
    {name = "grovestreetgraffiti2", label = "Grove Street Graffiti 2", path = "nui://rtx_graffiti/html/graffiti/grove_street_graffiti_2.png"},
    {name = "grovestreetgraffiti3", label = "Grove Street Graffiti 3", path = "nui://rtx_graffiti/html/graffiti/grove_street_graffiti_3.png"},
    {name = "vagosgraffiti1", label = "Vagos Graffiti 1", path = "nui://rtx_graffiti/html/graffiti/vagos_graffiti_1.png"},
    {name = "vagosgraffiti2", label = "Vagos Graffiti 2", path = "nui://rtx_graffiti/html/graffiti/vagos_graffiti_2.png"},
    {name = "ballasgraffiti1", label = "Ballas Graffiti 1", path = "nui://rtx_graffiti/html/graffiti/ballas_graffiti_1.png"},
    {name = "ballasgraffiti2", label = "Ballas Graffiti 2", path = "nui://rtx_graffiti/html/graffiti/ballas_graffiti_2.png"},
    {name = "ballasgraffiti3", label = "Ballas Graffiti 3", path = "nui://rtx_graffiti/html/graffiti/ballas_graffiti_3.png"},
    {name = "graffiti1", label = "Graffiti 1", path = "nui://rtx_graffiti/html/graffiti/graffiti_1.png"},
    {name = "graffiti2", label = "Graffiti 2", path = "nui://rtx_graffiti/html/graffiti/graffiti_2.png"},
    {name = "graffiti3", label = "Graffiti 3", path = "nui://rtx_graffiti/html/graffiti/graffiti_3.png"},
    {name = "graffiti4", label = "Graffiti 4", path = "nui://rtx_graffiti/html/graffiti/graffiti_4.png"},
    {name = "graffiti5", label = "Graffiti 5", path = "nui://rtx_graffiti/html/graffiti/graffiti_5.png"},
    {name = "graffiti6", label = "Graffiti 6", path = "nui://rtx_graffiti/html/graffiti/graffiti_6.png"},
    {name = "graffiti7", label = "Graffiti 7", path = "nui://rtx_graffiti/html/graffiti/graffiti_7.png"},
    {name = "graffiti8", label = "Graffiti 8", path = "nui://rtx_graffiti/html/graffiti/graffiti_8.png"},
    {name = "graffiti9", label = "Graffiti 9", path = "nui://rtx_graffiti/html/graffiti/graffiti_9.png"},
    -- Add more images as needed
}

function Notify(text)
    exports.ox_lib:notify({title = 'Graffiti', description = text, type = 'info', position = 'top'})
	--exports["rtx_notify"]:Notify("Graffiti", text, 5000, "info") -- if you get error in this line its because you dont use our notify system buy it here https://rtx.tebex.io/package/5402098 or you can use some other notify system just replace this notify line with your notify system
	--exports["mythic_notify"]:SendAlert("inform", text, 5000)
end