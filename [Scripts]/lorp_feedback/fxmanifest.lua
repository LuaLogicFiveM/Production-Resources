shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

version '1.0.1'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'resource/client.lua'

server_script 'resource/server.lua'

files {
    'locales/*.json',
}