fx_version 'bodacious'
game 'gta5'

this_is_a_map 'yes'

data_file 'TIMECYCLEMOD_FILE' 'fm_timecycle_list_ltd.xml'
data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'

files {
    'fm_timecycle_list_ltd.xml',
    'stream/**.ytyp',
}

escrow_ignore {
    'stream/[editable]/fm_ltd_atm_sign_01.ydr',
}

dependency '/assetpacks'