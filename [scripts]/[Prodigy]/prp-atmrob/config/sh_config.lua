SHConfig = {}

SHConfig.Debug = false

SHConfig.PoliceJobs = {
    "gsp"
}

SHConfig.ATMModels = {
    [`prop_fleeca_atm`] = {
        model = `prop_fleeca_atm`,
        hackDeviceOffset = vec3(0.33, -0.14, 0.6),
        explosiveOffset = vec3(0.0, 0.02, 1.0),
        explosiveRotation = vec3(-10.0, -5.0, 0.0),
    },
    [`prop_atm_02`] = {
        model = `prop_atm_02`,
        hackDeviceOffset = vec3(0.33, -0.14, 0.6),
        explosiveOffset = vec3(0.0, 0.02, 1.0),
        explosiveRotation = vec3(-10.0, -5.0, 0.0),
    },
    [`prop_atm_03`] = {
        model = `prop_atm_03`,
        hackDeviceOffset = vec3(0.33, -0.14, 0.6),
        explosiveOffset = vec3(0.0, 0.02, 1.0),
        explosiveRotation = vec3(-10.0, -5.0, 0.0),
    },
}

SHConfig.ExplodedModel = `prop_fleeca_atm_boom`

SHConfig.HackDeviceItem = "atm_hack_device"
SHConfig.ExplosiveItem = "atm_bomb"
SHConfig.RopeItem = "metal_rope"
