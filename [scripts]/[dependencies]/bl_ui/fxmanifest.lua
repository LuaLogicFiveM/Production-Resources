shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper



fx_version 'cerulean'

game "gta5"
use_experimental_fxv2_oal 'yes'
version '2.1.0'

lua54 'yes'

ui_page 'build/index.html'
-- ui_page 'http://localhost:3000/' --for dev

client_script {
    'client/*.lua',
    'client/games/*.lua',
    'client/init.lua'
}

files {
    'build/**',
}
