shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
games { "gta5" }
lua54 "yes"
author "Prodigy Studios"
version "1.0.1"
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "shared/*.lua",
}
files {
    "locales/*.json",
    "editable/*.json",
    "ui/dist/**/*.*",
}
ui_page "ui/dist/index.html"
client_scripts {
    "editable/cl_*.lua",
    "client/**/*.lua",
}
server_scripts {
    "editable/sv_*.lua",
    "server/**/*.lua",
}
escrow_ignore {
    "editable/**/*.lua",
    "shared/**/*.lua",
    "server/main.lua"
}
dependency '/assetpacks'
