fx_version 'adamant'

game 'gta5'

version '1.0.0'

client_scripts {
	'client/main.lua',
	'config.lua'
 }
 
 server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
	'config.lua'
 }