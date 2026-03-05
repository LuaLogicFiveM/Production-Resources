shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
lua54 'yes'
game 'gta5'
shared_scripts {
	'@ox_lib/init.lua',
    'config.lua',
}
client_script 'client/main.lua'
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/bridge/*',
	'server/main.lua'
}
file 'locales/*.json'
