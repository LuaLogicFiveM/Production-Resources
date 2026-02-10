shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'bodacious'
game 'gta5'
lua54 'yes'
version '2.0.0'

files {
    'convert/whitelist.json',
    'config.lua',
}

client_scripts {
    'editable/bridge/**/client.lua',
    'editable/client/*.lua',
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'editable/bridge/**/server.lua',
    'editable/server/*.lua',
    'server/*.lua',
    'logs.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'editable/shared/*.lua',
    'config.lua',
}

escrow_ignore {
    'editable/**/*.lua',
    'server/*.lua',
    'config.lua',
    'logs.lua'
}

dependency '/assetpacks'