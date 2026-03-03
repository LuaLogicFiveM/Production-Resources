shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
author "Malizniak - 17Movement"
lua54 "yes"
files {
    "web/**/*.**",
    "web/*.**",
}
ui_page "web/driver.html"
server_scripts {
    "server/functions.lua",
    "server/server.lua",
} 
client_scripts {
    "client/target.lua",
    "client/functions.lua",
    "client/client.lua",
} 
shared_script "Config.lua"
escrow_ignore {
    "Config.lua",
    "client/target.lua",
    "client/functions.lua",
    "server/functions.lua",
}
dependency '/assetpacks'
