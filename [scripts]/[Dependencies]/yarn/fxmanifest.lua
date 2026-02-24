shared_script "@ReaperV4/imports/bypass.js"
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.
version '1.0.0'
author 'Cfx.re <root@cfx.re>'
description 'Builds resources with yarn. To learn more: https://classic.yarnpkg.com'
repository 'https://github.com/citizenfx/cfx-server-data'
fx_version 'adamant'
game 'common'
server_script 'yarn_builder.js'
