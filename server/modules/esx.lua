ESX = exports["es_extended"]:getSharedObject()


---@param playerId number
---@return table
GetAllOwnedVehicles = function(playerId)
    local player = ESX.GetPlayerFromId(playerId)

    local vehicles = MySQL.query.await(
        'SELECT plate, owner, type, state, garageId, vehicle FROM owned_vehicles WHERE owner = ?', {
            player.identifier
        }
    )

    for index, vehicle in ipairs(vehicles) do
        vehicles[index].vehicle = json.decode(vehicle.vehicle)
    end

    return vehicles
end


---@param plate string
---@return table
GetVehicleByPlate = function(plate)
    local res = MySQL.query.await(
        'SELECT plate, owner, type, state, garageId, vehicle FROM owned_vehicles WHERE plate = ?', {
            plate
        }
    )

    local vehicle = res[1]

    vehicle.vehicle = json.decode(vehicle.vehicle)

    return vehicle
end


---@param playerId number
---@param plate string
---@return boolean
IsVehicleOwnedByPlayer = function(playerId, plate)
    local player = ESX.GetPlayerFromId(playerId)

    local result = MySQL.query.await('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', {
        player.identifier, plate
    })

    return next(result) ~= nil
end


---@param plate string
---@param state number
---@param garageId string
---@param vehicle table
UpdateVehicle = function(plate, state, garageId, vehicle)
    MySQL.update.await(
        'UPDATE owned_vehicles SET state = ?, garageId = ?, vehicle = ? WHERE plate = ?', {
            state, garageId, json.encode(vehicle), plate
        }
    )
end


---@param plate string
---@param state number
UpdateVehicleState = function(plate, state)
    MySQL.update.await(
        'UPDATE owned_vehicles SET state = ? WHERE plate = ?', {
            state, plate
        }
    )
end


---@param plate string
---@param garageId string
UpdateVehicleGarageId = function(plate, garageId)
    MySQL.update.await(
        'UPDATE owned_vehicles SET garageId = ? WHERE plate = ?', {
            garageId, plate
        }
    )
end


---@param plate string
---@param state number
---@param garageId string
ImpoundVehicle = function(plate, state, garageId)
    UpdateVehicleState(plate, state)
    UpdateVehicleGarageId(plate, garageId)
end


---@param playerId number
---@param account string
---@param amount number
---@return boolean
CheckSufficientFunds = function(playerId, account, amount)
    local player = ESX.GetPlayerFromId(playerId)

    if player.getAccount(account).money >= amount then
        return true
    end

    return false
end


---@param playerId number
---@param account string
---@param amount number
RemoveAccountMoney = function(playerId, account, amount)
    local player = ESX.GetPlayerFromId(playerId)
    player.removeAccountMoney(account, amount)
end
