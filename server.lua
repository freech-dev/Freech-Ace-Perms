local PlayersPerms = {}
local PlayerRoles = {}
local ApiCalls = 0
local RateLimited = false

-------------------
--   COMMANDS    --
-------------------

RegisterCommand('refreshperms', function(source, args, rawCommand)
    if Config.DebugMode then print('[Freech Framework] Refresh Perms Called') end
    if PlayersPerms[source] then
        for i = 1, #PlayersPerms[source] do
            ExecuteCommand("remove_principal identifier.discord:" .. GetUserID(source) .. " " .. PlayersPerms[source][i])
            if Config.DebugMode then print("[Freech Framework] Removed Permission " .. PlayersPerms[source][i] .. " for " .. GetUserID(source)) end
        end

        PlayersPerms[source] = nil
    end
    LoadPermissions(source)
    TriggerClientEvent('chat:addMessage', source, "[Freech Framework] Your permissions have been refreshed.")
    if Config.DebugMode then print("[Freech Framework] Permissions refreshed for " .. GetUserID(source)) end
end, false)

-------------------
-- SERVER EVENTS --
-------------------

AddEventHandler('playerConnecting', function(name, setKickReason)
    if Config.DebugMode then print('[Freech Framework] Player Connecting Called') end
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
        DropPlayer(src, "[Freech Framework] Discord identifier not found please relog")
        CancelEvent()
        if Config.DebugMode then print("[Freech Framework] Kicked Player " .. name .. " ID: " .. src .. " for no discord identifier") end
    else
        LoadPermissions(src)
        if Config.DebugMode then print("[Freech Framework] Permissions Loaded for " .. name .. " ID: " .. src) end
    end
end)

AddEventHandler('playerDropped', function(reason)
    if Config.DebugMode then print('[Freech Framework] Player Dropped Called') end
    if PlayersPerms[source] then
        for i = 1, #PlayersPerms[source] do
            ExecuteCommand("remove_principal identifier.discord:" .. GetUserID(source) .. " " .. PlayersPerms[source][i])
            if Config.DebugMode then print("[Freech Framework] Removed Permission " .. PlayersPerms[source][i] .. " for " .. GetUserID(source)) end
        end
        PlayersPerms[source] = nil
        if Config.DebugMode then print("[Freech Framework] Removed all permissions for " .. GetUserID(source)) end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(1000)
        if ApiCalls > 48 then 
            print('[Freech Framework] Discord ratelimited, Stalling joins for 20 seconds')
            RateLimited = true 
            Wait(2000)
            ApiCalls = 0
            RateLimited = false
        else 
            ApiCalls = 0
            RateLimited = false
        end
    end
end)

---------------
-- FUNCTIONS -- 
---------------

function Request(userid, callback)
    if RateLimited then 
        print("[Freech Framework] Ratelimit hit denying API Call")
        return 
    end 
    ApiCalls = ApiCalls + 1
    if Config.DebugMode then print("[Freech Framework] Making API Call " .. userid) end    local url = 'https://discordapp.com/api/guilds/' .. Config.permissions.Guild .. '/members/' .. userid
    local headers = {
        ['Content-Type'] = 'application/json',
        ['Authorization'] = 'Bot ' .. Config.permissions.BotToken
    }
    PerformHttpRequest(url, function(errorCode, resultData, resultHeaders)
        if errorCode ~= 429 then 
            callback(errorCode, resultData, resultHeaders)
        end
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
            discordLogs(message)
        end
    end)
end

function CheckPermissions(source, role)
    if PlayerRoles[source] then 
        for i = 1, #PlayerRoles[source] do
            if string.match(PlayerRoles[source][i], role) then
                return true
            end
        end
    end
    return false
end

function discordLogs(message)

end

-- This is only credit part so please do not remove it :)
print("[Freech Framework] Freech Framework, Make by freech_dev")
