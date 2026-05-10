shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper



fx_version 'cerulean'
games      { 'gta5' }
lua54 'yes'
version '1.0.4'

--
-- Server
--

server_scripts {
    "config.lua",
    "server/server.lua",
    "locale/locale.lua",
}
--
-- Client
--

client_scripts {
    "client/functions.lua",
    "config.lua",  
    "client/client.lua",
    "locale/locale.lua",
    "client/editable/functions.lua",
}

escrow_ignore {
    "config.lua",
    "client/editable/*.lua",
    "locale/*.lua"
}
dependency '/assetpacks'
