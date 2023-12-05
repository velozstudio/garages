RegisterNUICallback('unimpoundVehicle', function(data, cb)
    TriggerServerEvent('veloz:garages:server:createVehicle', data.vehicle, data.garage)
    TriggerServerEvent('veloz:garages:server:impoundVehicle', data.vehicle.plate, Config.Garages[1].id)
    CloseGarage()
    cb(1)
end)

RegisterCommand('garage', function()
    local playerPed = PlayerPedId()
    local garage, action = GetClosestGarage(playerPed)

    if not garage then
        return
    end

    if action == "openGarage" and not IsPedInAnyVehicle(playerPed, false) then
        TriggerServerEvent('veloz:garages:server:openGarage', Config.Garages)
    end

    if action == "returnVehicle" and IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsUsing(playerPed)
        local vehicleData = {}

        if not vehicle then
            return
        end

        vehicleData["plate"] = GetVehicleNumberPlateText(vehicle)
        vehicleData["properties"] = GetVehicleProperties(vehicle)

        TriggerServerEvent('veloz:garages:server:returnVehicle', vehicleData, garage, VehToNet(vehicle))
    end
end, false)

RegisterKeyMapping('garage', 'Open Garage', 'keyboard', 'E')

RegisterNetEvent('veloz:garages:client:openGarage', function(vehicles)
    local garage = GetClosestGarage(PlayerPedId())

    if not garage then return end

    for _, vehicle in ipairs(vehicles) do
        vehicle.name = GetVehicleName(vehicle.vehicle.model)

        if not DoesGarageExist(vehicle.garageId) or vehicle.garageId == nil then
            if vehicle.type == "car" then
                vehicle.garageId = Config.Garages[1].id
            end
        end
    end

    OpenGarage(garage, vehicles)
end)

RegisterNetEvent('veloz:garages:client:applyVehicleProperties', function(vehicle, properties)
    vehicle = NetToVeh(vehicle)

    SetEntityAsMissionEntity(vehicle, false, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

    SetVehicleProperties(vehicle, properties)
end)

RegisterNUICallback('closeGarageDisplay', function(_, cb)
    CloseGarage()
    cb(200)
end)

RegisterNUICallback('selectVehicle', function(data, cb)
    TriggerServerEvent('veloz:garages:server:createVehicle', data.vehicle, data.garage)
    CloseGarage()
    cb(200)
end)

RegisterNUICallback('transferVehicle', function(data, cb)
    TriggerServerEvent('veloz:garages:server:transferVehicle', data.vehicle, data.garage)
    cb(200)
end)

RegisterNUICallback('pinImpound', function(data, cb)
    SetWaypointToGarage(data.garage)
    CloseGarage()
    cb(200)
end)

