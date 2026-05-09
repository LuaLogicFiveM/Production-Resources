shared_script "@ReaperV4/imports/bypass.js"
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
games { "gta5" }
lua54 "yes"
ui_page "ui/index.html"
author "Prodigy Studios"
version "1.0.4"
files {
    "ui/index.html",
    "ui/**/*",
    "dui/**/*",
    "locales/*.json"
}
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "config.lua",
}
client_scripts {
    "client/*.lua"
}
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "sv_config.lua",
    "server/**/*.lua",
    "dist/server.js"
}
escrow_ignore {
    "config.lua",
    "sv_config.lua",
    "server/editable.lua",
    "client/nui.lua",
    "types.lua"
}
dependency '/assetpacks'
