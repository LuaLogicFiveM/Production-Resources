            return {names = {"libcvpist","libcvpi","lib19fpiu","lib19fpiust","libram","lib13fpiu","lib13fpiust","lib23tahoest","lib23tahoe","lib25durangost","lib18f150","lib18f150st","lib14tahoe","lib14tahoest","lib18tahoe","lib18tahoest","lib14charger","lib14chargerst","lib20durango","lib20durangost","lib25durango","lib23charger","lib18fpisst","lib23chargerst","lib18fpis","lib20fpiu","lib20fpiust"},
  steadyBurnConfig = {
    forceOn = false,
    useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = true,
    syncWith = {"libcvpist","libcvpi","lib19fpiu","lib19fpiust","libram","lib13fpiu","lib13fpiust","lib23tahoest","lib23tahoe","lib25durangost","lib18f150","lib18f150st","lib14tahoe","lib14tahoest","lib18tahoe","lib18tahoest","lib14charger","lib14chargerst","lib20durango","lib20durangost","lib25durango","lib23charger","lib23chargerst","lib18fpis","lib18fpisst","lib20fpiu","lib20fpiust"},
    pExtras = {1},
    dExtras = {2}
  },
  hornConfig = {
    useHorn = false,
    hornExtras = {},
  },
  brakeConfig = {
    useBrakes = false,
    speedThreshold = 3,
    brakeExtras = {},
    disableExtras = {}
  },
  reverseConfig = {
    useReverse = false,
    reverseExtras = {}
  },
  doorConfig = {
    useDoors = false,
    driverSide = {enable = {}, disable = {}},
    passSide = {enable = {}, disable = {}},
    trunk = {enable = {}, disable = {}}
  }, 
  buttons = {
    {label = "Prk", key = 1, color = "red", extra = 1, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
    {label = "Drve", key = 2, color = "green", extra = 2, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"fdfpiu21tr"},
  steadyBurnConfig = {
    forceOn = false,
    useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {11,12},
    dExtras = {9,10}
  },
  hornConfig = {
    useHorn = false,
    hornExtras = {},
  },
  brakeConfig = {
    useBrakes = false,
    speedThreshold = 3,
    brakeExtras = {},
    disableExtras = {}
  },
  reverseConfig = {
    useReverse = false,
    reverseExtras = {}
  },
  doorConfig = {
    useDoors = false,
    driverSide = {enable = {}, disable = {}},
    passSide = {enable = {}, disable = {}},
    trunk = {enable = {}, disable = {}}
  }, 
  buttons = {
    {label = "Prk", key = 1, color = "red", extra = 11, linkedExtras = {12}, oppositeExtras = {}, offExtras = {9,10}, repair = false},
    {label = "Drve", key = 2, color = "green", extra = 9, linkedExtras = {10}, oppositeExtras = {}, offExtras = {11,12}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"comanrb"},
  steadyBurnConfig = {
    forceOn = false, useTime = true,
    disableWithLights = true,
    sbExtras = {2}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {1},
    dExtras = {2}
  },
  hornConfig = {
    useHorn = false,
    hornExtras = {},
    disableExtras = {}
  },
  brakeConfig = {
    useBrakes = false,
    speedThreshold = 3,
    brakeExtras = {},
    disableExtras = {}
  },
  reverseConfig = {
    useReverse = false,
    reverseExtras = {},
    disableExtras = {}
  },
  doorConfig = {
    useDoors = false,
    driverSide = {enable = {}, disable = {}},
    passSide = {enable = {}, disable = {}},
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Scene", key = 1, color = "green", extra = 1, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = true},
		{label = "STDY", key = 2, color = "green", extra = 2, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = true}
  },
  stages = {
    useStages = false,
    stageKeys = {},
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"nFORCE21DUR", "nFORCE21DURST", "nFORCE21DURK9"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = false,
    useSync = false,
    syncWith = {},
    pExtras = {},
    dExtras = {}
  },
  hornConfig = {
    useHorn = false,
    hornExtras = {},
  },
  brakeConfig = {
    useBrakes = true,
    speedThreshold = 3,
    brakeExtras = {11},
    disableExtras = {4}
  },
  reverseConfig = {
    useReverse = true,
    reverseExtras = {12},
    disableExtras = {4,11}
  },
  doorConfig = {
    useDoors = false,
    driverSide = {enable = {}, disable = {}},
    passSide = {enable = {}, disable = {}},
    trunk = {enable = {}, disable = {}}
  },
  buttons = {
    {label = "MAIN", key = 1, color = "green", extra = 2, linkedExtras = {1,3,4,7,8}, oppositeExtras = {}, offExtras = {9,10}, repair = true},
    {label = "DRL", key = 2, color = "green", extra = 1, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = true},
    {label = "F-FLD", key = 3, color = "green", extra = 5, linkedExtras = {}, oppositeExtras = {2}, offExtras = {}, repair = true},
    {label = "S-ALY", key = 4, color = "green", extra = 6, linkedExtras = {}, oppositeExtras = {3}, offExtras = {}, repair = true},
    {label = "CRUSE", key = 5, color = "green", extra = 9, linkedExtras = {10}, oppositeExtras = {1,2,3,4,7,8}, offExtras = {}, repair = true},
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"nFORCE18CHRG"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = false,
    useSync = false,
    syncWith = {},
    pExtras = {},
    dExtras = {}
  },
  hornConfig = {
    useHorn = false,
    hornExtras = {},
  },
  brakeConfig = {
    useBrakes = true,
    speedThreshold = 3,
    brakeExtras = {11},
    disableExtras = {4}
  },
  reverseConfig = {
    useReverse = true,
    reverseExtras = {12},
    disableExtras = {4,5,11}
  },
  doorConfig = {
    useDoors = false,
    driverSide = {enable = {}, disable = {}},
    passSide = {enable = {}, disable = {}},
    trunk = {enable = {}, disable = {}}
  },
  buttons = {
    {label = "MAIN", key = 1, color = "green", extra = 2, linkedExtras = {1,3,4,5,8,9}, oppositeExtras = {}, offExtras = {10}, repair = true},
    {label = "DRL", key = 2, color = "green", extra = 1, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = true},
    {label = "F-FLD", key = 3, color = "green", extra = 6, linkedExtras = {}, oppositeExtras = {2}, offExtras = {}, repair = true},
    {label = "S-ALY", key = 4, color = "green", extra = 7, linkedExtras = {}, oppositeExtras = {3}, offExtras = {}, repair = true},
    {label = "CRUSE", key = 5, color = "green", extra = 10, linkedExtras = {}, oppositeExtras = {1,2,3,4,5,8,9}, offExtras = {}, repair = true},
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"nFORCE18CHRGST", "nFORCE18CHRGK9"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = false,
    useSync = false,
    syncWith = {},
    pExtras = {},
    dExtras = {}
  },
  hornConfig = {
    useHorn = false,
    hornExtras = {},
  },
  brakeConfig = {
    useBrakes = true,
    speedThreshold = 3,
    brakeExtras = {11},
    disableExtras = {4}
  },
  reverseConfig = {
    useReverse = true,
    reverseExtras = {12},
    disableExtras = {5,11}
  },
  doorConfig = {
    useDoors = false,
    driverSide = {enable = {}, disable = {}},
    passSide = {enable = {}, disable = {}},
    trunk = {enable = {}, disable = {}}
  },
  buttons = {
    {label = "MAIN", key = 1, color = "green", extra = 2, linkedExtras = {1,3,4,5,8,9}, oppositeExtras = {}, offExtras = {10}, repair = true},
    {label = "DRL", key = 2, color = "green", extra = 1, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = true},
    {label = "F-FLD", key = 3, color = "green", extra = 6, linkedExtras = {}, oppositeExtras = {2}, offExtras = {}, repair = true},
    {label = "S-ALY", key = 4, color = "green", extra = 7, linkedExtras = {}, oppositeExtras = {3}, offExtras = {}, repair = true},
    {label = "CRUSE", key = 5, color = "green", extra = 10, linkedExtras = {}, oppositeExtras = {1,2,3,4,5,8,9}, offExtras = {}, repair = true},
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
}