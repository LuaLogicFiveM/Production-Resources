Config = {
    ReviveHealth = 100, -- Health to restore when reviving players
    ResetDelay = 1000,  -- Delay (in ms) before resetting players after a round
    ReviveTrigger = 'custom_revive:RevivePlayer', -- Trigger to revive players
    RoutingBuckets = {
        Default = 0, -- Default routing bucket
    },
    MatchTypes = {
        ["1v1"] = { requiredPlayers = 2 },
        ["2v2"] = { requiredPlayers = 4 },
        ["3v3"] = { requiredPlayers = 6 },
        ["4v4"] = { requiredPlayers = 8 },
        ["5v5"] = { requiredPlayers = 10 },
    },
    Weapons = {
        { label = 'AP Pistol', weapon = 'weapon_appistol' },
        { label = 'Combat Pistol', weapon = 'weapon_combatpistol' },
    },
    WinCondition = 5, -- First to 5 wins
    Ramps = {
        { -- Skate park
            DefaultSpawn = vec4(-953.8368, -781.0659, 15.9212, 228.8083),
            Team1 = {
                vec4(-951.2786, -801.1290, 14.9210, 318.3400), -- Position for Team 1, Player 1 (x, y, z, heading)
                vec4(-946.6920, -804.1945, 14.9212, 323.1198), -- Position for Team 1, Player 2
            },
            Team2 = {
                vec4(-930.6839, -783.2191, 14.9210, 132.8468),
                vec4(-935.1846, -779.8947, 14.9212, 145.3640),
            }
        },
        { -- Skate park 2
            DefaultSpawn = vec4(-920.6439, -710.6796, 19.9095, 172.3417),
            Team1 = {
                vec4(-908.0125, -726.1974, 19.9179, 99.3915), -- Position for Team 1, Player 1 (x, y, z, heading)
                vec4(-907.6395, -723.1347, 19.9163, 94.3589), -- Position for Team 1, Player 2
            },
            Team2 = {
                vec4(-934.1786, -726.2138, 19.9192, 277.7479),
                vec4(-934.2739, -723.0650, 19.9168, 275.2365),
            }
        },
        { -- Nuketown
            DefaultSpawn = vec4(3461.0745, -1038.9458, 64.2150, 200.6863),
            Team1 = {
                vec4(3508.7385, -1028.2794, 64.1300, 114.4592), -- Position for Team 1, Player 1 (x, y, z, heading)
                vec4(3511.1262, -1038.0430, 64.2151, 101.8287), -- Position for Team 1, Player 2
            },
            Team2 = {
                vec4(3410.7429, -1035.1525, 64.2100, 250.1886),
                vec4(3412.7002, -1030.5007, 64.2150, 269.9006),
            }
        },
        { -- Shipment
            DefaultSpawn = vec4(3444.8650, -861.8107, 11.4194, 87.5643),
            Team1 = {
                vec4(3430.4707, -843.8691, 11.3415, 216.4101), -- Position for Team 1, Player 1 (x, y, z, heading)
                vec4(3428.6707, -846.5266, 11.3588, 208.6259), -- Position for Team 1, Player 2
            },
            Team2 = {
                vec4(3455.7771, -876.1661, 11.4064, 50.1115),
                vec4(3458.2708, -873.1195, 11.4293, 25.8280),
            }
        },
        { -- Stables
            DefaultSpawn = vec4(6216.3950, 3372.1228, 764.9608, 4.5987),
            Team1 = {
                vec4(6207.0923, 3400.2732, 761.6269, 185.9296), -- Position for Team 1, Player 1 (x, y, z, heading)
                vec4(6224.6011, 3400.2388, 761.5510, 185.2997), -- Position for Team 1, Player 2
            },
            Team2 = {
                vec4(6228.1499, 3346.1514, 761.5237, 1.5227),
                vec4(6209.5747, 3344.9707, 761.6257, 53.7584),
            }
        },
        { -- Van Wars
            DefaultSpawn = vec4(3097.4810, 1136.2419, 74.1181, 183.6009),
            Team1 = {
                vec4(3101.7817, 1112.5690, 71.5035, 17.1862), -- Position for Team 1, Player 1 (x, y, z, heading)
                vec4(3112.1545, 1122.4863, 71.5181, 39.1840), -- Position for Team 1, Player 2
            },
            Team2 = {
                vec4(3076.1653, 1156.1238, 71.5254, 224.6481),
                vec4(3094.0054, 1158.4347, 71.5217, 197.9276),
            }
        },
    }
}