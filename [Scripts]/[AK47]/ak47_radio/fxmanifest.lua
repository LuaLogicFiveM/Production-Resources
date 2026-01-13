shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
game 'gta5'
version "1.0"
lua54 'yes'
shared_scripts {
    'locales/locale.lua',
    'locales/en.lua',
    'config.lua'
}
client_scripts {
	'framework/client/*',
	'customizable/client/*',
	'client/client.lua'
} 
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'framework/server/*',
	'server/server.lua'
} 
ui_page 'web/index.html'
files {
    'web/**/*',
}
escrow_ignore {
	"INSTALL ME FIRST/**/*",
	"customizable/**/*",
	"framework/**/*",
    'locales/*.lua',
    'config.lua',
}
dependencies {
	'es_extended',
	'pma-voice',
}
dependency '/assetpacks'
