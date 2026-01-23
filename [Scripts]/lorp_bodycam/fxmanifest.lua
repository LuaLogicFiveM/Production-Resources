shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game "gta5"
version '2.5.6'
lua54 'yes'
ui_page 'web/index.html'

shared_script {
  "config.lua",
  '@ox_lib/init.lua',
}

server_script {
  "server/**",
  '@oxmysql/lib/MySQL.lua',
}

client_script {
  'client/**',
}

files {
  'web/**',
}
