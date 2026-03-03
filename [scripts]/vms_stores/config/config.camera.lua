-- ▄▀▀ ▄▀▄ █▄ ▄█ ██▀ █▀▄ ▄▀▄
-- ▀▄▄ █▀█ █ ▀ █ █▄▄ █▀▄ █▀█

-- @UseCamera: Possibility to use cameras
Config.UseCamera = true

-- @CameraAbilityNightVision: Ability to run night vision on cameras
Config.CameraAbilityNightVision = true

Config.Camera = {
    FOV = 80.0, -- Camera Field of View
    MaxZoom = 30,
    MinZoom = 100,
    MaxUpRotation = 10,
    MaxDownRotation = -45,
    RotateSpeed = 0.3, -- Camera Rotation Speed
    Controls = {
        Up = 32, -- W
        Down = 33, -- S
        Left = 34, -- A
        Right = 35, -- D
        ZoomIn = 96, -- Scroll Up
        ZoomOut = 97, -- Scroll Down
        Previous = 174, -- Left Arrow
        Next = 175, -- Right Arrow
        NightVision = 38, -- E
        Exit = 194 -- BACKSPACE
    }
}