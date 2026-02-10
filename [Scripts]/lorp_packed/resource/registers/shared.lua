return {
    debug = false,
    commission = true,
    distance = 10.0, -- distance to get nearby players to bill
    jobs = {
        greasy = {
            percent = 0.50, -- commission per charge if EnableCommission = true
            distance = 1.0, -- target distance
            radius = 1.0, -- sphere radius
            locations = {
                vec3(-308.90737915039, -1468.6125488281, 30.914529800415),
                vec3(-308.90737915039, -1470.5406494141, 30.914529800415),
            },
        },
        rexs = {
            percent = 0.50, -- commission per charge if EnableCommission = true
            distance = 1.0, -- target distance
            radius = 1.0, -- sphere radius
            locations = {
                vec3(2536.8227539062, 2587.0207519531, 38.820037841797),
            },
        },
        pizza_pier = { -- Postal: 687
            percent = 0.50, -- commission per charge if EnableCommission = true
            distance = 1.5, -- target distance
            radius = 1.0, -- sphere radius
            locations = {
                vec3(-1523.2833, -906.7167, 10.2018),
            },
        },
    }
}