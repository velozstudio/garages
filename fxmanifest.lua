fx_version 'cerulean'
game 'gta5'

author 'velozstudio.com'
version '0.1.1'

lua54 'yes'

shared_scripts {
    'configs/config.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/functions.lua',
    'server/main.lua',
    'server/modules/*.lua'
}

client_scripts {
    'client/main.lua',
    'client/functions.lua',
    'client/threads.lua',
    'client/modules/*.lua',
}

files {
    'dist/index.html',
    'dist/assets/*.js',
    'dist/assets/*.css',
}

ui_page 'dist/index.html'
