fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name "mana_hunting"
description "Hunting Script made for ox_inventory. Fork of nfire_hunting"
author "Nfire"
version "1.2.0"

dependencies {
	'/server:5181',
	'/onesync',
	'ox_lib',
	'ox_inventory',
}

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

files {
    'locales/*.json'
}