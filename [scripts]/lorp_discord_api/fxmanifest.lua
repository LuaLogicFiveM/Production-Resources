shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua'
}

client_script 'client/*.lua'

server_script "server/*.lua"

file 'background.png'

server_exports {
	'GetDiscordAvatar',
	'RemoveRole',
	'AddRole',
	'GetUserRoles',
	'GetGuildRoleList',
	'GetGuildName',
	'GetGuildMemberCount',
	'GetGuildOnlineMemberCount',
	'GetDiscordName',
	'ClearCaches',
	'GetIdentifier',
	'FetchRoleID'
}
