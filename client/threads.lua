CreateThread(function()
    for _, garage in pairs(Config.Garages) do
        local sprite = garage.blip and garage.blip.id or 267
        local coords = garage.blip and garage.blip.coords or garage.actions.openGarage.coords
        local scale  = garage.blip and garage.blip.scale or 0.7
        local colour = garage.blip and garage.blip.colour or 26

        local blip   = AddBlipForCoord(coords.x, coords.y, coords.z)

        SetBlipSprite(blip, sprite)
        SetBlipScale(blip, scale)
        SetBlipColour(blip, colour)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(garage.label)
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    local skipAction = true

    while true do
        local player <const> = PlayerPedId()

        local garage, action = GetClosestGarage(player)
        local vehicle = GetVehiclePedIsUsing(player)

        if action == "returnVehicle" and not IsPedInAnyVehicle(player, false) and GetPedInVehicleSeat(vehicle, -1) then
            skipAction = true
        elseif action == "openGarage" and IsPedInAnyVehicle(player, false) then
            skipAction = true
        else
            skipAction = false
        end

        if not garage or not garage.actions[action].marker or skipAction then
            Wait(100)
        else
            DrawMarker_3(garage.actions[action].coords)
            Wait(5)
        end
    end
end)
