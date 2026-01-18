shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games { 'gta5' }

author 'tw-store'
description 'tw-store-plumber_assets'
version '1.0'

files { '*.meta' }


data_file 'DLC_ITYP_REQUEST' 'pipes.ytyp'
data_file 'DLC_ITYP_REQUEST' 'ttmodz_ek_addons.ytyp'
data_file 'DLC_ITYP_REQUEST' 'portillo.ytyp'
data_file 'DLC_ITYP_REQUEST' 'tw_plunger.ytyp'

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

client_script 'vehicle_names.lua'

escrow_ignore {
    'vehicle_names.lua',
}

lua54 'yes'
dependency '/assetpacks'
