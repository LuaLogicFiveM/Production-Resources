shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
lua54 'yes'
game 'gta5'
version '1.0.0'
ui_page 'web/build/index.html'
shared_scripts {
  '@ox_lib/init.lua',
  'shared/config.lua'
}
client_scripts {
  'client/client.lua'
}
server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/classes/vote.lua',
  'server/classes/manager.lua',
  'server/server.lua'
}
files {
  'web/build/index.html',
  'web/build/**/*'
}
