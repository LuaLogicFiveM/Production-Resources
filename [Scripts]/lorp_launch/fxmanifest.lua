shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
game 'gta5'
lua54 'yes'

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua'
}

client_scripts {  'client/*.lua' }

ui_page 'html/index.html'
files { 
  "html/*",
}
