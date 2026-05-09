Config = {}

Config.Debug = false

Config.Item = 'notebook'

-- Allowed image URL domains (set to empty table to allow any domain)
Config.AllowedImageDomains = {
    'i.ibb.co',
    'r2.fivemanage.com',
}

Config.AttachProp = {
    objectName = "pr_notebook",
    modelHash = `pr_notebook`,
    offset = vec3(0.15, 0.03, -0.065),
    rotation = vec3(0.0, 180.0, 90.0),
    boneId = 6286,
    disableCollision = true,
    completelyDisableCollision = true,
    isWeapon = false,
}
