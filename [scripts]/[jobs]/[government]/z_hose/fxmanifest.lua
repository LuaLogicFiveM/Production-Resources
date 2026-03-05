shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

---@section fx_information

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

---@section resource_information

name 'z_hose'
author 'Zea Development - https://discord.gg/zHvPyJzhQU'
url 'https://zeadevelopment.com/'
version 'e52246b'

---@section language

language 'en'

---@section dev_mode

dev_mode 'false'

---@section shared_script

shared_script({
    'settings/config.lua',
    'settings/permissions.lua'
})

---@section client_script

client_script({
    'core/client/init.lua',
    'core/client/cl-main.lua',
    'core/client/classes/*.lua'
})

---@section server_script

server_script({
    'core/server/init.lua',
    'core/server/sv-main.lua',
    'core/server/classes/*.lua'
})

---@section ui_page

ui_page 'web/nui/nui.html'

---@section files

files({
    'web/**/',
    'settings/modules/*.lua',
    'settings/*.json'
})

---@section data_file

data_file('DLC_ITYP_REQUEST')('stream/prop_hard_suction.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/standpipe.ytyp')
data_file('DLC_ITYP_REQUEST')('stream/prop_lpp.ytyp')

---@section escrow_ignore

escrow_ignore({
    'settings/config.lua',
    'settings/permissions.lua',
    'settings/ui_locale.json',
    'settings/modules/*.lua',
    'core/client/classes/enums.lua',
    'core/client/classes/bridge.lua',
    'core/client/classes/exports.lua',
    'core/server/classes/bridge.lua',
})

---@section dependencies

dependencies({
    '/onesync'
})
dependency '/assetpacks'
