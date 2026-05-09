shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
author "Prodigy Studios"
version "1.0.0"
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "init.lua"
}
files {
    "locales/*.json",
    "ui/**/*",
    'stream/*.ytyp',
}
ui_page "ui/index.html"
client_scripts {
    "client/*"
}
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config.lua",
    "server/*"
}
escrow_ignore {
    "server/**/*.lua",
    "config.lua",
}
data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'
dependency '/assetpacks'
