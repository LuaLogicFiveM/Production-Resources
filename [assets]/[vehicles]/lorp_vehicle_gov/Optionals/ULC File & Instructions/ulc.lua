
--[[ 
  Ultimate Lighting Controller Config
  the ULC resource is required to use this configuration
  get the resource here: https://github.com/Flohhhhh/ultimate-lighting-controller/releases/latest
  To learn how to setup and use ULC visit here: https://docs.dwnstr.com/ulc/overview
]]
                
return {names = {"comanrb"},
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
}