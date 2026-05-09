shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
games { "gta5" }
lua54 "yes"
author "Prodigy Studios"
version "1.0.0"
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "configs/main.lua",
    "configs/outposts.lua",
    "configs/ped_profiles.lua"
}
escrow_ignore {
    "configs/**/*",
    "server/**/*"
}
client_scripts {
    "client/**/*"
}
server_scripts {
    "configs/server.lua",
    "server/**/*"
}
ui_page "ui/index.html"
files {
    "ui/**/*.*",
    "locales/*.json"
}
dependency '/assetpacks'
