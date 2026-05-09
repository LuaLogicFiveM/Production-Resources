shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
games { "gta5" }
lua54 "yes"
author "Prodigy Studios"
description "Drugs"
version "1.0.0"
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "shared.lua",
    "config/client.lua",
}
escrow_ignore {
    "client/editable.lua",
    "server/editable.lua",
    "config/**/*.lua",
}
client_scripts {
    "client/**/*.lua"
}
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config/server.lua",
    "server/**/*.lua"
}
files {
    "locales/*.json",
    'ui/index.html',
    'ui/assets/**/*',
}
ui_page 'ui/index.html'
dependency '/assetpacks'
