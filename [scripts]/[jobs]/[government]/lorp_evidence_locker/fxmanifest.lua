shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
shared_script {
  '@ox_lib/init.lua',
  'config.lua',
}
files {
  'locales/*.json',
}
client_scripts {
  'client/*.lua',
}
server_scripts {
  'server/*.lua',
  '@oxmysql/lib/MySQL.lua'
}
