shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'

game "gta5"

author "Byte Labs"
version '1.5.0'
description 'Byte Labs ID Card'
repository 'https://github.com/Byte-Labs-Project/bl_idcard'

lua54 'yes'

dependency 'bl_bridge'
ui_page 'web/build/index.html'
-- ui_page 'http://localhost:3000/' --for dev

shared_script '@ox_lib/init.lua'

server_script {
    '@bl_bridge/imports/server.lua',
    'server/init.lua'
}

client_script {
    '@bl_bridge/imports/client.lua',
    'client/init.lua',
}

files {
    'web/mugshots/*.png',
    'web/build/**',
    'client/**',
    'shared/**'
}
