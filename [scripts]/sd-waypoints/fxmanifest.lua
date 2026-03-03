shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
author 'Samuel#0008'
description 'Physical waypoint markers displayed in 3D world via DUI'
version '1.0.0'
shared_script '@ox_lib/init.lua'
client_scripts {
    'client.lua'
}
files {
    'config.lua',
    'locales/*.json',
    'web/build/index.html',
    'web/build/assets/*.css',
    'web/build/assets/*.js'
}
lua54 'yes'
