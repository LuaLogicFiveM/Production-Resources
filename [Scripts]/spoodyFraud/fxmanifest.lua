fx_version 'bodacious'
author 'Spoody'
game 'gta5'
lua54 'yes'

ui_page 'dist/index.html'

files {
    'stream/spoody_leansy_laptop.ytyp',
    'dist/**/*',
    'dist/*',
}

shared_scripts  {
    'configuration.lua',
    '@ox_lib/init.lua',
    'configuration.lua',
}

client_scripts {
    'source/client/functions/*.lua',
    'source/client/world/*.lua',
    'source/client/*.lua',
}

server_scripts {
    'source/server/*.lua',
    'logs.lua'
}

data_file 'DLC_ITYP_REQUEST' 'stream/spoody_leansy_laptop.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/leansy_reader.ytyp'

escrow_ignore {"configuration.lua", "logs.lua", "source/server/alert.lua", "source/server/discord.lua"}
dependency '/assetpacks'