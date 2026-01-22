fx_version 'adamant'
game 'gta5'
description "Advanced Radio"
author "MenanAk47"
version "1.3"
lua54 'yes'

shared_scripts {
    'locales/locale.lua',
    'locales/en.lua',
    'config.lua'
}

client_scripts {
	'client/main.lua'
} 

server_scripts {
	'server/main.lua'
} 

ui_page 'web/index.html'

files {
    'web/**/*',
}

escrow_ignore {
	"INSTALL ME FIRST/**/*",
    'locales/*.lua',
    'config.lua',
}

dependencies {
	'ak47_bridge',
	'pma-voice',
}
dependency '/assetpacks'