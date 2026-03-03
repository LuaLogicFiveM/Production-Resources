shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games      { 'gta5' }
lua54 'yes'

author 'Swizz | Lith Studios'
description 'Advanced Wheel Spacers script by Lith Studios'
version '1.2.13'

--
-- Server
--

server_scripts {
    'config.lua',
    '@oxmysql/lib/MySQL.lua',
    'locale/locale.lua',
    'server/editables/esx.lua',
    'server/editables/qb.lua',
    'server/server.lua',
    'server/editables/database.lua'
}

--
-- Client
--

client_scripts {
    'config.lua',
    'locale/locale.lua',
    'client/spacers.lua',
    'client/jackstand.lua',
    'client/editables/editables.lua',
    'client/cache.lua',
    'client/functions.lua',
    'client/client.lua',
    'client/mounting.lua',
    'client/unmounting.lua',
    'client/shop.lua',
    'client/targeting.lua',
    'client/editables/esx.lua',
    'client/editables/qb.lua'
}

escrow_ignore {
    'client/editables/editables.lua',
    'config.lua',
    'locale/locale.lua',
    'server/editables/esx.lua',
    'server/editables/qb.lua',
    'client/editables/esx.lua',
    'client/editables/qb.lua',
    'stream/*',
    'client/targeting.lua',
    'server/editables/database.lua'
}

dependency '/assetpacks'
