shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version "2.9"

shared_scripts {
    '@ox_lib/init.lua', -- Uncomment if using ox_lib
    'config/*',
}

client_scripts {
    'modules/utils/client.lua',
    'bridge/client/*.lua',
    'modules/**/client.lua',
}

server_scripts {
    'modules/utils/server.lua',
    'bridge/server/*.lua',
    'modules/**/server.lua',
}

escrow_ignore {
    'bridge/**/*',
    'config/*.lua',
}

dependency '/assetpacks'
