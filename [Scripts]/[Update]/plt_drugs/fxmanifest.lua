shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'damianpetrow https://github.com/damianpetrow'
version '1.1.1'
this_is_a_map 'yes'
shared_scripts {
    'config/config.lua',
    'config/dlcconfig.lua',
    'shared/*.lua'
}
client_scripts {
    'client/callbacks/*.lua',
    'client/bridge/*.lua',
    'client/*.lua',
}
server_scripts {
    'server/callbacks/*.lua',
    'server/bridge/*.lua',
    'server/*.lua',
}
ui_page 'web/index.html'
files {
    '!requirements/images/*.png',
    'web/**',
    'web/assets/**',
    'config/UItranslations.js',
}
dependencies { 'oxmysql', '/assetpacks' }
escrow_ignore {
    'config/config.lua',
    'client/bridge/*.lua',
    'server/bridge/*.lua',
    '!requirements/*.lua',
}
data_file 'DLC_ITYP_REQUEST' 'stream/plt_buckets.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/plt_weed.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/4bit_props.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ar_chemistry_pack_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/dl_weed_pack_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/dl_mixing_station_mk1.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/dl_coke_press_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/dl_lab_oven_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/dl_cauldron_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/dl_chemistry_station_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/Meth_Lab/ytyp/dl_meth_lab_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/Meth_Lab/ytyp/dl_meth_stuff.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/Weed_Lab/ytyp/dl_weed_lab_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/Coke_Lab/ytyp/dl_coke_lab_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/DLC/dl_battering_ram.ytyp'
dependency '/assetpacks'
