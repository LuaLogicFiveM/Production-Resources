shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"

this_is_a_map 'yes'

shared_scripts {
    "[script]/config.lua",
}

client_scripts {
    "@utility_lib/client/native.lua",
    "[script]/client/internal_api.lua",
    "[script]/client/modules/*.lua",
    "[script]/client/*.lua",
}

server_scripts {
    "@utility_lib/server/native.lua",
    "[script]/server/**.lua",
}

data_file 'TIMECYCLEMOD_FILE' 'mxc_timecycle_list_01.xml'
data_file 'AUDIO_GAMEDATA' '[audio]/mxc_pitstop_game.dat'

files {
    'mxc_timecycle_list_01.xml',
    '[audio]/mxc_pitstop_game.dat151.rel',
}

escrow_ignore {
    "stream/[location]/[default]/*.ydr",
    "stream/[int]/[editable_if_you_have]/*.*",
    "stream/[eup-clothing]/mp_m_freemode_01_male_heist^jbib_013_u.ydd",
    "stream/[eup-clothing]/mp_m_freemode_01_male_heist^lowr_006_r.ydd",
    "[script]/config.lua",
    "[script]/config_functions.lua",

}
dependency '/assetpacks'
