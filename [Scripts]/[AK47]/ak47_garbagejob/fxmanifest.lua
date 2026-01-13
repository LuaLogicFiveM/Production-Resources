shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
version "1.3"
shared_scripts {
	"@ox_lib/init.lua",
	'config.lua',
	'locales/locale.lua',
    'locales/en.lua',
}
server_scripts {
	'config.lua',
	"framework/server/*.lua",
	'server/main.lua',
}
client_scripts {
	'config.lua',
	"framework/client/*.lua",
	"customizable/client/*.lua",
	'client/main.lua',
}
escrow_ignore {
    'locales/*',
    'config.lua',
    "framework/**/*",
	"customizable/**/*",
}
dependencies {
	'es_extended',
	'ox_lib',
}
lua54 'yes'
dependency '/assetpacks'
