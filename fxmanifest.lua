fx_version 'cerulean'
game 'gta5'

author 'ML187' -- ORIGINAL DOJ 
description 'ML187 Fishing Script - Updated for Latest QBCore'
version '2.0.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/client.lua',
    'client/menus.lua',
    'client/targets.lua',
    'client/blips.lua'
}

server_scripts {
    'server/server.lua',
}

dependencies {
    'qb-core',
    'qb-target',
    'qb-menu',
    'qb-inventory',
    'ps-ui'
}

lua54 'yes'