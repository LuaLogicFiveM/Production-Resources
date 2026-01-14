return {
	Debug = false,

	Framework = "standalone", -- esx, qbcore or standalone
	Language = "en", -- add your own language in locales/
	InteractStyle = "native", -- auto: use target if available, otherwise native. native: press E, target: qtarget, qb-target or ox_target
	NotificationSystem = "ox_lib", -- framework or ox_lib, modify in client/functions.lua
	SpawnMethod = "networked", -- local (non-networked), networked or server
	BurstNPC = false, -- burst tires of NPCs? note that this can be resource intensive
	LogSystem = true, -- "discord" or "ox_lib". Set your discord webhook in server/logs.lua. Set to false to disable
	Blips = true, -- show blips of all spike strips on the map for allowed jobs?
	AllowFromVehicle = false, -- allow throwing spike strips from vehicles?

	BlipsCommand = "spikestripsblips", -- command to toggle blips (set to false to disable)
	Command = "spikestrips", -- command to place spike strip, set to false to disable
	ClearCommand = "spikestripsclear", -- admin command to clear all spike strips, set to false to disable

	OnlyRoads = false, -- only allow placing spike strips on roads?
	AutoDelete = 10, -- how many minutes after placing to delete spike strip? set to false to disable
	MaxStingers = 10, -- max amount of stingers that can be placed, set to false to disable
	RemoveDisconnect = true, -- remove spike strips when player disconnects?
	RemoveDistance = 100.0, -- if the person who placed it goes this far away, remove it. set to false to disable

	Item = {
		Require = true, -- require item to place a spike strip?
		Usable = false, -- allow using item to place a spike strip?
		Remove = true, -- remove item after placing a spike strip? it will be given back when taking up
		Name = "spikestrip"
	},

	Job = {
		RequirePlace = true, -- require job to place a spike strip?
		RequireRemove = true, -- require job to remove placed spike strips?
		Allowed = { ["sheriff"] = true, ["sahp"] = true }
	},

	PickupKey = {
		key = "E",
		mapper = "KEYBOARD",

		secondaryKey = "LRIGHT_INDEX",
		secondaryMapper = "PAD_DIGITALBUTTON"
	},

	Bones = {
		{ bone = "wheel_lf", index = 0 },
		{ bone = "wheel_rf", index = 1 },
		{ bone = "wheel_lm1", index = 2 },
		{ bone = "wheel_rm1", index = 3 },
		{ bone = "wheel_lr", index = 4 },
		{ bone = "wheel_rr", index = 5 },
		{ bone = "wheel_lm2", index = 45 },
		{ bone = "wheel_lm3", index = 46 },
		{ bone = "wheel_rm2", index = 47 },
		{ bone = "wheel_rm3", index = 48 },
	}
}