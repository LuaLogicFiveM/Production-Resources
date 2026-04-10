fx_version 'cerulean'
game 'gta5'

lua54 'yes'
author 'spoodyCreations'
description 'spoodyGangsV2'
version '1.0.0'

ui_page 'nui/dist/index.html'

files {
    'nui/dist/**/*',
    'nui/dist/*',

    'discord.json'
}

server_scripts {
    '@oxmysql/lib/MySQl.lua',
    'config/discord.lua',
    'game/customize/server.lua',
    'game/server/*.lua',
    'game/server/manager/*.lua',
    'game/server/discord/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config/configuration.lua',
    'config/locales.lua'
}

client_scripts {
    'game/customize/client.lua',
    'game/client/*.lua',
    'game/client/creator/*.lua',
}

dependency 'ox_lib'
escrow_ignore {'config/configuration.lua', 'config/discord.lua', 'config/locales.lua', 'game/customize/server.lua', 'game/customize/client.lua'}
dependency '/assetpacks'