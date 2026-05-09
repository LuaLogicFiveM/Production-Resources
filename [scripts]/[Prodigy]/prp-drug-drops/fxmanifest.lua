shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
author "Prodigy Studios"
version "1.0.0"
ui_page "ui/index.html"
files {
    "locales/*.json",
    "ui/index.html",
    "ui/**/*",
}
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "init.lua"
}
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config.lua",
    "server/**/*.lua"
}
client_scripts {
    "client/**/*.lua"
}
escrow_ignore {
    "server/**/*.lua",
    "installation/**/*.lua",
    "init.lua",
    "config.lua",
}
dependency '/assetpacks'
