shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper


fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    --'resource/**/shared.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'resource/**/server.lua'
}

client_scripts {
    'resource/**/client.lua'
}

files {
    'resource/**/shared.lua',
    'resource/**/shared.json',
    'utils/*.lua',
    'data/*.lua',
}
