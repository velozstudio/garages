---@param testPlate string
---@return boolean
IsVehicleOnStreet = function(testPlate)
    ---@diagnostic disable-next-line: param-type-mismatch
    for _, vehicle in ipairs(GetAllVehicles()) do
        if DoesEntityExist(vehicle) then
            local vehiclePlate = GetVehicleNumberPlateText(vehicle):gsub("%s+", ""):upper()
            if testPlate == vehiclePlate then return true end
        end
    end

    return false
end


---@param model number
---@param coords vector4
---@return number
CreateVehicle_2 = function(model, coords)
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, true, true)

    repeat Wait(100) until DoesEntityExist(vehicle)
    repeat Wait(100) until NetworkGetEntityOwner(vehicle) ~= source

    return NetworkGetNetworkIdFromEntity(vehicle)
end


---@param playerId number
---@param message string | number
---@param messageType 'info' | 'success' |'error'
Notify = function(playerId, message, messageType)
    TriggerClientEvent('esx:showNotification', playerId, message, messageType)
end
