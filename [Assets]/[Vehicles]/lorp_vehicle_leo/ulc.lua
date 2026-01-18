--[[ 
  Ultimate Lighting Controller Config
  the ULC resource is required to use this configuration
  get the resource here: https://github.com/Flohhhhh/ultimate-lighting-controller/releases/latest
  To learn how to setup and use ULC visit here: https://docs.dwnstr.com/ulc/overview
]]
                
return {names = {"libcvpist","libcvpi","lib19fpiu","lib19fpiust","libram","lib13fpiu","lib13fpiust","lib23tahoest","lib23tahoe","lib25durangost","lib18f150","lib18f150st","lib14tahoe","lib14tahoest","lib18tahoe","lib18tahoest","lib14charger","lib14chargerst","lib20durango","lib20durangost","lib25durango","lib23charger","lib18fpisst","lib23chargerst","lib18fpis","lib20fpiu","lib20fpiust"},
  steadyBurnConfig = {
    forceOn = false, useTime = false,
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
    trunk = {enable ={}, disable = {}}
  }, 
  buttons = {
    {label = "Stage 1", key = 1, color = "blue", extra = 1, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false},
    {label = "Stage 2", key = 2, color = "blue", extra = 2, linkedExtras = {}, oppositeExtras = {}, offExtras = {}, repair = false}
  },
  defaultStages = {
    useDefaults = false,
    enableKeys = {},
    disableKeys = {}
  }
}