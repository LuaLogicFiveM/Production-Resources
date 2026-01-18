shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
game "gta5"
lua54 "yes"

author 'MXC'
description 'DRIVE-IN'
version '1.0.0'

this_is_a_map 'yes'

data_file 'TIMECYCLEMOD_FILE' 'mxc_timecycle_list_01.xml'

client_script {
    'drivein_entityset_mods.lua',
}

files {
    'mxc_timecycle_list_01.xml',
}

escrow_ignore {
    'drivein_entityset_mods.lua',
    'stream/[exterior]/[multi-location]/[la-puerta]/*.ydr',
    'stream/[exterior]/[multi-location]/[paleto]/*.ydr',

}
dependency '/assetpacks'
