shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

--[[
BY RX Scripts © rxscripts.xyz
--]]

fx_version 'cerulean'
games { 'gta5' }
version '1.3.0'

server_script 'config/sv_config.lua'

shared_script {
  'config/config.lua',
  'init.lua',
  'locales/*.lua',
}

client_scripts {
  'client/utils.lua',
  'client/functions.lua',
  'client/opensource.lua',
  'client/staffpanel.lua',
  'client/reportpanel.lua',
  'client/main.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/utils.lua',
  'server/user.lua',
  'server/report.lua',
  'server/functions.lua',
  'server/opensource.lua',
  'server/main.lua',
}

ui_page 'web/dist/index.html'

files {
  'web/dist/index.html',
  'web/dist/assets/*.*',
}

lua54 'yes'

escrow_ignore {
  'locales/*.lua',
  'server/opensource.lua',
  'client/opensource.lua',
  'config/*.lua',
  'fxmanifest.lua'
}
dependency '/assetpacks'
