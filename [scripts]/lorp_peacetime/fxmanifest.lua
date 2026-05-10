shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper



fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_scripts {
    'source/client/*.lua',
}

server_scripts {
    'source/server/*.lua',
}

shared_script '@ox_lib/init.lua'

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/main.js'
}
