-- ▄▀▀ ▀█▀ ▄▀▄ █▀▄ ██▀   █▄ ▄█ ▄▀▄ █▄ █ ▄▀▄ ▄▀  ██▀ █▄ ▄█ ██▀ █▄ █ ▀█▀
-- ▄██  █  ▀▄▀ █▀▄ █▄▄   █ ▀ █ █▀█ █ ▀█ █▀█ ▀▄█ █▄▄ █ ▀ █ █▄▄ █ ▀█  █ 

-- @AbilityChangeProductsPrices: 
Config.AbilityChangeProductsPrices = true

Config.CustomPricesRange = {
    ['fuel'] = {min = 5, max = 17}, -- The player will be able to set the price for a minimum of $5 and a maximum of $17
    ['pear'] = {min = 1, max = 10},
}

-- @AlarmPrice: Cost of buying the Alarm & Monitoring
Config.AlarmPrice = 100000


-- @MoneyEscortPrice: The cost of transporting money safely
Config.MoneyEscortPrice = 2500

-- @EscorterPed:
Config.EscorterPed = 's_m_y_marine_03'

-- @EscorderVehicle
Config.EscorderVehicle = 'stockade'


-- @Insurances: Costs and insurance times for stores
Config.Insurances = {
    [1] = {days = 7, price = 30000},
    [2] = {days = 30, price = 150000},
    [3] = {days = 90, price = 400000},
}


-- @TerminationTime: Times after which stores receive a warning and are removed for inactivity of employees
Config.TerminationTime = {
    ['critical'] = 168, -- After this time, the store will be removed for inactivity
    ['warning'] = 72 -- After this time, the player will receive information in the management menu after the remaining time to remove the store for inactivity
}

-- @TerminationExclusionProductsPercent: If a store has x% of products in stock, it will not be subject to Config.TerminationTime, it will be omitted from the liquidation time
Config.TerminationExclusionProductsPercent = 80

-- @TerminationExclusionFuelPercent: If a gasstation has x% of fuel in stock, it will not be subject to Config.TerminationTime, it will be omitted from the liquidation time
Config.TerminationExclusionFuelPercent = 70


-- @AutomaticSellPercentageFromPrice: For what % a player can sell his business
Config.AutomaticSellPercentageFromPrice = 40

-- @AbilityEmployeesToCreateOrders: Employee to be able to create new order to take care of business
Config.AbilityEmployeesToCreateOrders = false

-- @LevelsBenefits: What it will give to the store for the upgrade, here you can adjust the values that stores will be able to use at the concurrent upgrade level
Config.LevelsBenefits = {
    ['1'] = {
        orderProductsLimit = 2,
        itemsCapacity = 300,
        fuelCapacity = 2500,
        moneyMarginItems = 55,
        moneyMarginFuel = 55,
        quantityProducts = {15, 25, 50},
        quantityFuel = {30, 50, 150},
        levelup = {
            -- type: 'sell_products', 'sell_fuel', 'make_orders', 'required_money'
            ['sell_products'] = {type = 'sell_products', count = 5000},
            ['sell_fuel'] = {type = 'sell_fuel', count = 7500},
            ['make_orders'] = {type = 'make_orders', count = 120},
            ['required_money'] = {type = 'required_money', count = 50000},
        },
    },
    ['2'] = {
        orderProductsLimit = 2,
        itemsCapacity = 500,
        fuelCapacity = 4000,
        moneyMarginItems = 75,
        moneyMarginFuel = 75,
        quantityProducts = {15, 25, 50, 75},
        quantityFuel = {30, 50, 150, 220},
        levelup = {
            ['sell_products'] = {type = 'sell_products', count = 10000},
            ['sell_fuel'] = {type = 'sell_fuel', count = 17500},
            ['make_orders'] = {type = 'make_orders', count = 250},
            ['required_money'] = {type = 'required_money', count = 100000},
        },
    },
    ['3'] = {
        orderProductsLimit = 3,
        itemsCapacity = 750,
        fuelCapacity = 7500,
        moneyMarginItems = 90,
        moneyMarginFuel = 90,
        quantityProducts = {15, 25, 50, 75, 100},
        quantityFuel = {30, 50, 150, 220, 300},
    },
}

-- @ResellAddAgreementItems: If you want the opportunity to own the item of the sale of shares you should have an inventory with metadata.
Config.ResellAddAgreementItems = false -- AVAILABLE SOON
Config.AgreementItem = 'sale_shares_agreement' -- AVAILABLE SOON



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