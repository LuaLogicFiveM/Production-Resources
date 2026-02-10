shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

game "gta5"
fx_version "cerulean"
lua54 "yes"
author "MXC, XenoS"
client_scripts {
    "@utility_lib/client/native.lua",
    "build/client/modules/objectify.lua",
    "build/client/modules/status.lua",
    "build/client/modules/inventory.lua",
    "build/client/modules/universalInteraction.lua",
    "build/client/modules/jobChecker.lua",
    "build/client/*.lua",
    "build/client/modules/localazy.lua",
    "configs/interactions.lua",
    "build/client/functions/*.lua",
    "build/client/objects/*.lua",
    "build/client/objects/shared/**.lua",
    "build/client/objects/furniture/**.lua",
    "build/client/objects/pickups/**.lua",
    "build/client/objects/prefabs/**.lua",
    "build/client/objects/content/**.lua",
    "build/client/expansions/**.lua",
}
server_scripts {
    "@utility_lib/server/native.lua",
    "build/server/modules/objectify.lua",
    "build/server/modules/inventory.lua",
    "build/server/*.lua",
    "build/server/modules/localazy.lua",
    "configs/interactions.lua",
    
    "build/server/prefabs/*.lua",
    "build/server/expansions/**.lua",
}
shared_scripts {
    "configs/general.lua",
    "configs/items.lua",
    "configs/kitchens.lua",
    "configs/config_functions.lua",
    "build/shared/*.lua"
}
files {
    "imgs/**.*",
    "audiodirectory/**.*",
    "configs/expansions/*.lua",
}
escrow_ignore {
    "configs/*.lua",
    "configs/expansions/*.lua",
    "[items]/**.lua",
    "[compatibility]/**.*",
}
leap_ignore {
    "configs/*.lua",
    "configs/general.lua",
    "configs/interactions.lua",
    "configs/items.lua",
    "configs/kitchens.lua",
    "configs/config_functions.lua",
    "configs/expansions/*.lua",
    "[items]/**.lua",
    "[compatibility]/**.*",
}
file 'stream/**.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'
data_file 'AUDIO_WAVEPACK' 'audiodirectory'
data_file 'AUDIO_SOUNDDATA' 'audiodirectory/kitchen_sounds.dat'
dependency '/assetpacks'
