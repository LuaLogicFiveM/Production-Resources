shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
author "Prodigy Studios"
version "1.0.0"
files {
    "ui/**/*",
    "locales/*.json",
}
ui_page "ui/index.html"
server_scripts {
    "config/config.lua",
    "server/class.lua",
    "server/server.lua",
    "server/queue.lua",
}
client_scripts {
    "client/**/*.lua",
    "open/client/**/*.lua",
}
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "shared/*",
    "config/main.lua",
    "init.lua"
}
escrow_ignore {
    "init.lua",
    "server/**/*.lua",
    "config/**/*.lua",
    "open/client/**/*.lua",
}
dependency '/assetpacks'
