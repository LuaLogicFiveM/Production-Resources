shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
use_experimental_fxv2_oal 'yes'
lua54 'yes'

shared_script '@ox_lib/init.lua'
client_script 'client/*.lua'
server_script 'server/*.lua'

data_file 'FIVEM_LOVES_YOU_341B23A2F0E0F131' 'data/popgroups.ymt'

files { 'configs/*.lua', 'data/*.meta', 'data/*.ymt', 'data/*.dat' }
