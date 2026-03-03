shared_script "@ReaperV4/imports/bypass.js"
shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'

author 'cosney'
version '1.0.7'

server_scripts {
    'websocket/*.js',
    'http/main.lua',
    'structures/Channel.lua',
    'structures/Message.lua',
    'structures/components/Button.lua',
    'structures/components/SelectMenu.lua',
    'structures/components/ActionRow.lua',
    'structures/components/TextInput.lua',
    'structures/components/ModalBuilder.lua',
    'structures/Interaction.lua',
    'structures/Embed.lua',
    'structures/VoiceState.lua',
    'client/*.lua',
    'events/*.lua',
    'utils/helpers.lua',
    'utils/version.lua',
    'init.lua',

    -- examples
    'resource/*.lua',
}

server_only 'yes'
lua54 'yes'

use_experimental_fxv2_oal 'yes'
