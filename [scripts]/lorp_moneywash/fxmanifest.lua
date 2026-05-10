shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

shared_scripts {
    '@ox_lib/init.lua',
}

server_scripts { 'bridge/server/**.lua', 'sv_moneywash.lua' }

client_scripts { 'bridge/client/**.lua', 'cl_moneywash.lua' }

lua54 'yes'
