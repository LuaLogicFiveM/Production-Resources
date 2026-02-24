shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games {'gta5'}

author 'The Ambitioneers'
description 'Roxwood County Vehicle Package'
version '2.0.0'

escrow_ignore {
  'data/carvariations.meta',
  'data/carcols.meta',
}

files {
  'data/vehicles.meta',
  'data/carvariations.meta',
  'data/handling.meta',
  'data/vehiclelayouts.meta',
  'data/carcols.meta',

  'data/*.meta',
  
  'vehicle_names.lua',
  
  'audio/amb_rox_cars_game.dat151.rel',
  'audio/marbrx_game.dat151.rel',
  'audio/raidcoprx_game.dat151.rel',
  'audio/yosbrushen_game.dat151.rel',
  'audio/grangerfdeng_game.dat151.rel',
  'audio/issifambeng_game.dat151.rel',
  'audio/roxvehsounds_game.dat151.rel',
  'audio/caraclgrdeng_game.dat151.rel',
  'audio/buff4poleng_game.dat151.rel',  
  'audio/rox2020polscouteng_game.dat151.rel',
  'audio/roxbus_game.dat151.rel',
}

data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/vehiclelayouts.meta'

-- Audio --
data_file 'AUDIO_GAMEDATA' 'audio/amb_rox_cars_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/marbrx_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/raidcoprx_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/yosbrushen_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/grangerfdeng_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/issifambeng_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/roxvehsounds_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/caraclgrdeng_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/buff4poleng_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/rox2020polscouteng_game.dat'
data_file 'AUDIO_GAMEDATA' 'audio/roxbus_game.dat'

-- Client --
client_script 'roxbuffalo4.lua'
client_script 'vehicle_names.lua'
lua54 'yes'
dependency '/assetpacks'
