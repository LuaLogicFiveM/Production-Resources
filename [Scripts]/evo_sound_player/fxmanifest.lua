shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 'yes'

author 'EvoLabs <evolutionlabsdev@gmail.com>'
description 'evo_sound_player'
version '1.0.20'

shared_scripts {
    'shared/framework.lua',
}

client_scripts {
    'config.lua',
    'client/lib.lua',
    'client/main.lua',
    'client/events.lua',
    'client/exports.lua',
    'client/commands.lua',
    'client/functions.lua',
    'client/fw_functions.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/lib.lua',
    'server/main.lua',
    'server/events.lua',
    'server/exports.lua',
    'server/functions.lua',
    'server/fw_functions.lua',
}

escrow_ignore {
    'config.lua',
    'client/fw_functions.lua',
    'server/fw_functions.lua',
}

ui_page "ui_prod/index.html"

files {
    'locales/*',
    'ui_prod/index.html',
    'ui_prod/static/css/*',
    'ui_prod/static/js/*',
    'ui_prod/**/*'
}
dependency '/assetpacks'
