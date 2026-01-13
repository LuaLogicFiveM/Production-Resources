shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 'yes'
version '1.0.17'

client_scripts {
    'config.lua',
    'client/lib.lua',
    'client/main.lua',
    'client/time.lua',
    'client/locale.lua',
    'client/events.lua',
    'client/commands.lua',
    'client/commands_open.lua',
    'client/interact_sound/client.lua',
    'client/exports/events.lua',
    'client/exports/info.lua',
    'client/exports/manipulation.lua',
    'client/exports/play.lua',
    'client/effects/main.lua',
    'client/utils/utils.lua'
}

server_scripts {
    'config.lua',
    'server/lib.lua',
    'server/main.lua',
    'server/exports/exports.lua',
    'server/utils/utils.lua',
    'server/interact_sound/server.lua'
}

escrow_ignore {
    'config.lua',
    'client/commands_open.lua'
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
