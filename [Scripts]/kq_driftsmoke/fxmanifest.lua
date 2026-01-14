shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games      { 'gta5' }
lua54 'yes'
version '1.2.0'


--
-- Server
--

server_scripts {
    'config.lua',
    'server/server.lua',
}

--
-- Client
--

client_scripts {
    'config.lua',
    'client/client.lua',
    'client/editable.lua',
}

escrow_ignore {
    'config.lua',
    'client/editable.lua',
}

dependency '/assetpacks'
