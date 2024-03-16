RegisterCommand('dv', function(source, args, rawCommand)
local player = PlayerPedId(-1)

    if IsPedInAnyVehicle(player, false) then
        local vehicle = GetVehiclePedIsIn(player, false)
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
        Notify(source, "Vehicle Deleted", "Your vehicle has been deleted", "client")
    else 
        Notify(source, "Error", "You are not in a vehicle", "client")
    end

end, false)