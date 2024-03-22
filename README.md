# Freech Framework

Freech framework is a discord link script that manages the link between your FiveM and Discord server.

Feel free to addd anything to this script in tems of exports ect. Just hmu if you have any questions @freech_dev

#### Configuration

BotToken - This should be your bot token of the bot that will do the requests (NOTE: Must be in the server that you are requesting from)

Guild - This is the guild id that you want to fetch the roles form (NOTE: The bot must be in the guild and the roles should only be in that guild)

Roles - These follow the format of ```lua{"ROLEID", group.permission},``` and should allways follow that format

This is a example server_config.lua file

```lua
Config = {}

Config.permissions = {
    BotToken = "MTE0MAzODU5MjA4MA.GVtTp38iC6ITcCjkzDJBKtrYeiTbAG8iIM",
    Guild = "937762007401254981",
    Roles = {
        {"937780365861478420", group.firstperm},
        {"937780365861478420", group.secondperm}
    }
}
