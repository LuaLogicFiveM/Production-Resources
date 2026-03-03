shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}
client_scripts {
    'resource/client.lua',
}
files {
    'locales/*.json',
}
dependencies {
    'ox_lib'
}
