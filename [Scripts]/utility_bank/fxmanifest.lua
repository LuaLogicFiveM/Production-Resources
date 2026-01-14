shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
author "XenoS, MXC"
shared_scripts {
    "config.lua",
    "config_functions.lua",
    "shared/*.lua",
}
client_scripts {
    "@utility_lib/client/native.lua",
    "client/internal_api.lua",
    "client/functions/*.lua",
    "client/internal_modules/*.lua",
    "client/modules/*.lua",
    "client/events.lua",
    "client/main.lua",
}
server_scripts {
    "@utility_lib/server/native.lua",
    "server/internal_api.lua",
    "server/functions.lua",
    "server/modules/*.lua",
    "server/main.lua",
}
files {
    "audio/*.*",
    'stream/**.ytyp'
}
data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'
escrow_ignore {
    "config.lua",
    "config_functions.lua",
}
dependency '/assetpacks'
