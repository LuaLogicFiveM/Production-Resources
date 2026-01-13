shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'bodacious'
game 'gta5'

version '1.5.9'

lua54 'yes'

shared_scripts {
	'object.lua',
}

client_scripts {
    'shared/helpers.lua',
    'config_translations.lua',
    'config.lua',
    'client/frameworks/*.lua',
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'shared/helpers.lua',
    'config_translations.lua',
    'config.lua',
    'server/*.lua',
    'server/frameworks/*.lua',
    'server/db/*.lua'
}

dependencies {
    '/server:4752',
    '/onesync',
}

ui_page 'ui/build/index.html'

files {
    'ui/build/index.html',
    'ui/build/**/*'
}

escrow_ignore {
    "config.lua",
    "config_translations.lua",
    "object.lua",
    "shared/helpers.lua",
    "client/frameworks/custom.lua",
    "client/frameworks/esx.lua",
    "client/frameworks/qbcore.lua",
    "client/client.lua",
    "client/caddy.lua",
    "client/lobby.lua",
    "client/nui.lua",
    "server/frameworks/custom.lua",
    "server/frameworks/esx.lua",
    "server/frameworks/qbcore.lua",
    "server/inventory_detection.lua",
    "server/discord.lua",
    "server/validation.lua",
    'server/db/bridge.lua',
    'server/db/db.lua'
}
dependency '/assetpacks'
