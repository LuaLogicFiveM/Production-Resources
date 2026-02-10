shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
version '2.0.1'
game 'gta5'

ui_page 'ui/index.html'

shared_scripts {'@ox_lib/init.lua', 'config/config.lua', 'config/language.lua'}
client_scripts {'config/functions/cl_function.lua', 'main/client.lua'}
server_scripts {'@oxmysql/lib/MySQL.lua', 'config/functions/sv_function.lua', 'main/server.lua'}

files {'ui/**'}

escrow_ignore {'config/**'}

dependencies {'oxmysql', 'ox_lib'}

lua54 'yes'
dependency '/assetpacks'
