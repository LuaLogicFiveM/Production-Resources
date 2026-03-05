shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
Version '1.2.1'

client_scripts { 'bridge/client.lua', 'client/*.lua', }

shared_scripts { '@ox_lib/init.lua', 'bridge/init.lua', 'bridge/shared.lua', 'config.lua' }

server_scripts { '@oxmysql/lib/MySQL.lua', 'bridge/server.lua', 'server/*.lua' } 

files { 'locales/*.json' }

lua54 'yes'
