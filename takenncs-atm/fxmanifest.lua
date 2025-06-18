fx_version 'cerulean'
game 'gta5'

description 'ATM Robbery (ox_target, ox_lib, ox_inventory, qb-core)'
author 'takenncs Discord: uuuuuuuuuuu99998888888'
version '1.0.0'

dependencies {
    'qb-core',
    'ox_inventory',
    'ox_target',
    'ox_lib'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua' 
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

lua54 'yes'
