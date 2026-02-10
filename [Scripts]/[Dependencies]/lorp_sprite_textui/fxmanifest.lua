shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
  '@ox_lib/init.lua',
}

client_scripts {
  'Modules/Client/cl-nui.lua',
  'Modules/Client/cl-hold.lua',
  'Modules/Client/cl-exports.lua',
  'Modules/Client/cl-example.lua',
}

files {
  'Modules/Client/cl-config.lua',
  'web/build/index.html',
  'web/build/**/*',
}

ui_page 'web/build/index.html'
