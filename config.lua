Config = {}

Config.DebugMode = true -- true/false will log debug messages to console 

Config.Discord = {
    DiscordLogging = true, -- true/false will log a users permissions group to a discord webhook 
    Webhook = "WEBHOOK"
}

Config.permissions = {
    BotToken = "BOTTOKEN",
    Guild = "GUILDID",
    Roles = {
        {"ROLEID", "group.firstperm"},
    }
}