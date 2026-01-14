shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version "1.1.0"
client_scripts {
    "@ox_lib/init.lua",
    "client/client.lua",
}
ui_page "web/build/index.html"
files {
    "web/build/index.html",
    "web/build/**/*",
    'locales/*.json',
    "shared/*.lua",
}
