shared_script "@ReaperV4/imports/bypass.js"
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
games { 'gta5' }

author 'Prompt Mods'
description 'Apts+Gas+Cityhall+Marina'
version '1.0.0'

this_is_a_map 'yes'

escrow_ignore {
    'stream/**'
}

-- scripts --
lua54 'yes'


client_scripts {
    'client.js'
}

server_scripts{
    'sv_MapDataHandler.lua',
    'server.js'
}
