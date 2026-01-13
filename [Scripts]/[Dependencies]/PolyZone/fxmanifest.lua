shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

games {'gta5'}

fx_version 'cerulean'
version '2.6.2'

client_scripts {
  'client.lua',
  'BoxZone.lua',
  'EntityZone.lua',
  'CircleZone.lua',
  'ComboZone.lua',
  'creation/client/*.lua'
}

server_scripts {
  'creation/server/*.lua',
  'server.lua'
}
