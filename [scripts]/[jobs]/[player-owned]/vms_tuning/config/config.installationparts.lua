---@field UseHelpUI: For advanced part installation which can prompt the player what they need to do now
Config.UseHelpUI = true

---@field AllowRunWithJacks: Allowing the player to run while carrying car jacks
Config.AllowRunWithJacks = true

---@field AllowJumpWithJacks: Allowing the player to jump while carrying car jacks
Config.AllowJumpWithJacks = true

---@field UseManualPartInstallation: Do you want the player to have to manually install each part separately to give the tuning process realism
Config.UseManualPartInstallation = true

---@field UseTargetForPartInstallation: Do you want to use target system for part installation
Config.UseTargetForPartInstallation = false

---@field TeleportToVehicleAfterInstallForMS: Is the player to be teleported to the vehicle for a millisecond, it will not be practically visible and the newly installed part in each player will synchronize
Config.TeleportToVehicleAfterInstallForMS = true

---@field TeleportToVehicleAfterFullInstallation: Is the mechanic to be transported to the vehicle after the installation of all parts is completed so that all Vehicle Properties are loaded 
Config.TeleportToVehicleAfterFullInstallation = true

---@class InstallationPartsPoints Points for workshops to find purchased parts for the installation
Config.InstallationPartsPoints = {
    ['BennyS'] = {
        ['clean'] = vector3(-227.83, -1327.94, 29.89 + 1.0),
        ['repair'] = vector3(-227.83, -1327.94, 29.89 + 1.0),

        ['color1'] = {
            [1] = vector3(-200.83, -1318.38, 30.09 + 1.0), -- BennyS point 1 will obtain a can of spray from these coordinates
            [2] = vector3(-227.83, -1326.51, 29.89 + 1.0), -- BennyS point 2 will obtain a can of spray from these coordinates
        },
        ['color2'] = vector3(-200.83, -1318.38, 30.09 + 1.0),
        ['pearlescentColor'] = vector3(-200.83, -1318.38, 30.09 + 1.0),
        ['wheelColor'] = vector3(-200.83, -1318.38, 30.09 + 1.0),
        ['plateIndex'] = vector3(-200.83, -1318.38, 30.09 + 1.0),
        ['neonColor'] = vector3(-200.83, -1318.38, 30.09 + 1.0),

        [0] = vector3(-195.9, -1315.47, 30.09 + 1.0), -- Spoilers
        [1] = vector3(-195.9, -1315.47, 30.09 + 1.0), -- Front Bumper
        [2] = vector3(-195.9, -1315.47, 30.09 + 1.0), -- Rear Bumper
        [4] = vector3(-198.43, -1315.29, 30.09 + 1.0), -- Exhaust
        [7] = vector3(-195.9, -1315.47, 30.09 + 1.0), -- Hood

        [11] = vector3(-196.37, -1317.22, 30.09 + 1.0), -- Engine
        [12] = vector3(-196.42, -1315.07, 30.09 + 1.0), -- Brakes
        [13] = vector3(-196.42, -1315.07, 30.09 + 1.0), -- Transmission
        [15] = vector3(-196.42, -1315.07, 30.09 + 1.0), -- Suspension
        ['engineSwap'] = vector3(-196.37, -1317.22, 30.09 + 1.0), -- Engine
        [23] = vector3(-206.03, -1331.13, 29.91 + 1.0), -- Wheels
    },

    ['BennyS-Paintshop'] = {
        ['color1'] = vector3(-202.84, -1322.42, 30.09 + 1.0),
        ['color2'] = vector3(-202.84, -1322.42, 30.09 + 1.0),
        ['pearlescentColor'] = vector3(-202.84, -1322.42, 30.09 + 1.0),

        ['clean'] = vector3(-227.83, -1327.94, 29.89 + 1.0),
    },

    ['LSCustoms1'] = {
        ['clean'] = vector3(-345.3, -131.07, 38.01 + 1.0),
        ['repair'] = vector3(-345.3, -131.07, 38.01 + 1.0),

        ['color1'] = vector3(-344.43, -128.08, 38.01 + 1.0),
        ['color2'] = vector3(-344.43, -128.08, 38.01 + 1.0),
        ['pearlescentColor'] = vector3(-344.43, -128.08, 38.01 + 1.0),
        ['wheelColor'] = vector3(-344.43, -128.08, 38.01 + 1.0),
        ['plateIndex'] = vector3(-343.43, -140.11, 38.01 + 1.0),
        ['neonColor'] = vector3(-343.43, -140.11, 38.01 + 1.0),

        [0] = vector3(-329.88, -127.54, 38.01 + 1.0), -- Spoilers
        [1] = vector3(-331.04, -127.1, 38.01 + 1.0), -- Front Bumper
        [2] = vector3(-331.04, -127.1, 38.01 + 1.0), -- Rear Bumper
        [4] = vector3(-329.88, -127.54, 38.01 + 1.0), -- Exhaust
        [7] = vector3(-348.54, -138.75, 38.01 + 1.0), -- Hood

        [11] = vector3(-339.93, -141.18, 38.01 + 1.0), -- Engine
        [12] = vector3(-339.93, -141.18, 38.01 + 1.0), -- Brakes
        [13] = vector3(-339.93, -141.18, 38.01 + 1.0), -- Transmission
        [15] = vector3(-339.93, -141.18, 38.01 + 1.0), -- Suspension
        ['engineSwap'] = vector3(-339.93, -141.18, 38.01 + 1.0), -- Engine
        [23] = vector3(-333.99, -126.17, 38.01 + 1.0), -- Wheels
    },

    ['LSCustoms2'] = {
        ['clean'] = vector3(-1147.01, -2002.46, 12.18 + 1.0),
        ['repair'] = vector3(-1147.01, -2002.46, 12.18 + 1.0),

        ['color1'] = vector3(-1144.78, -2004.47, 12.18 + 1.0),
        ['color2'] = vector3(-1144.78, -2004.47, 12.18 + 1.0),
        ['pearlescentColor'] = vector3(-1144.78, -2004.47, 12.18 + 1.0),
        ['wheelColor'] = vector3(-1144.78, -2004.47, 12.18 + 1.0),
        ['plateIndex'] = vector3(-1155.93, -2000.15, 12.18 + 1.0),
        ['neonColor'] = vector3(-1155.93, -2000.15, 12.18 + 1.0),

        [0] = vector3(-1151.37, -2019.04, 12.18 + 1.0), -- Spoilers
        [1] = vector3(-1149.31, -2016.95, 12.18 + 1.0), -- Front Bumper
        [2] = vector3(-1149.31, -2016.95, 12.18 + 1.0), -- Rear Bumper
        [4] = vector3(-1149.31, -2016.95, 12.18 + 1.0), -- Exhaustx
        [7] = vector3(-1152.59, -1996.26, 12.18 + 1.0), -- Hood

        [11] = vector3(-1158.44, -2003.13, 12.18 + 1.0), -- Engine
        [12] = vector3(-1158.44, -2003.13, 12.18 + 1.0), -- Brakes
        [13] = vector3(-1158.44, -2003.13, 12.18 + 1.0), -- Transmission
        [15] = vector3(-1158.44, -2003.13, 12.18 + 1.0), -- Suspension
        ['engineSwap'] = vector3(-1158.44, -2003.13, 12.18 + 1.0), -- Engine
        [23] = vector3(-1146.91, -2013.94, 12.18 + 1.0), -- Wheels
    },

    ['LSCustoms3'] = {
        ['clean'] = vector3(737.81, -1077.98, 21.17 + 1.0),
        ['repair'] = vector3(737.81, -1077.98, 21.17 + 1.0),

        ['color1'] = vector3(736.27, -1064.09, 21.17 + 1.0),
        ['color2'] = vector3(736.27, -1064.09, 21.17 + 1.0),
        ['pearlescentColor'] = vector3(736.27, -1064.09, 21.17 + 1.0),
        ['wheelColor'] = vector3(736.27, -1064.09, 21.17 + 1.0),
        ['plateIndex'] = vector3(734.42, -1063.97, 21.17 + 1.0),
        ['neonColor'] = vector3(734.42, -1063.97, 21.17 + 1.0),

        [0] = vector3(737.51, -1065.11, 21.89 + 1.0), -- Spoilers
        [1] = vector3(737.51, -1065.11, 21.89 + 1.0), -- Front Bumper
        [2] = vector3(737.51, -1065.11, 21.89 + 1.0), -- Rear Bumper
        [4] = vector3(737.72, -1081.89, 21.17 + 1.0), -- Exhaustx
        [7] = vector3(725.62, -1065.42, 21.17 + 1.0), -- Hood

        [11] = vector3(725.52, -1066.95, 21.17 + 1.0), -- Engine
        [12] = vector3(725.52, -1066.95, 21.17 + 1.0), -- Brakes
        [13] = vector3(725.52, -1066.95, 21.17 + 1.0), -- Transmission
        [15] = vector3(725.52, -1066.95, 21.17 + 1.0), -- Suspension
        ['engineSwap'] = vector3(725.52, -1066.95, 21.17 + 1.0), -- Engine
        [23] = vector3(725.72, -1068.86, 21.17 + 1.0), -- Wheels
    },

    ['AutoRepairs'] = {
        ['clean'] = vector3(1189.1, 2636.96, 37. + 1.0),
        ['repair'] = vector3(1189.1, 2636.96, 37. + 1.0),

        ['color1'] = vector3(1188.73, 2641.89, 37.4 + 1.0),
        ['color2'] = vector3(1188.73, 2641.89, 37.4 + 1.0),
        ['pearlescentColor'] = vector3(1188.73, 2641.89, 37.4 + 1.0),
        ['wheelColor'] = vector3(1188.73, 2641.89, 37.4 + 1.0),
        ['plateIndex'] = vector3(1188.73, 2641.89, 37.4 + 1.0),
        ['neonColor'] = vector3(1172.52, 2635.77, 36.79 + 1.0),

        [0] = vector3(1178.65, 2638.88, 36.75 + 1.0), -- Spoilers
        [1] = vector3(1178.65, 2638.88, 36.75 + 1.0), -- Front Bumper
        [2] = vector3(1178.65, 2638.88, 36.75 + 1.0), -- Rear Bumper
        [4] = vector3(1178.65, 2638.88, 36.75 + 1.0), -- Exhaust
        [7] = vector3(1178.65, 2638.88, 36.75 + 1.0), -- Hood

        [11] = vector3(1177.38, 2636.25, 36.75 + 1.0), -- Engine
        [12] = vector3(1177.38, 2636.25, 36.75 + 1.0), -- Brakes
        [13] = vector3(1177.38, 2636.25, 36.75 + 1.0), -- Transmission
        [15] = vector3(1177.38, 2636.25, 36.75 + 1.0), -- Suspension
        ['engineSwap'] = vector3(1177.38, 2636.25, 36.75 + 1.0), -- Engine
        [23] = vector3(1172.14, 2642.0, 36.79 + 1.0), -- Wheels
    },
    
    ['BeekersGarage'] = {
        ['clean'] = vector3(107.51, 6629.69, 30.79 + 1.0),
        ['repair'] = vector3(107.51, 6629.69, 30.79 + 1.0),

        ['color1'] = vector3(107.51, 6629.69, 30.79 + 1.0),
        ['color2'] = vector3(107.51, 6629.69, 30.79 + 1.0),
        ['pearlescentColor'] = vector3(107.51, 6629.69, 30.79 + 1.0),
        ['wheelColor'] = vector3(107.51, 6629.69, 30.79 + 1.0),
        ['plateIndex'] = vector3(107.51, 6629.69, 30.79 + 1.0),
        ['neonColor'] = vector3(109.11, 6631.57, 30.79 + 1.0),

        [0] = vector3(106.94, 6625.69, 30.79 + 1.0), -- Spoilers
        [1] = vector3(106.94, 6625.69, 30.79 + 1.0), -- Front Bumper
        [2] = vector3(106.94, 6625.69, 30.79 + 1.0), -- Rear Bumper
        [4] = vector3(106.94, 6625.69, 30.79 + 1.0), -- Exhaustx
        [7] = vector3(106.94, 6625.69, 30.79 + 1.0), -- Hood

        [11] = vector3(106.27, 6627.92, 30.79 + 1.0), -- Engine
        [12] = vector3(106.27, 6627.92, 30.79 + 1.0), -- Brakes
        [13] = vector3(106.27, 6627.92, 30.79 + 1.0), -- Transmission
        [15] = vector3(106.27, 6627.92, 30.79 + 1.0), -- Suspension
        ['engineSwap'] = vector3(106.27, 6627.92, 30.79 + 1.0), -- Engine
        [23] = vector3(107.72, 6624.23, 30.79 + 1.0), -- Wheels
    },
    ['mlo592'] = {
        ['clean'] = vector3(665.4457, 149.2280, 80.7716 + 1.0),
        ['repair'] = vector3(664.4319, 145.9040, 80.7716 + 1.0),

        ['color1'] = vector3(695.4120, 152.7442, 80.7716 + 1.0),
        ['color2'] = vector3(695.4120, 152.7442, 80.7716 + 1.0),
        ['pearlescentColor'] = vector3(695.4120, 152.7442, 80.7716 + 1.0),
        ['wheelColor'] = vector3(695.4120, 152.7442, 80.7716 + 1.0),
        ['plateIndex'] = vector3(695.4120, 152.7442, 80.7716 + 1.0),
        ['neonColor'] = vector3(695.4120, 152.7442, 80.7716 + 1.0),

        [0] = vector3(695.3347, 144.0983, 80.7716 + 1.0), -- Spoilers
        [1] = vector3(695.3347, 144.0983, 80.7716 + 1.0), -- Front Bumper
        [2] = vector3(695.3347, 144.0983, 80.7716 + 1.0), -- Rear Bumper
        [4] = vector3(695.3347, 144.0983, 80.7716 + 1.0), -- Exhaustx
        [7] = vector3(695.3347, 144.0983, 80.7716 + 1.0), -- Hood

        [11] = vector3(696.2761, 156.1523, 80.7715 + 1.0), -- Engine
        [12] = vector3(696.2761, 156.1523, 80.7715 + 1.0), -- Brakes
        [13] = vector3(696.2761, 156.1523, 80.7715 + 1.0), -- Transmission
        [15] = vector3(696.2761, 156.1523, 80.7715 + 1.0), -- Suspension
        ['engineSwap'] = vector3(696.2761, 156.1523, 80.7715 + 1.0), -- Engine
        [23] = vector3(669.5172, 159.7718, 80.7715 + 1.0), -- Wheels
    },
    ['mlo618'] = {
        ['clean'] = vector3(-102.4944, -435.6402, 37.2752 + 1.0),
        ['repair'] = vector3(-102.4944, -435.6402, 37.2752 + 1.0),

        ['color1'] = vector3(-87.4151, -411.6190, 37.2752 + 1.0),
        ['color2'] = vector3(-87.4151, -411.6190, 37.2752 + 1.0),
        ['pearlescentColor'] = vector3(-87.4151, -411.6190, 37.2752 + 1.0),
        ['wheelColor'] = vector3(-87.4151, -411.6190, 37.2752 + 1.0),
        ['plateIndex'] = vector3(-87.4151, -411.6190, 37.2752 + 1.0),
        ['neonColor'] = vector3(-87.4151, -411.6190, 37.2752 + 1.0),

        [0] = vector3(-77.5542, -432.2769, 37.2674 + 1.0), -- Spoilers
        [1] = vector3(-77.5542, -432.2769, 37.2674 + 1.0), -- Front Bumper
        [2] = vector3(-77.5542, -432.2769, 37.2674 + 1.0), -- Rear Bumper
        [4] = vector3(-77.5542, -432.2769, 37.2674 + 1.0), -- Exhaustx
        [7] = vector3(-77.5542, -432.2769, 37.2674 + 1.0), -- Hood

        [11] = vector3(-80.0866, -439.8068, 37.2678 + 1.0), -- Engine
        [12] = vector3(-80.0866, -439.8068, 37.2678 + 1.0), -- Brakes
        [13] = vector3(-80.0866, -439.8068, 37.2678 + 1.0), -- Transmission
        [15] = vector3(-80.0866, -439.8068, 37.2678 + 1.0), -- Suspension
        ['engineSwap'] = vector3(-80.0866, -439.8068, 37.2678 + 1.0), -- Engine
        [23] = vector3(-115.0202, -435.4603, 37.2752 + 1.0), -- Wheels
    },
    ['mlo686'] = {
        ['clean'] = vector3(-1673.3053, -783.5483, 10.1747 + 1.0),
        ['repair'] = vector3(-1673.3053, -783.5483, 10.1747 + 1.0),

        ['color1'] = vector3(-1671.1960, -793.8311, 10.1747 + 1.0),
        ['color2'] = vector3(-1671.1960, -793.8311, 10.1747 + 1.0),
        ['pearlescentColor'] = vector3(-1671.1960, -793.8311, 10.1747 + 1.0),
        ['wheelColor'] = vector3(-1671.1960, -793.8311, 10.1747 + 1.0),
        ['plateIndex'] = vector3(-1671.1960, -793.8311, 10.1747 + 1.0),
        ['neonColor'] = vector3(-1671.1960, -793.8311, 10.1747 + 1.0),

        [0] = vector3(-1675.5549, -790.1484, 10.1747 + 1.0), -- Spoilers
        [1] = vector3(-1675.5549, -790.1484, 10.1747 + 1.0), -- Front Bumper
        [2] = vector3(-1675.5549, -790.1484, 10.1747 + 1.0), -- Rear Bumper
        [4] = vector3(-1675.5549, -790.1484, 10.1747 + 1.0), -- Exhaustx
        [7] = vector3(-1675.5549, -790.1484, 10.1747 + 1.0), -- Hood

        [11] = vector3(-1670.5758, -780.7474, 10.1747 + 1.0), -- Engine
        [12] = vector3(-1670.5758, -780.7474, 10.1747 + 1.0), -- Brakes
        [13] = vector3(-1670.5758, -780.7474, 10.1747 + 1.0), -- Transmission
        [15] = vector3(-1670.5758, -780.7474, 10.1747 + 1.0), -- Suspension
        ['engineSwap'] = vector3(-1670.5758, -780.7474, 10.1747 + 1.0), -- Engine
        [23] = vector3(-1665.9292, -775.1462, 10.1747 + 1.0), -- Wheels
    },
    ['mlo228'] = {
        ['clean'] = vector3(175.5486, 2771.5754, 42.5230 + 1.0),
        ['repair'] = vector3(175.5486, 2771.5754, 42.5230 + 1.0),

        ['color1'] = vector3(175.7653, 2773.8994, 42.5230 + 1.0),
        ['color2'] = vector3(175.7653, 2773.8994, 42.5230 + 1.0),
        ['pearlescentColor'] = vector3(175.7653, 2773.8994, 42.5230 + 1.0),
        ['wheelColor'] = vector3(175.7653, 2773.8994, 42.5230 + 1.0),
        ['plateIndex'] = vector3(175.7653, 2773.8994, 42.5230 + 1.0),
        ['neonColor'] = vector3(175.7653, 2773.8994, 42.5230 + 1.0),

        [0] = vector3(182.3193, 2749.2427, 42.5230 + 1.0), -- Spoilers
        [1] = vector3(182.3193, 2749.2427, 42.5230 + 1.0), -- Front Bumper
        [2] = vector3(182.3193, 2749.2427, 42.5230 + 1.0), -- Rear Bumper
        [4] = vector3(182.3193, 2749.2427, 42.5230 + 1.0), -- Exhaustx
        [7] = vector3(182.3193, 2749.2427, 42.5230 + 1.0), -- Hood

        [11] = vector3(182.3193, 2749.2427, 42.5230 + 1.0), -- Engine
        [12] = vector3(182.3193, 2749.2427, 42.5230 + 1.0), -- Brakes
        [13] = vector3(182.3193, 2749.2427, 42.5230 + 1.0), -- Transmission
        [15] = vector3(182.3193, 2749.2427, 42.5230 + 1.0), -- Suspension
        ['engineSwap'] = vector3(182.3193, 2749.2427, 42.5230 + 1.0), -- Engine
        [23] = vector3(177.0191, 2762.2085, 42.5230 + 1.0), -- Wheels
    },
    ['mlo887'] = {
        ['clean'] = vector3(-1142.1671, -2077.1538, 13.2617 + 1.0),
        ['repair'] = vector3(-1142.1671, -2077.1538, 13.2617 + 1.0),

        ['color1'] = vector3(-1146.2155, -2084.1455, 13.2617 + 1.0),
        ['color2'] = vector3(-1146.2155, -2084.1455, 13.2617 + 1.0),
        ['pearlescentColor'] = vector3(-1146.2155, -2084.1455, 13.2617 + 1.0),
        ['wheelColor'] = vector3(-1146.2155, -2084.1455, 13.2617 + 1.0),
        ['plateIndex'] = vector3(-1146.2155, -2084.1455, 13.2617 + 1.0),
        ['neonColor'] = vector3(-1146.2155, -2084.1455, 13.2617 + 1.0),

        [0] = vector3(-1153.0000, -2085.0815, 13.2617 + 1.0), -- Spoilers
        [1] = vector3(-1153.0000, -2085.0815, 13.2617 + 1.0), -- Front Bumper
        [2] = vector3(-1153.0000, -2085.0815, 13.2617 + 1.0), -- Rear Bumper
        [4] = vector3(-1153.0000, -2085.0815, 13.2617 + 1.0), -- Exhaustx
        [7] = vector3(-1153.0000, -2085.0815, 13.2617 + 1.0), -- Hood

        [11] = vector3(-1158.9048, -2089.5308, 13.2617 + 1.0), -- Engine
        [12] = vector3(-1158.9048, -2089.5308, 13.2617 + 1.0), -- Brakes
        [13] = vector3(-1158.9048, -2089.5308, 13.2617 + 1.0), -- Transmission
        [15] = vector3(-1158.9048, -2089.5308, 13.2617 + 1.0), -- Suspension
        ['engineSwap'] = vector3(-1158.9048, -2089.5308, 13.2617 + 1.0), -- Engine
        [23] = vector3(-1157.1265, -2086.5293, 13.2617 + 1.0), -- Wheels
    },
    ['mlo685'] = {
        ['clean'] = vector3(-2059.1799, -468.5565, 12.0989 + 1.0),
        ['repair'] = vector3(-2059.1799, -468.5565, 12.0989 + 1.0),

        ['color1'] = vector3(-2064.8804, -471.7384, 12.0989 + 1.0),
        ['color2'] = vector3(-2064.8804, -471.7384, 12.0989 + 1.0),
        ['pearlescentColor'] = vector3(-2064.8804, -471.7384, 12.0989 + 1.0),
        ['wheelColor'] = vector3(-2064.8804, -471.7384, 12.0989 + 1.0),
        ['plateIndex'] = vector3(-2064.8804, -471.7384, 12.0989 + 1.0),
        ['neonColor'] = vector3(-2064.8804, -471.7384, 12.0989 + 1.0),

        [0] = vector3(-2069.9570, -460.9949, 12.0989 + 1.0), -- Spoilers
        [1] = vector3(-2069.9570, -460.9949, 12.0989 + 1.0), -- Front Bumper
        [2] = vector3(-2069.9570, -460.9949, 12.0989 + 1.0), -- Rear Bumper
        [4] = vector3(-2069.9570, -460.9949, 12.0989 + 1.0), -- Exhaustx
        [7] = vector3(-2069.9570, -460.9949, 12.0989 + 1.0), -- Hood

        [11] = vector3(-2077.1960, -467.4511, 12.0988 + 1.0), -- Engine
        [12] = vector3(-2077.1960, -467.4511, 12.0988 + 1.0), -- Brakes
        [13] = vector3(-2077.1960, -467.4511, 12.0988 + 1.0), -- Transmission
        [15] = vector3(-2077.1960, -467.4511, 12.0988 + 1.0), -- Suspension
        ['engineSwap'] = vector3(-2077.1960, -467.4511, 12.0988 + 1.0), -- Engine
        [23] = vector3(-2077.1960, -467.4511, 12.0988 + 1.0), -- Wheels
    },
    ['mlo526'] = {
        ['clean'] = vector3(768.0231, 1300.2014, 360.2946 + 1.0),
        ['repair'] = vector3(768.0231, 1300.2014, 360.2946 + 1.0),

        ['color1'] = vector3(773.4854, 1299.8834, 360.2947 + 1.0),
        ['color2'] = vector3(773.4854, 1299.8834, 360.2947 + 1.0),
        ['pearlescentColor'] = vector3(773.4854, 1299.8834, 360.2947 + 1.0),
        ['wheelColor'] = vector3(773.4854, 1299.8834, 360.2947 + 1.0),
        ['plateIndex'] = vector3(773.4854, 1299.8834, 360.2947 + 1.0),
        ['neonColor'] = vector3(773.4854, 1299.8834, 360.2947 + 1.0),

        [0] = vector3(761.4608, 1287.0819, 360.2945 + 1.0), -- Spoilers
        [1] = vector3(761.4608, 1287.0819, 360.2945 + 1.0), -- Front Bumper
        [2] = vector3(761.4608, 1287.0819, 360.2945 + 1.0), -- Rear Bumper
        [4] = vector3(761.4608, 1287.0819, 360.2945 + 1.0), -- Exhaustx
        [7] = vector3(761.4608, 1287.0819, 360.2945 + 1.0), -- Hood

        [11] = vector3(761.4608, 1287.0819, 360.2945 + 1.0), -- Engine
        [12] = vector3(761.4608, 1287.0819, 360.2945 + 1.0), -- Brakes
        [13] = vector3(761.4608, 1287.0819, 360.2945 + 1.0), -- Transmission
        [15] = vector3(761.4608, 1287.0819, 360.2945 + 1.0), -- Suspension
        ['engineSwap'] = vector3(761.4608, 1287.0819, 360.2945 + 1.0), -- Engine
        [23] = vector3(761.4608, 1287.0819, 360.2945 + 1.0), -- Wheels
    },
        ['mlo260/4024'] = {
        ['clean'] = vector3(1328.3105, 2634.2441, 39.2984 + 1.0),
        ['repair'] = vector3(1328.3105, 2634.2441, 39.2984 + 1.0),

        ['color1'] = vector3(1332.3523, 2628.6001, 39.2984 + 1.0),
        ['color2'] = vector3(1332.3523, 2628.6001, 39.2984 + 1.0),
        ['pearlescentColor'] = vector3(1332.3523, 2628.6001, 39.2984 + 1.0),
        ['wheelColor'] = vector3(1332.3523, 2628.6001, 39.2984 + 1.0),
        ['plateIndex'] = vector3(1332.3523, 2628.6001, 39.2984 + 1.0),
        ['neonColor'] = vector3(1332.3523, 2628.6001, 39.2984 + 1.0),

        [0] = vector3(1326.6465, 2636.3975, 39.2984 + 1.0), -- Spoilers
        [1] = vector3(1326.6465, 2636.3975, 39.2984 + 1.0), -- Front Bumper
        [2] = vector3(1326.6465, 2636.3975, 39.2984 + 1.0), -- Rear Bumper
        [4] = vector3(1326.6465, 2636.3975, 39.2984 + 1.0), -- Exhaustx
        [7] = vector3(1326.6465, 2636.3975, 39.2984 + 1.0), -- Hood

        [11] = vector3(1324.8157, 2639.5347, 39.2984 + 1.0), -- Engine
        [12] = vector3(1324.8157, 2639.5347, 39.2984 + 1.0), -- Brakes
        [13] = vector3(1324.8157, 2639.5347, 39.2984 + 1.0), -- Transmission
        [15] = vector3(1324.8157, 2639.5347, 39.2984 + 1.0), -- Suspension
        ['engineSwap'] = vector3(1324.8157, 2639.5347, 39.2984 + 1.0), -- Engine
        [23] = vector3(1333.3555, 2625.8787, 39.2984 + 1.0), -- Wheels
    },
        ['mlo013/1079'] = {
        ['clean'] = vector3(-770.4035, 5884.2070, 16.8577 + 1.0),
        ['repair'] = vector3(-770.4035, 5884.2070, 16.8577 + 1.0),

        ['color1'] = vector3(-771.6630, 5881.8350, 16.8577 + 1.0),
        ['color2'] = vector3(-771.6630, 5881.8350, 16.8577 + 1.0),
        ['pearlescentColor'] = vector3(-771.6630, 5881.8350, 16.8577 + 1.0),
        ['wheelColor'] = vector3(-771.6630, 5881.8350, 16.8577 + 1.0),
        ['plateIndex'] = vector3(-771.6630, 5881.8350, 16.8577 + 1.0),
        ['neonColor'] = vector3(-771.6630, 5881.8350, 16.8577 + 1.0),

        [0] = vector3(-768.8811, 5886.7773, 16.8577 + 1.0), -- Spoilers
        [1] = vector3(-768.8811, 5886.7773, 16.8577 + 1.0), -- Front Bumper
        [2] = vector3(-768.8811, 5886.7773, 16.8577 + 1.0), -- Rear Bumper
        [4] = vector3(-768.8811, 5886.7773, 16.8577 + 1.0), -- Exhaustx
        [7] = vector3(-768.8811, 5886.7773, 16.8577 + 1.0), -- Hood

        [11] = vector3(-767.5978, 5889.0063, 16.8444 + 1.0), -- Engine
        [12] = vector3(-767.5978, 5889.0063, 16.8444 + 1.0), -- Brakes
        [13] = vector3(-767.5978, 5889.0063, 16.8444 + 1.0), -- Transmission
        [15] = vector3(-767.5978, 5889.0063, 16.8444 + 1.0), -- Suspension
        ['engineSwap'] = vector3(-767.5978, 5889.0063, 16.8444 + 1.0), -- Engine
        [23] = vector3(-767.5978, 5889.0063, 16.8444 + 1.0), -- Wheels
    },
}

---@field UseAdvancedEngineInstallation: Advanced engine installation with engine on stand
Config.UseAdvancedEngineInstallation = true

---@field UseAdvancedBrakesInstallation: Advanced brakes installation with jacks
Config.UseAdvancedBrakesInstallation = true

---@field UseAdvancedTransmissionInstallation: Advanced transmission installation with jacks
Config.UseAdvancedTransmissionInstallation = true

---@field UseAdvancedSuspensionInstallation: Advanced suspension installation with jacks
Config.UseAdvancedSuspensionInstallation = true

---@field UseAdvancedEngineSwapInstallation: Advanced engine swap installation with engine on stand
Config.UseAdvancedEngineSwapInstallation = true

---@field UseAdvancedWheelsInstallation: Advanced installation of each wheel separately 
Config.UseAdvancedWheelsInstallation = true

---@field UseBoltMinigame: Do you want to make wheel assembly even more realistic by using the minigame ls_bolt_minigame created by Lith Studios (https://lith.store/package/6174416)
Config.UseBoltMinigame = GetResourceState('ls_bolt_minigame') ~= 'missing'

---@field UseInstallationSoundEffects: Using sound effects when installing parts (CL.PlayInstallationSoundEffect)
Config.UseInstallationSoundEffects = true

---@class PartsInstallationSoundEffects You can configure every possible sound, file name and volume
Config.PartsInstallationSoundEffects = {
    ['carJacks'] = {use=true, fileName='vms_tuning-jacks', volume=0.10}, -- Car Jacks
    
    ['clean'] = {use=true, fileName='vms_tuning-cleaning', volume=0.08},
    ['repair'] = {use=true, fileName='vms_tuning-socket_wrench', volume=0.12},

    [0] = {use=true, fileName='vms_tuning-socket_wrench', volume=0.12}, -- Spoilers
    [1] = {use=true, fileName='vms_tuning-socket_wrench', volume=0.12}, -- Front Bumper
    [2] = {use=true, fileName='vms_tuning-socket_wrench', volume=0.12}, -- Rear Bumper
    [4] = {use=true, fileName='vms_tuning-socket_wrench', volume=0.12}, -- Exhaust
    [7] = {use=true, fileName='vms_tuning-socket_wrench', volume=0.12}, -- Hood

    [11] = {use=true, fileName='vms_tuning-engine_crane', volume=0.11}, -- Engine
    ['engineSwap'] = {use=true, fileName='vms_tuning-engine_crane', volume=0.11}, -- Engine Swap
    
    [12] = {use=true, fileName='vms_tuning-ratchet_wrench', volume=0.07}, -- Brakes
    [13] = {use=true, fileName='vms_tuning-ratchet_wrench', volume=0.07}, -- Transmission
    [15] = {use=true, fileName='vms_tuning-ratchet_wrench', volume=0.07}, -- Suspension

    [23] = {use=true, fileName='vms_tuning-air_wrench', volume=0.03}, -- Wheels
    
    ['color1'] = {use=true, fileName='vms_tuning-painting', volume=0.1}, -- Primary Color
    ['color2'] = {use=true, fileName='vms_tuning-painting', volume=0.1}, -- Secondary Color
    ['pearlescentColor'] = {use=true, fileName='vms_tuning-painting', volume=0.1}, -- Pearlescent Color
    ['wheelColor'] = {use=true, fileName='vms_tuning-painting', volume=0.1}, -- Wheel Color
}


Config.ClassesOfVehiclesWithAdvancedInstallations = {
    [0] = true, -- Compacts
    [1] = true, -- Sedans
    [2] = true, -- SUVs
    [3] = true, -- Coupes
    [4] = true, -- Muscle
    [5] = true, -- Sports Classics
    [6] = true, -- Sports
    [7] = true, -- Super
    [8] = false, -- Motorcycles
    [9] = true, -- Off-road
    [10] = false, -- Industrial
    [11] = false, -- Utility
    [12] = true, -- Vans
    [13] = false, -- Cycles
    [14] = false, -- Boats
    [15] = false, -- Helicopters
    [16] = false, -- Planes
    [17] = false, -- Service
    [18] = true, -- Emergency
    [19] = false, -- Military
    [20] = true, -- Commercial
    [21] = false, -- Trains
    [22] = false, -- Open Wheel
}

Config.AdvancedInstallationsProps = {
    [11] = {
        helpUI = {
            getStand = "Take the engine on a stand.",
            installEngine = "Install the engine.",
        },
        standHash = joaat("prop_engine_hoist"),
        standOffset = {-0.085, 0.24, -1.3, 10.0, 30.0, 100.0},
        standBone = 57005,
        standAnimation = {"missfinale_c2ig_11", "pushcar_offcliff_m"},
        
        partHash = joaat("prop_car_engine_01"),
        partOffsetToStand = {-0.1, -1.6, 1.4, 0.0, 0.0, 0.0},

        installationPointDirection = 'front',
        installationOffset = vec(0.0, 0.2, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
            [joaat('buffalo4')] = vec(0.0, 0.12, 0.2),
        },

        installationPointDirectionBackEngine = 'rear',
        installationOffsetBackEngine = vec(0.0, -0.2, 0.2),
        installationOffsetsBackEngineByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },

        installationAnimation = {"mini@repair", "fixing_a_ped"},
        installationTime = 4000,
        openDoors = {4},

        allowPlayerRun = false,
        allowPlayerJump = false,
    },
    [12] = {
        helpUI = {
            getStand = "Take the jacks.",
            installStand = "Place the jacks under vehicle.",
            installPart = "Tune the brakes.",
        },
        standHash = joaat("xs_prop_x18_axel_stand_01a"),
        standBone = 28422,
        standOffset = {0.07, -0.44, -0.1, -80.0, 20.0, 0.0},
        standBone2 = 60309,
        standOffset2 = {0.0, -0.44, 0.275, -120.0, -20.0, 0.0},
        standAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        time = 3000,
        standInstallationPointDirection = 'front-left',
        standInstallationOffset = vec(0.1, -2.0, 0.2),
        standInstallationOffsetByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        standInstallationAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        
        installation = {
            [1] = {
                pointDirection = "rear",
                offset = vec(0.4, 0.1, 0.2),
                offsetByModel = {
                    -- Add custom offsets for specific models here, example:
                    -- [joaat("model_name")] = vec(x, y, z)
                },
                animation = {"amb@world_human_vehicle_mechanic@male@base", "base"},
                time = 6000,
                pedDirection = 'front',
            },
            [2] = {
                pointDirection = "front",
                offset = vec(0.0, -0.1, 0.2),
                offsetByModel = {
                    -- Add custom offsets for specific models here, example:
                    -- [joaat("model_name")] = vec(x, y, z)
                },
                animation = {"amb@world_human_vehicle_mechanic@male@base", "base"},
                time = 6000,
                pedDirection = 'rear',
            },
        },
        
        allowPlayerRun = true,
        allowPlayerJump = true,
    },
    [13] = {
        helpUI = {
            getStand = "Take the jacks.",
            installStand = "Place the jacks under vehicle.",
            installPart = "Tune the transmission.",
        },
        standHash = joaat("xs_prop_x18_axel_stand_01a"),
        standBone = 28422,
        standOffset = {0.07, -0.44, -0.1, -80.0, 20.0, 0.0},
        standBone2 = 60309,
        standOffset2 = {0.0, -0.44, 0.275, -120.0, -20.0, 0.0},
        standAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        time = 3000,
        
        standInstallationPointDirection = 'front-left',
        standInstallationOffset = vec(0.1, -2.0, 0.2),
        standInstallationOffsetByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
            [joaat('adder')] = vec(1.5, -4.5, 0.2)
        },
        standInstallationAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        
        installation = {
            [1] = {
                pointDirection = "front",
                offset = vec(0.0, -0.1, 0.2),
                offsetByModel = {
                    -- Add custom offsets for specific models here, example:
                    -- [joaat("model_name")] = vec(x, y, z)
                    [joaat('adder')] = vec(0.0, -0.1, 0.2),
                },
                animation = {"amb@world_human_vehicle_mechanic@male@base", "base"},
                time = 6000,
                pedDirection = 'rear',
            },
        },
        
        allowPlayerRun = true,
        allowPlayerJump = true,
    },
    [15] = {
        helpUI = {
            getStand = "Take the jacks.",
            installStand = "Place the jacks under vehicle.",
            installPart = "Tune the suspension.",
        },
        standHash = joaat("xs_prop_x18_axel_stand_01a"),
        standBone = 28422,
        standOffset = {0.07, -0.44, -0.1, -80.0, 20.0, 0.0},
        standBone2 = 60309,
        standOffset2 = {0.0, -0.44, 0.275, -120.0, -20.0, 0.0},
        standAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        time = 3000,

        standInstallationPointDirection = 'front-left',
        standInstallationOffset = vec(0.1, -2.0, 0.2),
        standInstallationOffsetByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        standInstallationAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        
        installation = {
            [1] = {
                pointDirection = "rear",
                offset = vec(0.4, 0.1, 0.2),
                offsetByModel = {
                    -- Add custom offsets for specific models here, example:
                    -- [joaat("model_name")] = vec(x, y, z)
                },
                animation = {"amb@world_human_vehicle_mechanic@male@base", "base"},
                time = 6000,
                pedDirection = 'front',
            },
            [2] = {
                pointDirection = "front",
                offset = vec(0.0, -0.1, 0.2),
                offsetByModel = {
                    -- Add custom offsets for specific models here, example:
                    -- [joaat("model_name")] = vec(x, y, z)
                },
                animation = {"amb@world_human_vehicle_mechanic@male@base", "base"},
                time = 6000,
                pedDirection = 'rear',
            },
        },
        
        allowPlayerRun = true,
        allowPlayerJump = true,
    },
    ['engineSwap'] = {
        helpUI = {
            getStand = "Take the engine on a stand.",
            installEngine = "Install the engine.",
        },
        standHash = joaat("prop_engine_hoist"),
        standOffset = {-0.085, 0.24, -1.3, 10.0, 30.0, 100.0},
        standBone = 57005,
        standAnimation = {"missfinale_c2ig_11", "pushcar_offcliff_m"},
        
        partHash = joaat("prop_car_engine_01"),
        partOffsetToStand = {-0.1, -1.6, 1.4, 0.0, 0.0, 0.0},

        installationPointDirection = 'front',
        installationOffset = vec(0.0, 0.2, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },

        installationPointDirectionBackEngine = 'rear',
        installationOffsetBackEngine = vec(0.0, -0.2, 0.2),
        installationOffsetsBackEngineByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },

        installationAnimation = {"mini@repair", "fixing_a_ped"},
        installationTime = 4000,
        openDoors = {4},
        
        allowPlayerRun = false,
        allowPlayerJump = false,
    },
    [23] = {
        helpUI = {
            getStand = "Take the jacks.",
            installStand = "Place the jacks under vehicle.",
            getWheel = "Take the wheel.",
            installWheel = "Install the wheel.",
        },
        standHash = joaat("xs_prop_x18_axel_stand_01a"),
        standBone = 28422,
        standOffset = {0.07, -0.44, -0.1, -80.0, 20.0, 0.0},
        standBone2 = 60309,
        standOffset2 = {0.0, -0.44, 0.275, -120.0, -20.0, 0.0},
        standAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        time = 3000,

        standInstallationPointDirection = 'front-left',
        standInstallationOffset = vec(0.1, -2.0, 0.2),
        standInstallationOffsetByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        standInstallationAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        
        hash = joaat('prop_wheel_rim_01'),
        boneAttach = 57005,
        propPlacement = {0.169, -0.018, -0.22, -90.0, -110.0, 282.0},
        animation = {"anim@heists@box_carry@", "idle"},
        installationTime = 4000,

        installation = {
            [1] = {
                bone = "wheel_lf",
                animation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
                time = 6000,
            },
            [2] = {
                bone = "wheel_lr",
                animation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
                time = 6000,
            },
            [3] = {
                bone = "wheel_rf",
                animation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
                time = 6000,
            },
            [4] = {
                bone = "wheel_rr",
                animation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
                time = 6000,
            },
            [5] = {
                bone = "wheel_lm1",
                animation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
                time = 6000,
            },
            [6] = {
                bone = "wheel_rm1",
                animation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
                time = 6000,
            },
        },
        
        allowPlayerRun = true,
        allowPlayerJump = false,
    },
}

Config.InstallationPartsPropsList = {
    ---@param installationPointDirection: 'front', 'front-left', 'front-right', 'rear', 'rear-left', 'rear-right'
    ['clean'] = {
        hash = joaat('prop_sponge_01'),
        boneAttach = 28422,
        propPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
        installationPointDirection = 'front-left',
        installationOffset = vec(0.1, -0.75, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"amb@world_human_maid_clean@", "base"},
        installationTime = 4000,
        
        allowPlayerRun = true,
        allowPlayerJump = true,
    },

    ['repair'] = {
        hash = joaat("prop_tool_wrench"),
        boneAttach = 57005,
        propPlacement = {0.119, -0.072, -0.05, -90.0, 120.0, 12.0},

        installationPointDirection = 'front',
        installationOffset = vec(0.4, 0.1, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        
        installationPointDirectionBackEngine = 'rear',
        installationOffsetBackEngine = vec(0.0, -0.1, 0.2),
        installationOffsetsBackEngineByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },

        installationAnimation = {"mini@repair", "fixing_a_ped"},
        installationTime = 4000,
        openDoors = {4},
        
        allowPlayerRun = true,
        allowPlayerJump = true,
    },

    ['paint_booth'] = {
        installationAnimation = {'mini@sprunk@first_person', 'PLYR_BUY_DRINK_PT1', 1700},
        installationTime = 4000,

        allowPlayerRun = true,
        allowPlayerJump = true,
    },

    ['color1'] = {
        hash = joaat('prop_cs_spray_can'),
        boneAttach = 57005,
        propPlacement = {0.119, -0.072, -0.05, -90.0, 120.0, 12.0},
        installationPointDirection = 'front-left',
        installationOffset = vec(-0.4, 0.15, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_spraybottle_stand_spraying_01_inspector"},
        installationTime = 4000,
        
        allowPlayerRun = true,
        allowPlayerJump = true,
    },

    ['color2'] = {
        hash = joaat('prop_cs_spray_can'),
        boneAttach = 57005,
        propPlacement = {0.119, -0.072, -0.05, -90.0, 120.0, 12.0},
        installationPointDirection = 'front-right',
        installationOffset = vec(-0.4, 0.15, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_spraybottle_stand_spraying_01_inspector"},
        installationTime = 4000,
        
        allowPlayerRun = true,
        allowPlayerJump = true,
    },
    
    ['pearlescentColor'] = {
        hash = joaat('prop_cs_spray_can'),
        boneAttach = 57005,
        propPlacement = {0.119, -0.072, -0.05, -90.0, 120.0, 12.0},
        installationPointDirection = 'front-left',
        installationOffset = vec(-0.4, 0.15, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_spraybottle_stand_spraying_01_inspector"},
        installationTime = 4000,
        
        allowPlayerRun = true,
        allowPlayerJump = true,
    },

    ['wheelColor'] = {
        hash = joaat('prop_cs_spray_can'),
        boneAttach = 57005,
        propPlacement = {0.119, -0.072, -0.05, -90.0, 120.0, 12.0},
        installationPointDirection = 'front-left',
        installationOffset = vec(-0.4, 0.15, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_spraybottle_stand_spraying_01_inspector"},
        installationTime = 4000,
        
        allowPlayerRun = true,
        allowPlayerJump = true,
    },

    ['plateIndex'] = {
        hash = joaat('p_num_plate_01'),
        boneAttach = 57005,
        propPlacement = {0.119, -0.072, -0.05, -90.0, 120.0, 12.0},
        animation = {"anim@heists@box_carry@", "idle"},
        installationPointDirection = 'rear',
        installationOffset = vec(0.0, -0.15, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        installationTime = 4000,
        
        allowPlayerRun = true,
        allowPlayerJump = true,
    },

    ['neonColor'] = {
        hash = joaat('xs_prop_arena_lights_tube_l_a'),
        boneAttach = 57005,
        propPlacement = {0.169, -0.018, -0.22, 90.0, -110.0, 282.0},
        animation = {"anim@heists@box_carry@", "idle"},
        installationPointDirection = 'front-left',
        installationOffset = vec(0.2, -2.25, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        installationTime = 4000,
        
        allowPlayerRun = true,
        allowPlayerJump = false,
    },

    [0] = { -- Spoiler
        hash = joaat('imp_prop_impexp_spoiler_02a'),
        boneAttach = 57005,
        propPlacement = {0.36, 0.078, -0.195, -20.0, -110.0, 10.0},
        animation = {"anim@heists@box_carry@", "idle"},
        installationPointDirection = 'rear',
        installationOffset = vec(0.0, -0.1, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"mini@repair", "fixing_a_ped"},
        installationTime = 4000,
        
        allowPlayerRun = true,
        allowPlayerJump = false,
    },

    [1] = { -- Front Bumper
        hash = joaat('imp_prop_impexp_front_bumper_01a'),
        boneAttach = 57005,
        propPlacement = {0.36, 0.078, -0.195, -20.0, -110.0, 10.0},
        animation = {"anim@heists@box_carry@", "idle"},
        installationPointDirection = 'front',
        installationOffset = vec(0.0, 0.1, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        installationTime = 4000,
        
        allowPlayerRun = true,
        allowPlayerJump = false,
    },

    [2] = { -- Rear Bumper
        hash = joaat('imp_prop_impexp_rear_bumper_02a'),
        boneAttach = 57005,
        propPlacement = {0.36, 0.078, -0.195, -20.0, -110.0, 10.0},
        animation = {"anim@heists@box_carry@", "idle"},
        installationPointDirection = 'rear',
        installationOffset = vec(0.0, -0.1, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        installationTime = 4000,
        
        allowPlayerRun = true,
        allowPlayerJump = false,
    }, 

    [4] = { -- Exhaust
        hash = joaat('imp_prop_impexp_exhaust_06'),
        boneAttach = 57005,
        propPlacement = {-0.04, -0.03, 0.09, 200.0, 220.0, 12.0},
        installationPointDirection = 'rear',
        installationOffset = vec(0.0, -0.1, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        installationTime = 4000,
        
        allowPlayerRun = true,
        allowPlayerJump = true,
    },

    [7] = { -- Hood
        hash = joaat('prop_car_bonnet_02'),
        boneAttach = 60309,
        propPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
        animation = {"anim@heists@box_carry@", "idle"},
        installationPointDirection = 'front',
        installationOffset = vec(0.0, 0.1, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"mini@repair", "fixing_a_ped"},
        installationTime = 4000,
        
        allowPlayerRun = false,
        allowPlayerJump = false,
    },

    [23] = { -- Wheels
        hash = joaat('prop_wheel_rim_01'),
        boneAttach = 57005,
        propPlacement = {0.169, -0.018, -0.22, -90.0, -110.0, 282.0},
        animation = {"anim@heists@box_carry@", "idle"},
        installationPointDirection = 'front-left',
        installationOffset = vec(0.15, -1.65, 0.2),
        installationOffsetsByModel = {
            -- Add custom offsets for specific models here, example:
            -- [joaat("model_name")] = vec(x, y, z)
        },
        installationAnimation = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"},
        installationTime = 4000,
        
        allowPlayerRun = true,
        allowPlayerJump = false,
    },

}

Config.OnInstallationPart = {
    ['clean'] = function(vehicle, properties)

    end,
    ['repair'] = function(vehicle, properties)
        --print('[Config.OnInstallationPart] Vehicle has been fixed.')

        -- properties['engineHealth'] = 1000.0

        exports['lorp_vehicle_handler']:repairFix(vehicle)
    end,
}