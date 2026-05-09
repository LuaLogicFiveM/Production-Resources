SvConfig = {}

-- how long until a device deletes itself
SvConfig.DeviceLifeLength = 8 -- [[ hours ]]

SvConfig.Items = {
    securityCamera = "security_camera",
    motionSensor = "motion_sensor",
    destroyTool = "privacy_tool"
}

SvConfig.ItemToDeviceType = {
    [SvConfig.Items.securityCamera] = DEVICE_TYPES.Camera
}

SvConfig.ShowAllCommand = {
    name = "show_all_security",
    permission = "group.owner"
}

SvConfig.DevicesCommand = {
    name = "devices"
}
