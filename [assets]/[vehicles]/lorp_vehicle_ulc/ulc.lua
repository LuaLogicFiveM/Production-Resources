return {names = {"csucharger"},
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
  {label = "Drive Lights", key = 1, color = "green", extra = 3, linkedExtras = {11,12}, oppositeExtras = {}, offExtras = {}, repair = false},
  {label = "Day Park", key = 2, color = "green", extra = 4, linkedExtras = {5,6,11,12}, oppositeExtras = {}, offExtras = {}, repair = false},
  {label = "Night Park", key = 3, color = "green", extra = 7, linkedExtras = {11,12}, oppositeExtras = {}, offExtras = {}, repair = false},
  {label = "Flood Lights", key = 4, color = "green", extra = 8, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
  {label = "Cruise Lights", key = 5, color = "green", extra = 9, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
  {label = "LPWR Cruise", key = 6, color = "green", extra = 10, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
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
},{names = {"TCFiretruck"},
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
  trunk = {enable ={}, disable = {}}
}, 
buttons = {
  {label = "Ignore", key = 1, color = "blue", extra = 1, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
},
defaultStages = {
  useDefaults = false,
  enableKeys = {},
  disableKeys = {}
}
},{names = {"mmladder"},
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
  trunk = {enable ={}, disable = {}}
}, 
buttons = {
  {label = "Ignore", key = 1, color = "blue", extra = 1, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
},
defaultStages = {
  useDefaults = false,
  enableKeys = {},
  disableKeys = {}
}
},{names = {"wchargerbb"},
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Front", key = 1, color = "blue", extra = 2, linkedExtras = {2,3,4,5}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "Rear", key = 2, color = "blue", extra = 7, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "Whites", key = 3, color = "amber", extra = 1, linkedExtras = {6,10}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "Aux Flood", key = 4, color = "red", extra = 8, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "TKD", key = 5, color = "red", extra = 9, linkedExtras = {}, oppositeExtras = {}, offExtras = {6,5}, repair = false},
		{label = "SL", key = 6, color = "red", extra = 12, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"fpiu21tr"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {9,11},
    dExtras = {10,12}
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 10, linkedExtras = {12}, oppositeExtras = {}, offExtras = {9,11}, repair = false},
    {label = "Park", key = 2, color = "green", extra = 9, linkedExtras = {11}, oppositeExtras = {}, offExtras = {10,12}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"7675"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {1,2},
    dExtras = {3}
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 3, linkedExtras = {}, oppositeExtras = {}, offExtras = {1}, repair = false},
    {label = "Park", key = 2, color = "green", extra = 1, linkedExtras = {2}, oppositeExtras = {}, offExtras = {3}, repair = false},
    {label = "Cruise", key = 3, color = "green", extra = 4, linkedExtras = {}, oppositeExtras = {}, offExtras = {1,2,3}, repair = false},
		{label = "Flood", key = 4, color = "green", extra = 5, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"7218"},
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
    trunk = {enable ={}, disable = {}}
  },
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 3, linkedExtras = {4,5}, oppositeExtras = {}, offExtras = {6,7,8}, repair = false},
    {label = "Rear", key = 2, color = "green", extra = 4, linkedExtras = {5}, oppositeExtras = {}, offExtras = {6,7,8}, repair = false},
		{label = "Cruise", key = 3, color = "green", extra = 6, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,4,5,7,8}, repair = false},
		{label = "TKD", key = 4, color = "green", extra = 8, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"988"},
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
		{label = "Cruise", key = 1, color = "green", extra = 4, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"825"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {2},
    dExtras = {1}
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
    trunk = {enable ={}, disable = {}}
  },
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 1, linkedExtras = {}, oppositeExtras = {}, offExtras = {2,4}, repair = false},
    {label = "Park", key = 2, color = "green", extra = 2, linkedExtras = {}, oppositeExtras = {}, offExtras = {1,4}, repair = false},
    {label = "Cruise", key = 3, color = "green", extra = 4, linkedExtras = {}, oppositeExtras = {}, offExtras = {1,2}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"778"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {3,4},
    dExtras = {1,2}
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 1, linkedExtras = {2}, oppositeExtras = {}, offExtras = {2}, repair = false},
    {label = "Park", key = 2, color = "green", extra = 3, linkedExtras = {4}, oppositeExtras = {}, offExtras = {1}, repair = false},
    {label = "Cruise", key = 3, color = "green", extra = 5, linkedExtras = {}, oppositeExtras = {}, offExtras = {1,2,3,4}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"643"},
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
    {label = "Drive", key = 1, color = "green", extra = 3, linkedExtras = {4,5}, oppositeExtras = {}, offExtras = {6}, repair = false},
		{label = "Rear", key = 2, color = "green", extra = 4, linkedExtras = {}, oppositeExtras = {}, offExtras = {5,6,3}, repair = false}
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
},{names = {"556"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {2},
    dExtras = {1}
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
    useDoors = true,
    driverSide = {enable = {6}, disable = {}},
    passSide = {enable = {7}, disable = {}},
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 1, linkedExtras = {}, oppositeExtras = {}, offExtras = {2}, repair = false},
		{label = "Park", key = 2, color = "green", extra = 2, linkedExtras = {}, oppositeExtras = {}, offExtras = {1}, repair = false},
		{label = "Cruise", key = 3, color = "green", extra = 3, linkedExtras = {}, oppositeExtras = {}, offExtras = {1,2}, repair = false},
		{label = "Flood", key = 4, color = "green", extra = 4, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "Alley", key = 5, color = "green", extra = 5, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"423"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {1,2},
    dExtras = {3}
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 1, linkedExtras = {2}, oppositeExtras = {}, offExtras = {3,4,5}, repair = false},
		{label = "Park", key = 2, color = "green", extra = 3, linkedExtras = {}, oppositeExtras = {}, offExtras = {1,2,4,5}, repair = false},
    {label = "Cruise", key = 3, color = "green", extra = 4, linkedExtras = {}, oppositeExtras = {}, offExtras = {1,2,3}, repair = false},
		{label = "Flood", key = 4, color = "green", extra = 5, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"247"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {3},
    dExtras = {4}
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
    trunk = {enable ={}, disable = {}}
  },
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 4, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,5,6}, repair = false},
		{label = "Park", key = 2, color = "green", extra = 3, linkedExtras = {}, oppositeExtras = {}, offExtras = {4,5,6}, repair = false},
    {label = "Flood", key = 3, color = "green", extra = 5, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,4}, repair = false},
		{label = "Cruise", key = 4, color = "green", extra = 6, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,4}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"223"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {3,5,6,7},
    dExtras = {4,5,6,7}
  },
  hornConfig = {
    useHorn = false,
    hornExtras = {},
  },
  brakeConfig = {
    useBrakes = false,
    speedThreshold = 3,
    brakeExtras = {7},
    disableExtras = {}
  },
  reverseConfig = {
    useReverse = false,
    reverseExtras = {}
  },
  doorConfig = {
    useDoors = true,
    driverSide = {enable = {}, disable = {5}},
    passSide = {enable = {}, disable = {6}},
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 4, linkedExtras = {5,6,7}, oppositeExtras = {}, offExtras = {3,8,9,10,11,12}, repair = false},
    {label = "Park", key = 2, color = "green", extra = 3, linkedExtras = {5,6,7}, oppositeExtras = {}, offExtras = {4,8,9,10}, repair = false},
    {label = "Cruise", key = 3, color = "green", extra = 9, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,4,5,6,7,8}, repair = false},
		{label = "RL TA", key = 4, color = "green", extra = 10, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,4,5,6,8,9,11,12}, repair = false},
		{label = "LR TA", key = 5, color = "green", extra = 11, linkedExtras = {}, oppositeExtras = {}, offExtras = {12,10,9,8,3,4}, repair = false},
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"191"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {4},
    dExtras = {3,7,10,11}
  },
  hornConfig = {
    useHorn = false,
    hornExtras = {},
  },
  brakeConfig = {
    useBrakes = true,
    speedThreshold = 15,
    brakeExtras = {5},
    disableExtras = {7}
  },
  reverseConfig = {
    useReverse = false,
    reverseExtras = {}
  },
  doorConfig = {
    useDoors = false,
    driverSide = {enable = {}, disable = {}},
    passSide = {enable = {}, disable = {}},
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 3, linkedExtras = {7,10,11}, oppositeExtras = {}, offExtras = {4,8,9,10,11}, repair = false},
		{label = "Park", key = 2, color = "green", extra = 4, linkedExtras = {10,11}, oppositeExtras = {}, offExtras = {3,7,8,9,10,11}, repair = false},
		{label = "Flood", key = 3, color = "green", extra = 6, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "Cruise", key = 4, color = "green", extra = 8, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "LP Cruise", key = 5, color = "green", extra = 9, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,4,7,8,10,11}, repair = false},
		{label = "Brake", key = 6, color = "green", extra = 5, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"181"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {4},
    dExtras = {3,7}
  },
  hornConfig = {
    useHorn = false,
    hornExtras = {},
  },
  brakeConfig = {
    useBrakes = true,
    speedThreshold = 14,
    brakeExtras = {5},
    disableExtras = {7}
  },
  reverseConfig = {
    useReverse = false,
    reverseExtras = {}
  },
  doorConfig = {
    useDoors = false,
    driverSide = {enable = {}, disable = {}},
    passSide = {enable = {}, disable = {}},
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 3, linkedExtras = {7}, oppositeExtras = {}, offExtras = {6,5,8,9}, repair = false},
    {label = "Flood", key = 2, color = "green", extra = 6, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,7}, repair = false},
		{label = "Cruise", key = 3, color = "green", extra = 8, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,7,9}, repair = false},
		{label = "LP Cruise", key = 4, color = "green", extra = 9, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,7,8}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"165"},
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 3, linkedExtras = {4}, oppositeExtras = {}, offExtras = {5}, repair = false},
		{label = "Cruise", key = 2, color = "green", extra = 5, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,4}, repair = false},
		{label = "Rear", key = 3, color = "green", extra = 4, linkedExtras = {}, oppositeExtras = {}, offExtras = {5}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"134"},
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 3, linkedExtras = {4,5,6}, oppositeExtras = {}, offExtras = {7}, repair = false},
		{label = "Cruise", key = 2, color = "green", extra = 7, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,4,5,6}, repair = false},
		{label = "Flood", key = 3, color = "green", extra = 8, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "Alley", key = 4, color = "green", extra = 9, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"129charger"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {10,7},
    dExtras = {3,7}
  },
  hornConfig = {
    useHorn = false,
    hornExtras = {},
  },
  brakeConfig = {
    useBrakes = false,
    speedThreshold = 3,
    brakeExtras = {7},
    disableExtras = {}
  },
  reverseConfig = {
    useReverse = false,
    reverseExtras = {}
  },
  doorConfig = {
    useDoors = true,
    driverSide = {enable = {}, disable = {5}},
    passSide = {enable = {}, disable = {6}},
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 9, linkedExtras = {3, 7}, oppositeExtras = {}, offExtras = {4,5,6,8,9,10,11,12}, repair = false},
    {label = "Cruise", key = 2, color = "green", extra = 8, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,4,5,6,7,9}, repair = false},
		{label = "RL TA", key = 3, color = "green", extra = 10, linkedExtras = {7}, oppositeExtras = {}, offExtras = {3,4,5,6,8,9,11,12}, repair = false},
		{label = "LR TA", key = 4, color = "green", extra = 11, linkedExtras = {7}, oppositeExtras = {}, offExtras = {12,10,9,8,6,3,4,5}, repair = false},
		{label = "Flood", key = 5, color = "green", extra = 12, linkedExtras = {}, oppositeExtras = {}, offExtras = {3,4,5,6,7,8,9,10,11}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"104"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {1,3,4,5,6,10,11},
    dExtras = {2,5,6,10,11}
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Drive", key = 1, color = "green", extra = 2, linkedExtras = {5,6,10,11}, oppositeExtras = {}, offExtras = {1,3,4}, repair = false},
    {label = "Park", key = 2, color = "green", extra = 1, linkedExtras = {3,4,5,6,10,11}, oppositeExtras = {}, offExtras = {2}, repair = false},
		{label = "Cruise", key = 3, color = "green", extra = 8, linkedExtras = {}, oppositeExtras = {}, offExtras = {1,2,3,4,5,6,10,11}, repair = false},
		{label = "Flood", key = 4, color = "green", extra = 7, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "Stock", key = 5, color = "green", extra = 5, linkedExtras = {6,10,11}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"35"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = false,
    syncWith = {},
    pExtras = {1, 2, 3},
    dExtras = {}
  },
  hornConfig = {
    useHorn = false,
    hornExtras = {},
  },
  brakeConfig = {
    useBrakes = false,
    speedThreshold = 10,
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Front", key = 1, color = "green", extra = 1, linkedExtras = {}, oppositeExtras = {}, offExtras = {4}, repair = false},
		{label = "Rear", key = 2, color = "green", extra = 2, linkedExtras = {3}, oppositeExtras = {}, offExtras = {4}, repair = false},
    {label = "Brake", key = 3, color = "green", extra = 3, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "Cruise", key = 4, color = "green", extra = 4, linkedExtras = {3}, oppositeExtras = {}, offExtras = {1,2}, repair = false},
		{label = "Flood", key = 5, color = "green", extra = 5, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"21f150umbb"},
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Main", key = 1, color = "green", extra = 1, linkedExtras = {2,3,4,5,7,10}, oppositeExtras = {}, offExtras = {6,9,8}, repair = false},
		{label = "TKD", key = 2, color = "green", extra = 6, linkedExtras = {}, oppositeExtras = {}, offExtras = {3}, repair = false},
		{label = "Front Cut", key = 3, color = "green", extra = 5, linkedExtras = {7,10}, oppositeExtras = {}, offExtras = {4,3,1,2,9,8}, repair = false},
		{label = "TA Left", key = 4, color = "green", extra = 9, linkedExtras = {}, oppositeExtras = {}, offExtras = {7}, repair = false},
		{label = "TA Right", key = 5, color = "green", extra = 8, linkedExtras = {}, oppositeExtras = {}, offExtras = {7}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"87"},
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Front", key = 1, color = "green", extra = 1, linkedExtras = {6,7}, oppositeExtras = {}, offExtras = {4}, repair = false},
		{label = "Rear", key = 2, color = "green", extra = 2, linkedExtras = {3}, oppositeExtras = {}, offExtras = {4}, repair = false},
		{label = "Cruise", key = 3, color = "green", extra = 4, linkedExtras = {8,9}, oppositeExtras = {}, offExtras = {1,2}, repair = false},
		{label = "Flood", key = 4, color = "green", extra = 5, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"GoRhinoST"},
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Front", key = 1, color = "green", extra = 1, linkedExtras = {1}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "Rear", key = 2, color = "green", extra = 2, linkedExtras = {2}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "Flood", key = 3, color = "green", extra = 3, linkedExtras = {3}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"gspmustang"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = true,
    syncWith = {"gspmustang"},
    pExtras = {1,2},
    dExtras = {3,4}
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
    {label = "Park mode", key = 1, color = "blue", extra = 1, linkedExtras = {2}, oppositeExtras = {3,4}, offExtras = {3,4}, repair = false},
		{label = "Drive Mode", key = 2, color = "blue", extra = 3, linkedExtras = {4}, oppositeExtras = {1,2}, offExtras = {1,2}, repair = false},
		{label = "Cruise", key = 3, color = "blue", extra = 5, linkedExtras = {6}, oppositeExtras = {}, offExtras = {1,2,3,4}, repair = false}
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
},{names = {"gspcharger"},
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
    speedThreshold = 5,
    brakeExtras = {4},
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
		{label = "Actor", key = 1, color = "blue", extra = 6, linkedExtras = {7}, oppositeExtras = {}, offExtras = {}, repair = false},
    {label = "Cruise", key = 2, color = "blue", extra = 1, linkedExtras = {2,3,10,11}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "TKD", key = 3, color = "blue", extra = 12, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
		{label = "TA R", key = 4, color = "red", extra = 8, linkedExtras = {3}, oppositeExtras = {}, offExtras = {2,6,7,9,10,11}, repair = false},
		{label = "TA L", key = 5, color = "red", extra = 9, linkedExtras = {3}, oppositeExtras = {}, offExtras = {2,6,7,8,10,11}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
},{names = {"gsp21durangoum"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = true,
    syncWith = {"gsp21durango","128","gsp21durangoum"},
    pExtras = {1,2,3,4},
    dExtras = {5,6,7,8}
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
    {label = "Park", key = 1, color = "green", extra = 1, linkedExtras = {2,3,4}, oppositeExtras = {}, offExtras = {5,6,7,8}, repair = false},
		{label = "Drive", key = 2, color = "green", extra = 5, linkedExtras = {6,7,8}, oppositeExtras = {}, offExtras = {4,3,2,1}, repair = false},
		{label = "Cruise", key = 3, color = "green", extra = 9, linkedExtras = {10,11,12}, oppositeExtras = {}, offExtras = {1,2,3,4,5,6,7,8}, repair = false}
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
},{names = {"128"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
    disableWithLights = false,
    sbExtras = {}
  },
  parkConfig = {
    usePark = true,
    useSync = true,
    syncWith = {"128"},
    pExtras = {1},
    dExtras = {2}
  },
  hornConfig = {
    useHorn = false,
    hornExtras = {},
  },
  brakeConfig = {
    useBrakes = true,
    speedThreshold = 3,
    brakeExtras = {12},
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Park", key = 1, color = "red", extra = 1, linkedExtras = {}, oppositeExtras = {}, offExtras = {2,9,10,11}, repair = false},
		{label = "Drive", key = 2, color = "red", extra = 2, linkedExtras = {}, oppositeExtras = {}, offExtras = {1,9,10,11}, repair = false},
		{label = "Cruise", key = 3, color = "red", extra = 9, linkedExtras = {10,11}, oppositeExtras = {}, offExtras = {1,2}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
}