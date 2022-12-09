fx_version 'adamant'

game 'gta5'

version '1.0.0'
lua54 'yes'

client_scripts {
	'client/main.lua',
	'config.lua'
 }
 
 server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
	'config.lua'
 }

 shared_script '@ox_lib/init.lua'