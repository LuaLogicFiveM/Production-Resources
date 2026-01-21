fx_version 'cerulean'
game 'gta5'

lua54 'yes'

version '1.0.6'

author 'Mosoto Scripts'
description 'The most advanced seatbelt system for FiveM'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

client_scripts {
    'code/modules/client.lua',
}

server_scripts {
    'code/modules/server.lua',
    'code/core/version_checker.lua'
}

files {
    'code/web/index.html',
    'code/web/styles.css',
    'code/web/main.js',
    'code/web/assets/indicator.png',
    'code/web/assets/heartbeat.ogg'
}

ui_page 'code/web/index.html'

data_file 'DLC_ITYP_REQUEST' 'mst_seatbelt.ytyp'

escrow_ignore {
    'config.lua',
}
dependency '/assetpacks'