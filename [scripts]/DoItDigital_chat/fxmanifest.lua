shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

version '2.01.24'
author 'DoItDigital'
description 'Chat System With Live Editor No Codding Needed'
client_scripts {
    'configs/c_config.lua',
    'client/main.lua',
    'client/chatBridge.lua',
    'client/nui.lua',
    'client/functions.lua',
    'client/editable.lua',
  }
  server_scripts {
    'configs/s_config.lua',
    'server/spamProtecror.lua',
    'server/autoMessage.lua',
    'server/main.lua',
    'server/editable.lua',
    'server/chatHook.lua',
    'server/chatLogger.lua',
    'server/chatCommands.lua',
    'server/namePerksEditable.lua',
  }
ui_page 'web/ui.html'
files {
    'web/ui.html',
    'web/css/editor.css',
    'web/css/bridge.css',
    'web/bridge.js',
    'web/editor.js',
    'web/ui.html',
    'web/images/*.png',
    'web/images/chat-appearance/*',
}
chat_theme 'doitdigital' {
    styleSheet = 'web/css/bridge.css',
    script = 'web/bridge.js',
}
escrow_ignore {
  'codeSnippets.lua',
  'server/editable.lua',
  'client/editable.lua',
  'configs/c_config.lua',
  'configs/s_config.lua',
  'server/namePerksEditable.lua',
}
lua54 'yes'
game 'gta5'
fx_version 'adamant'
dependency '/assetpacks'
