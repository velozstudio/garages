RegisterNetEvent('veloz:garages:server:openGarage', function()
    local playerId = source

    for _, vehicle in ipairs(GetAllOwnedVehicles(playerId)) do
        if vehicle.state == 0 then
            local testPlate = vehicle.plate:gsub("%s+", ""):upper()

            if not IsVehicleOnStreet(testPlate) then
                if next(GetVehicleByPlate(vehicle.plate)) then
                    ImpoundVehicle(vehicle.plate, 2, Config.DefaultImpound)
                end
            end
        end
    end

    TriggerClientEvent('veloz:garages:client:openGarage', playerId, GetAllOwnedVehicles(playerId))
end)


RegisterNetEvent('veloz:garages:server:createVehicle', function(vehicleData, garage)
    local playerId = source
    local vehicle = CreateVehicle_2(vehicleData.vehicle.model, garage.actions.spawnVehicle.coords)

    UpdateVehicleState(vehicleData.plate, 0)

    TriggerClientEvent('veloz:garages:client:applyVehicleProperties', playerId, vehicle, vehicleData.vehicle)
end)


RegisterNetEvent('veloz:garages:server:impoundVehicle', function(plate, garageId)
    if next(GetVehicleByPlate(plate)) then ImpoundVehicle(plate, 2, garageId) end
end)


RegisterNetEvent('veloz:garages:server:returnVehicle', function(vehicleData, garage, vehicle)
    local playerId = source

    if not IsVehicleOwnedByPlayer(playerId, vehicleData.plate) then
        return Notify(playerId, 'You are not the owner of this vehicle!', 'error')
    end

    UpdateVehicle(vehicleData.plate, 1, garage.id, vehicleData.properties)

    DeleteEntity(NetworkGetEntityFromNetworkId(vehicle))
end)


RegisterNetEvent('veloz:garages:server:transferVehicle', function(vehicle, garage)
    local playerId = source
    local account, amount = 'bank', 1000

    if not CheckSufficientFunds(playerId, account, amount) then
        return Notify(playerId, 'Insufficient funds!', 'error')
    end

    RemoveAccountMoney(playerId, account, amount)
    UpdateVehicleGarageId(vehicle.plate, garage.id)

    Notify(playerId, ('Vehicle has been transfered to %s!'):format(garage.label), 'success')

    TriggerClientEvent('veloz:garages:client:openGarage', playerId, GetAllOwnedVehicles(playerId))
end)
