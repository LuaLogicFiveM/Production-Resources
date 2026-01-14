shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper


fx_version  'cerulean'
game        'gta5'
lua54       'yes'

files {
    'data/progress.lua',
    'data/vehicle.lua',
    'modules/handler.lua',
    'locales/*.json'
}

shared_script '@ox_lib/init.lua'
client_script 'client.lua'
server_script 'server.lua'
