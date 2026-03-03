shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'
version '1.0.4'

shared_scripts {
    '@ox_lib/init.lua',
    'configuration/*.lua',
    'bridge/framework.lua'
}

client_scripts {
    'bridge/**/client.lua',
    'client/*.lua'
}

server_scripts {
    'bridge/**/server.lua',
    'server/*.lua'
}
