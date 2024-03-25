-- Generated automaticly by RB Generator.
fx_version('cerulean')
games({ 'gta5' })

server_scripts({
    'server.lua',
    'config.lua',
});

client_scripts({
    'client.lua',
});

server_exports ({
    'LoadPermissions',
    'CheckPermissions',
    'GetUserInfo',
    'GetUserID',
});
