shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper



fx_version 'cerulean'

game 'gta5'

lua54 'yes'

client_script {
    'native_cl.lua',
    'init_cl.lua',
}
server_script {
    'native_sv.lua',
    'init_sv.lua',
}

export 'GetMySteamID'
dependency '/assetpacks'
