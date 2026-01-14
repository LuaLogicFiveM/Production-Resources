shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'KuzQuality | Kuzkay'
description 'Realistic offroad physics by KuzQuality'
version '1.9.0'


--
-- Server
--

server_scripts {
    'mixed/constants.lua',
    'config.lua',
    'server/server.lua',
}

--
-- Client
--

client_scripts {
    'mixed/constants.lua',
    'config.lua',
    'client/cache.lua',
    'client/editable/editable.lua',
    'client/functions.lua',
    'client/client.lua',
    'client/handling.lua',
}

escrow_ignore {
    'config.lua',
    'client/editable/*.lua',
}
dependency '/assetpacks'
