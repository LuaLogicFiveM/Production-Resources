fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'rytrak.fr'

escrow_ignore {
	'config.lua',
	'client/cl_utils.lua',
	'client/cl_exports.lua',
	'client/ox_target.lua',
	'client/qb_target.lua'
}

server_scripts {
    'config.lua',
    'server/server.lua'
}

client_scripts {
	'config.lua',
	'client/client.lua',
	'client/cl_utils.lua',
	'client/cl_exports.lua',
	'client/ox_target.lua',
	'client/qb_target.lua'
}
dependency '/assetpacks'