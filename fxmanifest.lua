fx_version 'adamant'

game 'gta5'

version '1.0.2'
lua54 'yes'

client_scripts {
	'config.lua',
	'client/main.lua',
 }
 
 server_scripts {
	'config.lua',
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
 }

 shared_script '@ox_lib/init.lua'
 shared_script '@es_extended/imports.lua'