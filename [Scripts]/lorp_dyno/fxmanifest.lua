shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
version '1.3.0'

ui_page 'html/blank.html'

data_file 'DLC_ITYP_REQUEST' 'stream/kq_dyno_props.ytyp'

files {
    'html/js/jquery.js',
    'html/js/chart.js',
    'html/js/chartjs-annotation.js',
    'html/js/html2canvas.js',
    'html/blank.html',
    'html/index.html',
}
--
-- Server
--

server_scripts {
    'config.lua',
    'config_server.lua',
    'locale.lua',
    'server/server.lua',
    'server/editable/editable.lua',
}

--
-- Client
--

client_scripts {
    'config.lua',
    'locale.lua',
    'client/editable/api.lua',
    'client/functions.lua',
    'client/cache.lua',
    'client/client.lua',
    'client/spawning.lua',
    'client/display.lua',
    'client/editable/client.lua',
    'client/editable/esx.lua',
    'client/editable/qb.lua',
}

escrow_ignore {
    'config.lua',
    'config_server.lua',
    'locale.lua',
    'client/editable/*.lua',
    'server/editable/*.lua',
}

dependency '/assetpacks'
