fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name "splg_hunting"
description "Hunting Script made for ox_inventory. Fork of mana_hunting"
author "Spiderlogical"
version "1.0.0"

dependencies {
	'/server:5181',
	'/onesync',
	'ox_lib',
	'ox_target',
}

ui_page 'build/index.html'

shared_scripts {
	'@ox_lib/init.lua',
}

client_scripts {
	'@bl_bridge/imports/client.lua',
	'client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@bl_bridge/imports/server.lua',
	'server/*.lua'
}

files {
	'locales/*.json',
	'build/**',
	'config/*.lua',
}
