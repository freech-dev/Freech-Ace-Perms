function Notify(recipient, title, message, type, side)
    if type == "server" then 
        if Config.NotifyType == 1 then 
            TriggerClientEvent('okokNotify:Alert', recipient, title, message, 4500, type, true)
        elseif Config.NotifyType == 2 then 
            TriggerClientEvent ('codem-notification:Create', recipient, message, type, title, 4500)
        elseif Config.NotifyType == 3 then 
            TriggerClientEvent('mythic_notify:client:SendAlert', recipient, { type = 'inform', text = message, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })

        end 
    elseif type == "client" then 
        if Config.NotifyType == 1 then
            exports['okokNotify']:Alert(title, message, 4500, type)
        elseif Config.NotifyType == 3 then 
            exports['mythic_notify']:DoHudText(type, title)
        end 
    end
end

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end
    return identifiers
end