shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
author 'wasabiscripts.com'
description 'Gang Wars'
version '1.0.6'
ui_page 'web/dist/index.html'
files {
  'web/images/**/*.*',
  'web/images/*.*',
  'web/dist/index.html',
  'web/dist/assets/*.*',
}
shared_scripts {
  '@wasabi_bridge/import.lua',
  'config.lua',
  'init.lua',
  'locales/*.lua',
}
client_scripts {
  'client/utils.lua',
  'client/functions.lua',
  'client/opensource.lua',
  'client/main.lua',
  'server/sync/**/client.lua'
}
server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/utils.lua',
  'server/functions.lua',
  'server/classes/*.lua',
  'server/opensource.lua',
  'server/main.lua',
  'server/updater.lua',
  'server/sync/**/server.lua'
}
dependencies { 'oxmysql', 'wasabi_bridge' }
escrow_ignore {
  'locales/*.lua',
  'server/opensource.lua',
  'client/opensource.lua',
  'config.lua',
  'fxmanifest.lua'
}
dependency '/assetpacks'
