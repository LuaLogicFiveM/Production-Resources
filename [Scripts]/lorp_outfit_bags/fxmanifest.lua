shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
version '1.0.0'
lua54 'yes'
author 'ENT510'

shared_scripts {
  '@ox_lib/init.lua',
}

client_scripts {
  'Modules/Client/cl-constructor.lua',
  'Modules/Client/cl-cam.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'Modules/Server/sv-functions.lua',
  'Modules/Server/sv-main.lua',
}

files {
  'Modules/Client/cl-config.lua',
  'Modules/Shared/shared.lua',
}

