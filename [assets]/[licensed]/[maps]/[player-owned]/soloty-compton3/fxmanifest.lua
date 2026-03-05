shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
this_is_a_map 'yes'

author 'Soloty'
description 'Soloty Discord: https://discord.gg/5m3Xm32sB6'
version '1.0.0'

client_script 'client.lua'

escrow_ignore {
  'client.lua'
}

dependency '/assetpacks'
