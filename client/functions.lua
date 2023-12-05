---@param player number
---@return table|nil
---@return string|nil
GetClosestGarage = function(player)
    local playerCoords = GetEntityCoords(player)
    local garage, action = nil, nil

    for _, garageData in pairs(Config.Garages) do
        for actionType, actionData in pairs(garageData.actions) do
            local garageCoords = vector3(actionData.coords.x, actionData.coords.y, actionData.coords.z)
            local radius = #(garageCoords - playerCoords)

            if radius <= actionData.radius then
                garage = garageData
                action = actionType
            end
        end
    end

    if not garage then return end

    return garage, action
end

---@param garage table
---@param vehicles table
OpenGarage = function(garage, vehicles)
    SetNuiFocus(true, true)

    SendNUIMessage({
        action = 'setGarageDisplay',
        payload = {
            display = true
        }
    })

    SendNUIMessage({
        action = 'setGarageData',
        payload = {
            garages = Config.Garages,
            currentGarageId = garage.id,
            vehicles = vehicles
        }
    })
end

CloseGarage = function()
    SetNuiFocus(false, false)

    SendNUIMessage({
        action = 'setGarageDisplay',
        payload = {
            display = false
        }
    })
end

---@param modelHash number
---@return string
GetVehicleName = function(modelHash)
    local model = GetDisplayNameFromVehicleModel(modelHash)
    local brand = GetMakeNameFromVehicleModel(modelHash)

    if brand == "CARNOTFOUND" then
        return model
    end

    return string.format("%s %s", model, brand)
end

---@param garageId string
---@return boolean
function DoesGarageExist(garageId)
    for _, garage in ipairs(Config.Garages) do
        if garage.id == garageId then return true end
    end
    return false
end

---@param coords vector3
DrawMarker_3 = function(coords)
    ---@diagnostic disable: param-type-mismatch
    DrawMarker(2, coords.x, coords.y, coords.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 165, 180, 252,
        200, false, false, 2, true, nil, nil, false)
end

---@param garageId string
SetWaypointToGarage = function(garageId)
    for _, garage in ipairs(Config.Garages) do
        if garage.id == garageId then
            SetNewWaypoint(garage.actions.openGarage.coords.x, garage.actions.openGarage.coords.y)
            break
        end
    end
end
