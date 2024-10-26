fx_version 'bodacious'
games { 'rdr3', 'gta5' }
version '1.0.0'

description 'ABT Spawn Vehicle, Modern UI and Awesome Performance'
author 'ABT Resources | https://discord.gg/TAp46jSK5F'

client_script 'client.lua'

ui_page('ui/index.html')

files {
    'ui/index.html',
    'ui/index.css',
    'ui/fonts/*.ttf'
}

lua54 'yes'
