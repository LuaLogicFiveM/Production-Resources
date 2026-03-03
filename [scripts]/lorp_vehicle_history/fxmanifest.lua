shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.0.2'

shared_scripts {'@ox_lib/init.lua', 'config.lua', 'shared/*.lua'}

client_scripts {'bridge/client.lua', 'client/*.lua'}

server_scripts {'@oxmysql/lib/MySQL.lua', 'bridge/server.lua', 'server/*.lua'}

ui_page 'ui/index.html'

files {'locales/*.json', 'ui/index.html', 'ui/style.css', 'ui/app.js', 'ui/assets/*'}