shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_script '@ox_lib/init.lua'

shared_script('config/main.lua')

server_scripts {
    'config/framework_sv.lua',
    'server/main.lua'
}

client_script('client/main.lua')

depedency 'ox_lib'
