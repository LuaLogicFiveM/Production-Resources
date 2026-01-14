shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper


fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '2.7.8'

shared_scripts { '@wasabi_bridge/import.lua', 'configuration/config.lua', 'configuration/locales/*.lua' }

client_scripts { 'client/cl_customize.lua', 'client/client.lua', 'client/functions.lua' }

server_scripts { '@oxmysql/lib/MySQL.lua', 'server/*.lua' }

escrow_ignore {
  'configuration/*.lua',
  'configuration/locales/*.lua',
  'client/cl_customize.lua',
  'client/client.lua',
  'server/sv_customize.lua'
}

dependency '/assetpacks'
