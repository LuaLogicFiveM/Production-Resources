shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

version '3.0.1' -- Use this script version when making a ticket

use_experimental_fxv2_oal 'yes'
game 'gta5'
lua54 'yes'

description 'nass_dragstrips'
author 'Nass Scripts'

data_file 'DLC_ITYP_REQUEST' 'stream/nass_dragtree.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/nass_dragtree_pro.ytyp'

shared_scripts { '@ox_lib/init.lua', '@nass_lib/import.lua', 'locale.lua', 'config.lua' }
client_scripts {  'client/*.lua' }
server_scripts {  '@oxmysql/lib/MySQL.lua', 'server/*.lua' }

escrow_ignore {
  --"**"
  'config.lua',
  'client/unlocked.lua',
  'server/unlocked.lua',
  'locale.lua'
}

ui_page 'html/index.html'

files { 
  "html/**/*",
  "html/*",
}

dependencies {
	'nass_lib',
  'ox_lib',
  'oxmysql',
}
fx_version 'cerulean' -- This is NOT the script version when making a ticket
dependency '/assetpacks'
