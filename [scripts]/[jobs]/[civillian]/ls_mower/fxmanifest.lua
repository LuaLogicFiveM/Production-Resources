shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
version '1.2.15'

--
-- Server
--

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "config.lua",
    "server/editable/functions.lua",
    "server/editable/qb.lua",
    "server/editable/esx.lua",
    "server/editable/standalone.lua",
    "server/server.lua",
    "locale/locale.lua"
}

--
-- Client
--

client_scripts {
    "client/functions.lua",
    "client/cache.lua",
    "config.lua",
    "client/client.lua",
    "client/editable/qb.lua",
    "locale/locale.lua",
    "client/editable/esx.lua",
    "client/editable/functions.lua",
    "client/editable/standalone.lua"
}

files {
    "stream/*",
}

escrow_ignore {
    "config.lua",
    "client/editable/*.lua",
    "server/editable/*.lua",
    "locale/*.lua"
}

dependency '/assetpacks'
