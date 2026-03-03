shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/locale.lua',
}
client_scripts {
    'bridge/client.lua',
    'client/modules/*.lua',
    'client/callbacks.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/server.lua',
    'server/config.lua',
    'server/main.lua',
    'server/modules/*.lua',
    'server/callbacks.lua'
}
ui_page 'web/dist/index.html'
files {
    'web/dist/index.html',
    'web/dist/**/*',
    'locales/*.json'
}
