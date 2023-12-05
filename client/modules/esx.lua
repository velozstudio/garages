ESX = exports["es_extended"]:getSharedObject()

---@param vehicle number
---@param properties table
SetVehicleProperties = function(vehicle, properties)
    ESX.Game.SetVehicleProperties(vehicle, properties)
end

---@param vehicle number
---@return table
GetVehicleProperties = function(vehicle)
    return ESX.Game.GetVehicleProperties(vehicle)
end
