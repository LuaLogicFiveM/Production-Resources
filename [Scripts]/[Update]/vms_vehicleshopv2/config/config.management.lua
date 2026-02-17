-- █▄ ▄█ ▄▀▄ █▄ █ ▄▀▄ ▄▀  ██▀ █▄ ▄█ ██▀ █▄ █ ▀█▀
-- █ ▀ █ █▀█ █ ▀█ █▀█ ▀▄█ █▄▄ █ ▀ █ █▄▄ █ ▀█  █ 

---@field UseBuildInCompanyBalance boolean: If you don't want to use the balance built into the Management Menu, set this to false and configure config.server.lua to be compatible with your server, for example a script for banks that may have company accounts
Config.UseBuildInCompanyBalance = true
Config.RemoveBalanceFromMenu = false -- if you are using other than our prepared esx_society or buildet-in balance, set it true

Config.ESXSocietyEvents = {
    ['check'] = 'esx_society:checkSocietyBalance',
    ['withdraw'] = 'esx_society:withdrawMoney',
    ['deposit'] = 'esx_society:depositMoney',
}


---@field MaxVehiclesInStock number: The maximum number of vehicles each dealership can have.
Config.MaxVehiclesInStock = 50

---@field MoneyToStorePercent number: The percentage of the given amount on the invoice that the dealership is to receive for selling the vehicle to another player.
Config.MoneyToStorePercent = 90

---@field MoneyToSellerPercent number: The percentage of the given amount on the invoice that the employee who makes the sale of the vehicle to another player is to receive.
Config.MoneyToSellerPercent = 10

---@field DeliveryRewardPercent number: The percentage of the total 'orderprice' amount that the player will receive for delivering the ordered vehicles to the dealership.
Config.DeliveryRewardPercent = 15

---@field RequiredJobToBeHired string: Do you want to prevent the employment of a player who has another job, if so, you can require the employment of only the person who has a job for example - unemployed
Config.RequiredJobToBeHired = 'unemployed'


---@field NoLimitTestDrive boolean: Option only for the TEST DRIVE option in the management menu, whether to be unlimited, if so, the player will be able to return the vehicle at the appropriate point
Config.NoLimitTestDrive = true

---@field AbilityEmployeesToCreateOrders boolean: Ability to authorize any employee to place an order otherwise only the manager and boss will be able to do so.
Config.AbilityEmployeesToCreateOrders = false

Config.Wholesales = {
    ['cars'] = {
        {
            truckModel = 'phantom3',
            trailerModel = 'tr2',
            pedModel = 's_m_m_autoshop_02',
            pedCoords = vector4(1212.7, -2952.96, 4.87, 171.02),
            trailerCoords = vector4(1216.37, -2946.91, 5.1, 181.38),
            vehiclesOnTrailer = {
                [1] = {0.0, -3.4, 1.1, 2.5, 0.0, 0.0},
                [2] = {0.0, 2.6, 1.1, -2.5, 0.0, 0.0},
                [3] = {0.0, -3.6, 3.35, 1.0, 0.0, 0.0},
                [4] = {0.0, 3.0, 2.9, 0.0, 0.0, 0.0},
            },
        },
        {
            truckModel = 'phantom3',
            trailerModel = 'tr2',
            pedModel = 's_m_m_autoshop_02',
            pedCoords = vector4(610.16, -3176.46, 5.07, 337.01),
            trailerCoords = vector4(614.07, -3186.12, 5.2, 359.24),
            vehiclesOnTrailer = {
                [1] = {0.0, -3.4, 1.1, 2.5, 0.0, 0.0},
                [2] = {0.0, 2.6, 1.1, -2.5, 0.0, 0.0},
                [3] = {0.0, -3.6, 3.35, 1.0, 0.0, 0.0},
                [4] = {0.0, 3.0, 2.9, 0.0, 0.0, 0.0},
            },
        },
        {
            truckModel = 'phantom3',
            trailerModel = 'tr2',
            pedModel = 's_m_m_autoshop_02',
            pedCoords = vector4(-153.94, -2682.66, 5.01, 351.09),
            trailerCoords = vector4(-149.87, -2688.89, 5.21, 1.21),
            vehiclesOnTrailer = {
                [1] = {0.0, -3.4, 1.1, 2.5, 0.0, 0.0},
                [2] = {0.0, 2.6, 1.1, -2.5, 0.0, 0.0},
                [3] = {0.0, -3.6, 3.35, 1.0, 0.0, 0.0},
                [4] = {0.0, 3.0, 2.9, 0.0, 0.0, 0.0},
            },
        },
    },
    ['boats'] = {
        {
            truckModel = 'sadler',
            trailerModel = 'boattrailer',
            pedModel = 's_m_m_autoshop_02',
            pedCoords = vector4(-502.04, -2786.0, 5.0, 17.99),
            trailerCoords = vector4(-495.61, -2787.29, 5.2, 45.1),
            vehiclesOnTrailer = {
                [1] = {0.0, -1.2, 0.3, 0.0, 0.0, 0.0},
            },
        },
    },
    ['planes'] = {
        {
            truckModel = 'phantom3',
            trailerModel = 'trflat',
            pedModel = 's_m_m_autoshop_02',
            pedCoords = vector4(1414.96, 3023.49, 39.53, 294.93),
            trailerCoords = vector4(1414.26, 3010.7, 39.73, 313.92),
            vehiclesOnTrailer = {
                [1] = {0.0, -4.4, 0.4, 0.0, 0.0, 0.0},
            },
            zCoordDependsFromHeight = true,
        },

    },
}


--- ██╗   ██╗███╗   ███╗███████╗     ██████╗██╗████████╗██╗   ██╗██╗  ██╗ █████╗ ██╗     ██╗     
--- ██║   ██║████╗ ████║██╔════╝    ██╔════╝██║╚══██╔══╝╚██╗ ██╔╝██║  ██║██╔══██╗██║     ██║     
--- ██║   ██║██╔████╔██║███████╗    ██║     ██║   ██║    ╚████╔╝ ███████║███████║██║     ██║     
--- ╚██╗ ██╔╝██║╚██╔╝██║╚════██║    ██║     ██║   ██║     ╚██╔╝  ██╔══██║██╔══██║██║     ██║     
---  ╚████╔╝ ██║ ╚═╝ ██║███████║    ╚██████╗██║   ██║      ██║   ██║  ██║██║  ██║███████╗███████╗
---   ╚═══╝  ╚═╝     ╚═╝╚══════╝     ╚═════╝╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝
Config.VMSCityHallResource = 'vms_cityhall'
Config.UseVMSCityHall = GetResourceState(Config.VMSCityHallResource) == 'started'

---@field UseCityHallResumes boolean: If you are using vms_cityhall and using the job center section and want players to send resumes to companies, set true
Config.UseCityHallResumes = false

---@field UseCityHallTaxes boolean: If you are using vms_cityhall and you use the tax option and want companies to have to pay tax on the money they earn, set true
Config.UseCityHallTaxes = false

---@field UseCityHallIncludedTaxes boolean: If you use taxes, do you want the taxes to be included in the default amounts you configure in vms_barber, or do you want them to be price + tax paid by the customer
Config.UseCityHallIncludedTaxes = false

Config.CustomTaxes = {
    default = 'vehicles.mechanical',
    
    byModel = {
        ['buffalo5'] = 'vehicles.electric',
        ['cyclone'] = 'vehicles.electric',
        ['iwagen'] = 'vehicles.electric',
        ['coureur'] = 'vehicles.electric',
        ['neon'] = 'vehicles.electric',
        ['powersurge'] = 'vehicles.electric',
        ['raiden'] = 'vehicles.electric',
        ['surge'] = 'vehicles.electric',
        ['tezeract'] = 'vehicles.electric',
        ['virtue'] = 'vehicles.electric',
        ['voltic'] = 'vehicles.electric',
        ['khamelion'] = 'vehicles.electric',
    },

    byCategory = {
        ['bikes'] = 'vehicles.bikes'
    }
}