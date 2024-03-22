local PlayersPerms = {}

-------------------
--   COMMANDS    --
-------------------

RegisterCommand('refreshperms', function(source, args, rawCommand)
    LoadPermissions(source)
end, false)

-------------------
-- SERVER EVENTS --
-------------------

AddEventHandler('playerConnecting', function(name, setKickReason)
    local src = source
    local identifiers = GetPlayerIdentifiers(src)
    local hasDiscord = false

    for i = 1, #identifiers do
        if string.find(identifiers[i], "discord") then
            hasDiscord = true
            break
        end
    end

    if not hasDiscord then
        setKickReason("[Freech Framework] Discord identifier not found please relog")
        CancelEvent()
    else
        LoadPermissions(src)
    end
end)

AddEventHandler('playerDropped', function(reason)
    if PlayersPerms[source] then
        for i = 1, #PlayersPerms[source] do
            ExecuteCommand("remove_principal identifier.discord:" .. GetUserID(source) .. " " .. PlayersPerms[source][i])
        end
        PlayersPerms[source] = nil
    end
end)

---------------
-- FUNCTIONS -- 
---------------

function Request(userid, callback)
    local url = 'https://discordapp.com/api/guilds/' .. Config.Guild .. '/members/' .. userid
    local headers = {
        ['Content-Type'] = 'application/json',
        ['Authorization'] = 'Bot ' .. Config.Bot_Token
    }
    PerformHttpRequest(url, function(errorCode, resultData, resultHeaders)
        callback(errorCode, resultData, resultHeaders)
    end, 'GET', '', headers)
end

function GetUserID(source)
    local userID = nil
    local identifiers = GetPlayerIdentifiers(source)

    for i = 1, #identifiers do
        local identifier = identifiers[i]

        if string.match(identifier, 'discord:') then
            userID = string.gsub(identifier, 'discord:', '')
            break
        end
    end

    return userID
end

function GetUserInfo(source, callback)
    local userID = GetUserID(source)

    if userID then
        Request(userID, function(errorCode, resultData, resultHeaders)
            if errorCode == 200 then
                local data = json.decode(resultData)
                callback(data.roles)
            else
                callback(nil)
            end
        end)
    else
        callback(nil)
    end
end

function LoadPermissions(source)
    GetUserInfo(source, function(userRoles)
        if userRoles then 
            PlayersPerms[source] = {}
            for i = 1, #userRoles do 
                for j = 1, #Config.permissions.Roles do
                    if string.match(userRoles[i], Config.permissions.Roles[j][1]) then
                        table.insert(PlayersPerms[source], Config.permissions.Roles[j][2])
                        ExecuteCommand("add_principal identifier.discord:" .. GetUserID(source) .. Config.permissions.Roles[j][2])
                        print("[Freech Framework] Permission Added " .. GetUserID(source) .. " to role group " .. Config.permissions.Roles[j][2]);
                    end
                end
            end 
        end
    end)
end

function GetRoleId(source, permission)
    if PlayersPerms[source] then
        for i = 1, #PlayersPerms[source] do
            for j = 1, #Config.permissions.Roles do
                if PlayersPerms[source][i] == Config.permissions.Roles[j][2] and Config.permissions.Roles[j][1] == permission then
                    return Config.permissions.Roles[j][1]
                end
            end
        end
    end
    return nil
end

function HasPermission(source, permission)
    local roleId = GetRoleId(source, permission)
    return roleId ~= nil
end


-- This is only credit part so please do not remove it
print("[Freech Framework] Freech Framework, Make by freech_dev")