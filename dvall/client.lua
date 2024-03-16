RegisterNetEvent('fd-framework:dvall:trigger')
AddEventHandler('fd-framework:dvall:trigger', function()
    local deletedVehicles = 0
    local allVehicles = GetAllVehicles()
    
    for key, value in pairs(allVehicles) do
        SetEntityAsMissionEntity(value, true, true)
        DeleteVehicle(value)
        deletedVehicles = deletedVehicles + 1
    end

    Notify(source, "DV Complete", "You can now spawn in your vehicles", "success", "client")
end)