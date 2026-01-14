shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
version '1.1.0'

client_scripts {
	'config.lua',
	'client/client.lua',
}

escrow_ignore {
	'config.lua',
}

dependency '/assetpacks'
