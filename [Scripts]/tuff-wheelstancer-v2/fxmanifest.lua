shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "cerulean"
games { "gta5" }
description 'Tuff WheelStancer v3 | Tuff Scripts'
version 'v2.1.7 '
ui_page "html/index.html"
files {
  "html/**",
  "html/assets/**"
}
shared_script {
  '@ox_lib/init.lua',
  'locales/locales.lua',
  'config/config.lua',
}
files {
  'data/*.json'
}
client_scripts {
  'locales/*.lua',
  'config/cl_editable.lua',
  'client/*.lua'
}
server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'config/invoice.lua',
  'config/sv_editable.lua',
  'server/*.lua',
}
escrow_ignore {
  -- [Accessable Files]
  "config/*.lua",
  'locales/*.lua',
}
data_file 'DLC_ITYP_REQUEST' 'stream/tuff_lift.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/tuff_boltprop.ytyp'
dependencies {
  'ox_lib'
}
lua54 'yes'
use_experimental_fxv2_oal 'yes'
dependency '/assetpacks'
