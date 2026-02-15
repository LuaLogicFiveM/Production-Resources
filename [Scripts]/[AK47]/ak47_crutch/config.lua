Config = {}
Config.Locale = 'en'
Config.SharedObjectName = 'esx:getSharedObject'			--Change if your Shared Object Name is different

Config.CrutchCommand = nil --set nil to remove the command

Config.DisableJump = true
Config.DisableRunning = false
Config.DisableShooting = true
Config.DisableFighting = true
Config.ForceFixMovementStyle = true

Config.NeverDetach = false

Config.Whitelistedjobs = {
	ems = true,
	sahp = true,
	sheriff = true,
	safd = true
}

Config.MinimumTime = 5 --in minute
Config.MaximumTime = 25 --in minute

--[[ Commands

/crutch 			-- self toggle crutch
/setcrutch 			-- set crutch to a player (Whitelistedjob)
/removecrutch  		-- remove crutch from player (Whitelistedjob)

]]


