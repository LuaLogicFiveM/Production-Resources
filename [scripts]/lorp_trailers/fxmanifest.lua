shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version "adamant"
lua54 'yes'
game "gta5"
version '1.0.8'
files {
    'locales/*.json'
}
shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/utils.lua'
}
client_scripts {
    'client/**.lua'
}
dependency 'ox_lib'
escrow_ignore {
    'shared/config.lua',
    'client/edit.lua',
    'locales/*.json',
}
dependency '/assetpacks'
