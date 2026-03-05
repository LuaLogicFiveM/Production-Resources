shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
author 'discord.gg/codesign'
description 'Police Dispatch 3D'
version '1.2.2'
lua54 'yes'

dependency 'cd_bridge'

shared_scripts {
    '@cd_bridge/shared/config.lua',
    '@cd_bridge/shared/auto_detect.lua',
    'configs/locales.lua',
    'configs/config_tables.lua',
    'configs/config.lua'
}

client_scripts {
    '@cd_bridge/client/init.lua',
    'integrations/client/**/*.lua',
    'client/**/*.lua'
}

server_scripts {
    '@cd_bridge/server/init.lua',
    'integrations/server/**/*.lua',
    'configs/server_webhooks.lua',
    'server/**/*.lua'
}

ui_page {
    'html/index.html'
}

files {
    'configs/locales_ui.js',
    'configs/config_ui.js',
    'html/index.html',
    'html/css/*.css',
    'html/css/bootstrap.min.css.map',
    'html/**/*.js',
    'html/assets/*.js',
    'html/assets/*.css',
    'models/*.webp',
    'models/*.glb',
    'models/placeable/*.glb',
    'textures/waternormals.jpg',
    'textures/skybox/*.jpg',
    'html/js/simpleheat/simpleheat.js',
    'html/sounds/*.ogg',
    'html/sounds/*.wav',
    'draco/*.js',
    'draco/*.wasm',
    'draco/gltf/*.js',
    'draco/gltf/*.wasm',
}

exports {
    'GetPlayerInfo',
    'GetAllDispatchNotifications',
    'GetPlayersDispatchData',
    'GetConfig',
}

server_exports {
    'GetAllDispatchNotifications',
    'GetPlayersDispatchData',
    'GetConfig',
    'GetDispatchCalls_PS'
}

escrow_ignore {
    'client/main/bridge.lua',
    'client/other/chat_commands.lua',
    'client/other/dispatcher.lua',
    'client/other/functions.lua',
    'client/other/job_call_commands.lua',
    'client/other/panic_button.lua',
    'client/other/ping.lua',
    'client/other/police_alerts/*.lua',
    'configs/*.lua',
    'integrations/**/*.lua',
    'server/main/auto_insert_sql.lua',
    'server/main/callbacks.lua',
    'server/main/debug.lua',
    'server/main/version_check.lua',
    'server/other/functions.lua',
    'server/other/gps_tracker.lua',
    'server/other/job_call_commands.lua',
    'server/other/panic_button.lua',
    'server/other/player_loaded.lua',
    'server/other/police_alerts.lua',
    'server/other/radio_channel.lua',
}

provide 'cd_dispatch'
dependency '/assetpacks'
