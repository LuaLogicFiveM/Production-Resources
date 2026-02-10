fx_version 'bodacious'
game 'gta5'

this_is_a_map 'yes'

data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'
data_file 'AUDIO_GAMEDATA' 'audio/garage_game.dat'
data_file 'TIMECYCLEMOD_FILE' 'fm_timecycle_list_garage.xml'

files {
    'stream/**.ytyp',
    'fm_timecycle_list_garage.xml',
    'audio/garage_game.dat151.rel'
}

escrow_ignore {
    'stream/[editable]/fm_garage_exterior_build_sign.ydr',
    'stream/[editable]/fm_garage_logo.ydr',
}

dependency '/assetpacks'