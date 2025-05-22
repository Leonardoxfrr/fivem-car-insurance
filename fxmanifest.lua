fx_version 'cerulean'
game 'gta5'

author 'Leonardoxfrr'
description 'Car Insurance System for FiveM (serverside, ESX)'
version '1.0.0'

server_script 'config.lua'
server_script 'server.lua'
shared_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@es_extended/imports.lua'
}