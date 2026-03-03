-- ▄▀▀ █▄█ ▄▀▄ █   █ █▀▄ ▄▀▄ ▄▀▄ █▄ ▄█
-- ▄██ █ █ ▀▄▀ ▀▄▀▄▀ █▀▄ ▀▄▀ ▀▄▀ █ ▀ █

Config.RandomAnimsShowroom = {
    {"rcmnigel1a", "base"},
    {"rcmjosh1", "idle"},
    {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop"},
    {"random@street_race", "_car_b_lookout"},
    {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a"}
}

Config.VehiclesCustomMaxSpeed = {
    -- ['adder'] = 250,
}

Config.VehiclesCustomInfos = {
    ['trunk'] = { -- class name
        icon = 'trunk.png', -- icon (vms_vehicleshopv2/html/icons/)

        name = 'Trunk:',
        value = '{0}kg',

        ---@param default number or nil
        default = nil,

        byModel = {
            ['dubsta3'] = 230,
        },
        byCategory = {
            ['luxury'] = 328,
            ['sports'] = 248,
            ['super'] = 168,
            ['commercial'] = 488,
            ['trucks'] = 408,
            ['motorcycle'] = 40,
            ['coupe'] = 248,
            ['drift'] = 10,
            ['sedans'] = 328,
            ['compact'] = 168,
            ['suv'] = 408,
        },
    }
}