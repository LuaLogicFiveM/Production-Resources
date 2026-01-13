shared_script "@ReaperV4/imports/bypass.js"
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'bodacious'
version '0.9.3'
game "gta5"
client_script "game/dist/client.js"
server_script "game/dist/server.js"
ui_page "game/nui/dist/index.html"
files {
    "game/nui/dist/index.html",
    "game/nui/dist/**/*",
}
provide 'screenshot-basic'
