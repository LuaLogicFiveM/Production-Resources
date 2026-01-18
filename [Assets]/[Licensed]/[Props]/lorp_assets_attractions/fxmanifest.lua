shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'adamant'

game 'gta5'

this_is_a_map 'yes'

data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_boat_anim_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_boat_lodka_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_boat_zakladna_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_boat_zavirani_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_autodrom_auticko_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_autodrom_auticko_g_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_autodrom_auticko_b_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_autodrom_auticko_p_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_autodrom_anim_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_autodrom_zakladna_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_detonator_anim_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_detonator_sedacka_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_detonator_sedacka_anim_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_detonator_zakladna_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_detonator_zavirani_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_ferris_kolo_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_ferris_sedacka_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_ferris_zakladna_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_gbooster_rameno_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_gbooster_rameno_anim_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_gbooster_sedacka_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_gbooster_sedacka_anim_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_gbooster_zakladna_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_gbooster_zakladna_anim_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_gbooster_zavirani_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_bus_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_bus_anim_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_bus_blue_screen_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_bus_plysak_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_bus_red_screen_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_bus_target_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_ticket_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_topscan_rameno_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_topscan_rameno_2_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_topscan_rameno_2_anim_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_topscan_sedacka_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_topscan_stred_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_topscan_zakladna_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_topscan_zakladna_anim_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_vortex_anim_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_vortex_anim_sedacka_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_vortex_rameno_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_vortex_sedacka_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_vortex_zakladna_spawn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/sempre_delperropier_vortex_zavirani_spawn.ytyp'

files {
    'vehicles.meta',
    'handling.meta',
}

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'

client_script 'vehicle_names.lua'

escrow_ignore {
  'stream/sempre_delperropier_spawn.ytd'
}

lua54 'yes'
dependency '/assetpacks'
