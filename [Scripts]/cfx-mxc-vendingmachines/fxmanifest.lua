shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"
shared_scripts {
    "config.lua",
    "config_functions.lua"
}
client_scripts {
    "@utility_lib/client/native.lua",
    "client/*.lua",
    "client/vendings/*.lua",
    "client/modules/*.lua",
}
server_scripts {
    "@utility_lib/server/native.lua",
    "server/*.lua",
    "server/modules/*.lua"
}
files {
    "dui/**.*",
    "audiodirectory/**.*",
}
escrow_ignore {
    "config.lua",
    "config_functions.lua",
    "[items]/*.lua",
    --"[template_prop_sourcecode]/*.ydr"
}
file 'stream/[default]/*.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[default]/*.ytyp'
file 'stream/[ytyp]/*.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[ytyp]/*.ytyp'
data_file 'AUDIO_WAVEPACK' 'audiodirectory'
data_file 'AUDIO_SOUNDDATA' 'audiodirectory/vending_sounds.dat'
dependency '/assetpacks'
