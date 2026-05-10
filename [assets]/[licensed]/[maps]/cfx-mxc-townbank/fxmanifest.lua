shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"

author 'MXC'
description 'LITTLETOWNBANK'
version '1.0.0'

this_is_a_map 'yes'

client_script {
    'townbank_entityset_mods.lua',
}

data_file 'TIMECYCLEMOD_FILE' 'mxc_timecycle_list_01.xml'

files {
    'mxc_timecycle_list_01.xml',
}

escrow_ignore {
    'townbank_entityset_mods.lua',
    'stream/[multi-locations]/limbo-chumash/*.ydr',
    'stream/[multi-locations]/limbo-grapeseed/*.ydr',
    'stream/[multi-locations]/limbo-palomino/*.ydr',
    'stream/[multi-locations]/limbo-route68/*.ydr',
    'stream/[multi-locations]/limbo-sandyshores/*.ydr',
    'stream/[interior]/(editable_if_you_have)/mxc_ltownbank_limbo_logosign.ydr',
}

-- PREMIUM ONLY

data_file 'AUDIO_GAMEDATA' '[audio]/mxc_ltownbank_game.dat'

file {
    '[audio]/mxc_ltownbank_game.dat151.rel',
}
dependency '/assetpacks'
