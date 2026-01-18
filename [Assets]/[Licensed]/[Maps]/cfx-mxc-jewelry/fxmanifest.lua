shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"

author 'MXC'
description 'JEWELRY'
version '1.0.0'

this_is_a_map 'yes'

data_file 'TIMECYCLEMOD_FILE' 'mxc_timecycle_list_01.xml'
data_file 'AUDIO_GAMEDATA' '[audio]/mxc_jewelry_game.dat'

files {
    'mxc_timecycle_list_01.xml',
    '[audio]/mxc_jewelry_game.dat151.rel',
}

client_script {
    'client.lua',
}

escrow_ignore {
    'stream/[exterior]/[multi-location]/[1-VangelicoRockfordHills]/[gta5files]/*.ydr',
    'stream/[interior]/mxc_jewelry_props_editableneonlogo.ydr',
}
dependency '/assetpacks'
