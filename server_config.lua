Config = {}

-- Type 0: Chat Message 
-- Type 1: okokNotify
-- Type 2: venice notify
-- Type 3: mythicNotify
Config.NotifyType = "1"

Config.permissions = {
    BotToken = "BOTTOKEN",
    Guild = "GUILDID",
    Roles = {
        {"ROLEID", group.permission},
    }
}