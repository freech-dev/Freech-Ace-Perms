# Freech Framework

Freech framework is a discord link script that manages the link between your FiveM and Discord server.

Feel free to addd anything to this script in tems of exports ect. Just hmu if you have any questions @freech_dev

# Freech's Development 

Join this discord for any support questions 

[![Developer Discord](https://discordapp.com/api/guilds/937762007401254981/widget.png?style=banner2)]([https://discord.com/invite/WjB5VFz](https://discord.gg/xfp9xCJNKV))

### Configuration

##### BotToken - This should be your bot token of the bot that will do the requests (NOTE: Must be in the server that you are requesting from)

##### Guild - This is the guild id that you want to fetch the roles form (NOTE: The bot must be in the guild and the roles should only be in that guild)

##### Roles - These follow the format of ```{"ROLEID", "group.permission"},``` and should allways follow that format

This is a example server_config.lua file

```lua
Config = {}

Config.permissions = {
    BotToken = "MTE0MAzODU5MjA4MAGVtTp38iC6ITcCjkzDJBKtrYeiTbAG8iIM",
    Guild = "937762007401254981",
    Roles = {
        {"937780365861478420", "group.firstperm"},
        {"937780365861478420", "group.secondperm"}
    }
}
```

### Developer Guide 

#### Exports

| Export Name  | Export Use | Export Parameters  | 
| ------------- | ------------- | ------------- |
| ```LoadPermissions```  | Reload a users permissions and ace permissions  | User  |
| ```CheckPermissions```  | Checks if user has a role or not and returns true or calse  | User, Role ID  |
| ```GetUserInfo```  | Retreive a users roles  | User  |
| ```GetUserID```  | Retreive a users discord id  | User  |


