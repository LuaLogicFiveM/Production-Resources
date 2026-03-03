shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
lua54 "yes"
game "gta5"
client_script "client/init.lua"
server_script "server/init.lua"
ui_page "ui/build/index.html"
files {
    "ui/build/index.html",
    "ui/build/**/*",
}
