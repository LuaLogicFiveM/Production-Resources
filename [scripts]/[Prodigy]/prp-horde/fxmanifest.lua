shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

-- Resource Metadata
fx_version "cerulean"
game "gta5"
author "Prodigy Studios"
version "1.0.0"
shared_scripts {
    "@ox_lib/init.lua",
    "@prp-bridge/import.lua",
    "config/general.lua",
    "init.lua",
}
client_scripts {
    "client/cl_*.lua",
    "open/client/*.lua"
}
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config/sv_config.lua",
    "server/sv_*.lua",
    "server/classes/*.lua",
}
ui_page "ui/index.html"
files {
    "data/prp_horde.dat54.rel",
    "audiodirectory/prp_horde.awc",
    "ui/index.html",
    "ui/**/*",
    "locales/*.json",
    "stream/*.ytyp"
}
data_file "AUDIO_WAVEPACK" "audiodirectory"
data_file "AUDIO_SOUNDDATA" "data/prp_horde.dat"
data_file "DLC_ITYP_REQUEST" "stream/*.ytyp"
escrow_ignore {
    "init.lua",
    "open/**/*",
    "server/sv_*.lua",
    "server/classes/*.lua",
    "config/**/*.lua",
    "types/**/*.lua"
}
dependency '/assetpacks'
