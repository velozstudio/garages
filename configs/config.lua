Config = {}

Config.DefaultImpound = "LosSantos"

Config.Garages = {
    {
        id = "SanAndreasAvenue",
        type = "car",
        label = "Legion Square",
        actions = {
            openGarage = {
                coords = vector3(228.9265, -802.5964, 30.0),
                radius = 5.0,
                marker = true
            },
            spawnVehicle = {
                coords = vector4(232.8690, -773.7629, 30.3, 248.7981),
                radius = 5.0
            },
            returnVehicle = {
                coords = vector3(226.1971, -757.8257, 30.3),
                radius = 10.0,
                marker = true
            },
        },
    },
    {
        id = "VespucciBoulevard",
        type = "car",
        label = "Alta Tower Parking",
        actions = {
            openGarage = {
                coords = vector3(-268.8998, -981.7859, 31.2150),
                radius = 5.0,
                marker = true
            },
            spawnVehicle = {
                coords = vector4(-336.1331, -976.6906, 30.6680, 339.9115),
                radius = 5.0
            },
            returnVehicle = {
                coords = vector3(-252.7274, -1003.8022, 28.4725),
                radius = 10.0,
                marker = true
            },
        },
    },
    {
        impound = true,
        id = "LosSantos",
        type = "car",
        label = "Impound Davis",
        blip = { id = 811, scale = 1.0, colour = 64 },
        actions = {
            openGarage = {
                coords = vector3(359.8510, -1583.9498, 29.2919),
                radius = 5.0,
                marker = true
            },
            spawnVehicle = {
                coords = vector4(400.9053, -1648.5355, 28.8713, 320.3507),
                radius = 5.0
            },
        },
    },
    {
        impound = true,
        id = "PaletoBay",
        type = "car",
        label = "Impound Paleto Bay",
        blip = { id = 811, scale = 1.0, colour = 64 },
        actions = {
            openGarage = {
                coords = vector3(-211.4, 6206.5, 31.4),
                radius = 5.0,
                marker = true
            },
            spawnVehicle = {
                coords = vector4(-204.6, 6221.6, 30.5, 227.2),
                radius = 5.0
            },
        },
    },
    {
        impound = true,
        id = "SandyShores",
        type = "car",
        label = "Impound Sandy Shores",
        blip = { id = 811, scale = 1.0, colour = 64 },
        actions = {
            openGarage = {
                coords = vector3(1728.2, 3709.3, 33.2),
                radius = 5.0,
                marker = true
            },
            spawnVehicle = {
                coords = vector4(1722.7, 3713.6, 33.2, 19.9),
                radius = 5.0
            },
        },
    },
}
