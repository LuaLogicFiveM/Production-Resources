shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'
version '1.2'
game 'gta5'

ui_page 'ui/index.html'

shared_scripts {'@ox_lib/init.lua', 'config/config.lua'}
client_scripts {'main/client.lua', 'config/functions/cl_function.lua'}
server_scripts {'main/server.lua', 'config/functions/sv_function.lua'}

files {'ui/**'}

escrow_ignore {'config/**'}

dependencies {'ox_lib'}

lua54 'yes'
dependency '/assetpacks'
