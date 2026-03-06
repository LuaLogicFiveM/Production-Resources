Config.JobVehicles = {
    {
        model = "police",
        label = "Police Car",
        price = 10000,
        type = "car",
        requiredGrade = { 3, 4 }, -- the grade required to buy the vehicle
        disableInMenu = false,  -- If true, the vehicle will not be shown in the vehicle shop menu unless the player's grade is included in the requiredGrade list.
        AuthorizedJobs = { "police" }
    },
    {
        model = "police2",
        label = "Police Car 2",
        price = 1000,
        type = "car",
        requiredGrade = { 3 },
        disableInMenu = false,
        AuthorizedJobs = { "police" }
    },
    {
        model = "police3",
        label = "Police Car 3",
        price = 10000,
        type = "car",
        requiredGrade = { 2,3,4 },
        disableInMenu = false,
        AuthorizedJobs = { "police" }
    },
    {
        model = "fbi2",
        label = "FIB SUV",
        price = 15000,
        type = "car",
        requiredGrade = { 2,3,4 },
        disableInMenu = false,
        AuthorizedJobs = { "police" }
    },
    {
        model = "policeb",
        label = "Police Bike",
        price = 8000,
        type = "car",
        requiredGrade = { 2,3,4 },
        disableInMenu = false,
        AuthorizedJobs = { "police" }
    },
    {
        model = "sheriff2",
        label = "Sheriff SUV",
        price = 30000,
        type = "car",
        requiredGrade = { 2,3,4 },
        disableInMenu = false,
        AuthorizedJobs = { "police" }
    },
    {
        model = "policet",
        label = "Police Transporter",
        price = 12000,
        type = "car",
        requiredGrade = { 2,3,4 },
        disableInMenu = false,
        AuthorizedJobs = { "police" }
    },
    {
        model = "riot",
        label = "Police Riot",
        price = 12000,
        type = "car",
        requiredGrade = { 2,3,4 },
        disableInMenu = false,
        AuthorizedJobs = { "police" }
    },
    {
        model = "pranger",
        label = "Park Ranger",
        price = 12000,
        type = "car",
        requiredGrade = { 2,3,4 },
        disableInMenu = false,
        AuthorizedJobs = { "police" }
    },
    {
        model = "ambulance",
        label = "Ambulance",
        price = 5000,
        type = "car",
        requiredGrade = { 3 },
        disableInMenu = false,
        AuthorizedJobs = { "ambulance" }
    }
}
