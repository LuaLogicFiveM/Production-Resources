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
    "build/shared/_data.lua",
    "build/shared/functions.lua",
}
client_scripts {
    "@utility_lib/client/native.lua",
    "build/client/modules/*.lua",
    "build/client/functions/*.lua",
    "build/client/objects/utils/*.lua",
    "build/client/objects/*.lua",
    "build/client/scenes/**.lua",
    "build/client/*.lua",
}
server_scripts {
    "@utility_lib/server/native.lua",
    "build/server/modules/*.lua",
    "build/server/functions/*.lua",
    "build/server/*.lua",
}
files {
    "audio/**.*",
    "audiodirectory/**.*",
}
data_file 'AUDIO_WAVEPACK' 'audiodirectory'
data_file 'AUDIO_SOUNDDATA' 'audiodirectory/jewelry_sounds.dat'
escrow_ignore {
    "config.lua",
    "config_functions.lua",
    "[items]/*.lua",
}
leap_ignore {
    "config.lua",
    "config_functions.lua",
    "[items]/*.lua",
}
dependency '/assetpacks'
