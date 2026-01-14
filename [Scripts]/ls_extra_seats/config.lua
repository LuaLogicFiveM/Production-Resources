Config = {}

Config.debugMode = {
    enabled = false                   --Debugging mode, so outputs of the script are visible to everyone. 
}                                    --Strictly do not run on live server with this option turned on

Config.target = {
    enabled = true,
    system = 'ox_target',            --'qtarget' or 'qb-target or 'ox_target' (Other systems might work as well)
    updateTime = 7500                --Adding targeting to vehicle update time, lowering the time may cause into increased resources          
}

Config.doorLock = {
    enabled = true                  --If enabled and pickup is locked, player cannot sit in the trunk
}

Config.performanceMode = {           
    enabled = true                  --By disabling this option, resource monitor is going a bit higher, but aiming animation is more smooth.
}

Config.accelerationThreshold = 75.0  --Adjust the difference between momentum speed and crashing moment speed difference to detach the player from their seat

Config.enableVelocity = true         --When colliding with something at a higher speed, the player is thrown from their seat. (Adjust as needed)

Config.pickupTruckModels = {
    ['Mikes7.3'] = {
        { offset = { 0.1, -0.8, 1.0 }, detect = { -0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.8, -0.8, 1.0 }, detect = { 0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.1, -2.4, 1.0 }, detect = { -0.4, -2.7, 0.2 }, boneName = 'seat_dside_r'  },
        { offset = { 0.8, -2.4, 1.0 }, detect = { 0.4, -2.7, 0.2 }, boneName = 'seat_dside_r'  }, 
    },
    ['SANDKING'] = {
        { offset = { 0.1, -0.8, 1.0 }, detect = { -0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.8, -0.8, 1.0 }, detect = { 0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.1, -2.4, 1.0 }, detect = { -0.4, -2.7, 0.2 }, boneName = 'seat_dside_r'  },
        { offset = { 0.8, -2.4, 1.0 }, detect = { 0.4, -2.7, 0.2 }, boneName = 'seat_dside_r'  }, 
    },
    ['SANDKING2'] = {
        { offset = { -0.4, -1.2, 1.6 }, detect = { -0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.5, -1.2, 1.6 }, detect = { 0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { -0.4, -2.4, 1.6 }, detect = { -0.4, -2.7, 0.2 }, boneName = 'seat_dside_r'  },
        { offset = { 0.4, -2.4, 1.6 }, detect = { 0.4, -2.7, 0.2 }, boneName = 'seat_dside_r'  }, 
    },
    ['BISON'] = {
        { offset = { 0.1, -1.4, 1.0 }, detect = { -0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.7, -1.4, 1.0 }, detect = { 0.4, -1.4, 0.2 },  boneName = 'seat_dside_r'  }, 
        { offset = { 0.2, -2.0, 1.0 }, detect = { -0.4, -2.2, 0.2 }, boneName = 'seat_dside_r'  },
        { offset = { 0.7, -2.0, 1.0 }, detect = { 0.4, -2.2, 0.2 }, boneName = 'seat_dside_r'  }, 
    },
    ['DUBSTA3'] = {
        { offset = { 0.1, -1.25, 0.825 }, detect = { -0.5, -2.0, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.6, -1.25, 0.825 }, detect = { 0.4, -2.0, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.1, -2.2, 0.825 }, detect = { -0.5, -2.8, 0.2 }, boneName = 'seat_dside_r'  },
        { offset = { 0.6, -2.2, 0.825 }, detect = { 0.4, -2.8, 0.2 }, boneName = 'seat_dside_r'  }, 
    },
    ['REBEL'] = {
        { offset = { -0.25, -0.85, 1.3 }, detect = { -0.4, -1.0, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.25, -0.85, 1.3 }, detect = { 0.4, -1.0, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { -0.25, -1.9, 1.3 }, detect = { -0.4, -2.0, 0.2 }, boneName = 'seat_dside_r'  },
        { offset = { 0.25, -1.9, 1.3 }, detect = { 0.4, -2.0, 0.2 }, boneName = 'seat_dside_r'  }, 
    },
    ['REBEL2'] = {
        { offset = { -0.25, -0.85, 1.3 }, detect = { -0.4, -1.0, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.25, -0.85, 1.3 }, detect = { 0.4, -1.0, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { -0.25, -1.9, 1.3 }, detect = { -0.4, -2.0, 0.2 }, boneName = 'seat_dside_r'  },
        { offset = { 0.25, -1.9, 1.3 }, detect = { 0.4, -2.0, 0.2 }, boneName = 'seat_dside_r'  }, 
    },
    ['KAMACHO'] = {
        { offset = { 0.1, -1.0, 0.85 }, detect = { -0.4, -1.4, 0.2 }, boneName = 'seat_dside_r' }, 
        { offset = { 0.8, -1.0, 0.85 }, detect = { 0.4, -1.4, 0.2 }, boneName = 'seat_dside_r' }, 
        { offset = { 0.1, -1.8, 0.85 }, detect = { -0.4, -2.3, 0.2 }, boneName = 'seat_dside_r' },
        { offset = { 0.8, -1.8, 0.85 }, detect = { 0.4, -2.3, 0.2 }, boneName = 'seat_dside_r' }, 
    },
    ['BODHI2'] = {
        { offset = { 0.1, -1.5, 0.9 }, detect = { -0.4, -1.2, 0.2 }, boneName = 'seat_dside_f'  }, 
        { offset = { 0.7, -1.5, 0.9 }, detect = { 0.4, -1.2, 0.2 }, boneName = 'seat_dside_f'  }, 
        { offset = { 0.1, -2.4, 0.9 }, detect = { -0.4, -2.3, 0.2 }, boneName = 'seat_dside_f'  },
        { offset = { 0.7, -2.4, 0.9 }, detect = { 0.4, -2.3, 0.2 }, boneName = 'seat_dside_f'  }, 
    },
    ['SADLER'] = {
        { offset = { 0.1, -1.2, 0.8 }, detect = { -0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.8, -1.2, 0.8 }, detect = { 0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.1, -2.3, 0.8 }, detect = { -0.4, -2.4, 0.2 }, boneName = 'seat_dside_r'  },
        { offset = { 0.8, -2.3, 0.8 }, detect = { 0.4, -2.4, 0.2 }, boneName = 'seat_dside_r'  }, 
    },
    ['BOBCATXL'] = {
        { offset = { -0.4, -1.2, 1.0 }, detect = { -0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.3, -1.2, 1.0 }, detect = { 0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { -0.4, -2.6, 1.0 }, detect = { -0.4, -2.5, 0.2 }, boneName = 'seat_dside_r'  },
        { offset = { 0.3, -2.6, 1.0 }, detect = { 0.4, -2.5, 0.2 }, boneName = 'seat_dside_r'  }, 
    },
    ['PICADOR'] = {
        { offset = { -0.4, -1.2, 0.8 }, detect = { -0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.3, -1.2, 0.8 }, detect = { 0.4, -1.4, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { -0.4, -2.1, 0.8 }, detect = { -0.4, -2.2, 0.2 }, boneName = 'seat_dside_r'  },
        { offset = { 0.3, -2.1, 0.8 }, detect = { 0.4, -2.2, 0.2 }, boneName = 'seat_dside_r'  }, 
    },
    ['YOSEMITE'] = {
        { offset = { -0.4, -0.9, 1.1 }, detect = { -0.4, -1.1, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.3, -0.9, 1.1 }, detect = { 0.4, -1.1, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { -0.4, -1.8, 1.1 }, detect = { -0.4, -1.9, 0.2 }, boneName = 'seat_dside_r'  },
        { offset = { 0.3, -1.8, 1.1 }, detect = { 0.4, -1.9, 0.2 }, boneName = 'seat_dside_r'  }, 
    },
    ['YOSEMITE2'] = {
        { offset = { -0.4, -0.9, 1.1 }, detect = { -0.4, -1.1, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { 0.3, -0.9, 1.1 }, detect = { 0.4, -1.1, 0.2 }, boneName = 'seat_dside_r'  }, 
        { offset = { -0.4, -1.8, 1.1 }, detect = { -0.4, -1.9, 0.2 }, boneName = 'seat_dside_r'  },
        { offset = { 0.3, -1.8, 1.1 }, detect = { 0.4, -1.9, 0.2 }, boneName = 'seat_dside_r'  }, 
    },
    ['SQUADDIE'] = {
        { offset = { 0.2, -1.0, 0.8 }, detect = { -0.4, -1.0, 0.2 }, boneName = 'seat_dside_f'  }, 
        { offset = { 0.9, -1.0, 0.8 }, detect = { 0.4, -1.0, 0.2 }, boneName = 'seat_dside_f'  }, 
        { offset = { 0.2, -2.1, 0.8 }, detect = { -0.4, -2.1, 0.2 }, boneName = 'seat_dside_f'  },
        { offset = { 0.9, -2.1, 0.8 }, detect = { 0.4, -2.1, 0.2 }, boneName = 'seat_dside_f'  }, 
    },
    ['CONTENDER'] = {
        { offset = { 0.2, -2.2, 0.8 }, detect = { -0.4, -1.2, 0.2 }, boneName = 'seat_dside_f'  }, 
        { offset = { 0.9, -2.2, 0.8 }, detect = { 0.4, -1.2, 0.2 }, boneName = 'seat_dside_f'  }, 
        { offset = { 0.2, -3.1, 0.8 }, detect = { -0.4, -2.3, 0.2 }, boneName = 'seat_dside_f'  },
        { offset = { 0.9, -3.1, 0.8 }, detect = { 0.4, -2.3, 0.2 }, boneName = 'seat_dside_f'  }, 
    },
}
