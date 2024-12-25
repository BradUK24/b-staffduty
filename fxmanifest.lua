fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'b-Scripts'
description 'Staff Mode Script'
version '1.0.0'

server_scripts {    
    'server/*.lua',
}

client_scripts { 
    'client/*.lua',
}

shared_scripts {
    'config/config.lua',
}

dependencies {
    'qb-core' 
}


escrow_ignore {
    'config/*.lua'
}
