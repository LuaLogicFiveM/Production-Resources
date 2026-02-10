shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
author "MenanAk47 (MenanAk47#3129)"
version "1.4"
shared_script '@es_extended/imports.lua'
client_scripts {
	'config.lua',
	'client/utils.lua',
	'client/main.lua',
	'locales/locale.lua',
    'locales/en.lua',
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/utils.lua',
	'server/main.lua',
	'locales/locale.lua',
    'locales/en.lua',
}
escrow_ignore {
    'locales/*.lua',
    'config*.lua',
    'server/utils.lua',
    'client/utils.lua',
}
lua54 'yes'
dependencies {
    'es_extended',
}
dependency '/assetpacks'
