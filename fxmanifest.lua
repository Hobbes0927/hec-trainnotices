game 'rdr3'
fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'
author 'Hobbes0927'
description 'Script to post train notifications'


shared_script 'config.lua'

client_scripts {
	'client/client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/server.lua',
}