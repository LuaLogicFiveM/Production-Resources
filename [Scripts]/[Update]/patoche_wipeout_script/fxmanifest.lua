shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

version '1.0.1'
author 'Pilouxs'
contact 'https://discord.gg/NvrTRdh'

ox_lib 'locale'

shared_scripts {
    'config/shared.lua',
    'config/data.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'bridge/client.lua',
    'client/games_mechanics.lua',
    'client/elevator.lua',
    'client/target.lua',
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/server.lua',
    'server/main.lua',
    'server/elevator.lua'
}

files {
    'config/**.lua',
    'images/*.webp',
    'locales/*.json',
	'audiodirectory/patoche_elevator.awc',
    'data/patoche_elevator.dat54.rel'
}

escrow_ignore {
    'config/shared.lua',
    'config/server.lua',
    'bridge/**.*'
}

data_file 'AUDIO_WAVEPACK' 'audiodirectory'
data_file 'AUDIO_SOUNDDATA' 'data/patoche_elevator.dat'

lua54 'yes'
use_experimental_fxv2_oal 'yes'
dependency '/assetpacks'
