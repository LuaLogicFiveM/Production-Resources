shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

---@type fx_information

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

---@type resource_information

name 'z_ppvfan'
author 'Zea Development - https://discord.gg/zHvPyJzhQU'
url 'https://zeadevelopment.com/'
version 'v1.0.9'

---@type language

language 'en'

---@type dev_mode

dev_mode 'false'

---@type: shared_script

shared_script ({
    'config.lua'
})

---@type: client_script

client_script ({
    'core/client/init.lua',
    'core/client/cl-main.lua',
    'core/client/classes/*.lua'
})

---@type: server_script

server_script ({
    'core/server/init.lua',
    'core/server/sv-main.lua',
    'core/server/classes/*.lua'
})

---@type ui_page

ui_page 'web/nui.html'

---@type files

files ({
    'assets/*.png',
    'stream/*.ycd',
    'stream/*.yft',

    'web/**'
})

---@type: data_file

data_file 'DLC_ITYP_REQUEST' 'stream/zea_ppvfan_ytyp.ytyp'

---@type: escrow_ignore

escrow_ignore ({
    'config.lua', 
    'core/client/classes/utils.lua',
    'core/client/classes/keybinds.lua',
    'core/client/classes/exports.lua',
    'core/client/classes/bridge.lua',
    'core/server/classes/bridge.lua'
})

---@type dependencies

dependencies ({
    '/onesync'
})
dependency '/assetpacks'
