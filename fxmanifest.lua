-- Generated automaticly by RB Generator.
fx_version('cerulean')
games({ 'gta5' })

shared_script({
    'server_config.lua',
    'client_config.lua',
    'shared_functions.lua'
});

server_scripts({
    'server.lua',
    './**/server/**.lua'
});

client_scripts({
    'client.lua',
    './**/client/**.lua'
});