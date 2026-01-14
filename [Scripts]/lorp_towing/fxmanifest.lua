shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
version '2.2.1'


--
-- Server
--

server_scripts {
    'locale.lua',
    'mixed/constants.lua',
    'config.lua',
    'server/server.lua',
    'server/editable/esx.lua',
    'server/editable/qb.lua',
    'server/editable/editable.lua',
}

--
-- Client
--

client_scripts {
    'config.lua',
    'locale.lua',
    'mixed/constants.lua',
    'client/editable/editable.lua',
    'client/cache.lua',
    'client/inputs.lua',
    'client/removing.lua',
    'client/functions.lua',
    'client/raycast.lua',
    'client/client.lua',
    'client/ropes.lua',
    'client/winch.lua',
    'client/towing.lua',
}

escrow_ignore {
    'config.lua',
    'locale.lua',
    'client/editable/*.lua',
    'server/editable/*.lua',
}

dependency '/assetpacks'
