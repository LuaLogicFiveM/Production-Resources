return {
    enabled = true,

    merchant = {
        model = 'a_m_m_farmer_01',

        coords = vec4(-1816.89, -1193.83, 13.3, 325.13),
        scenario = 'WORLD_HUMAN_CLIPBOARD',

        blip = {
            enabled = true,
            sprite = 68,
            display = 4,
            scale = 0.7,
            colour = 3,
            label = 'Fish Market'
        }
    },

    currency = 'money',

    stocks = {
        initial = 100,

        minimum = 0,
        maximum = 500,

        targetLevel = 250,

        recoveryRate = {
            min = 1,
            max = 3
        }
    },

    prices = {
        salesImpact = {
            divisor = 20,
            maxEffect = 0.7
        },

        salesRecovery = 3
    },

    updateInterval = 10,
}