local speedLimit = 200.0
local warningDisplayed = false

CreateThread(function()
    while true do
        Wait(1500)
        if cache.vehicle then
            local speed = GetEntitySpeed(cache.vehicle) * 2.236936
            if speed > speedLimit then
                if not warningDisplayed then
                    warningDisplayed = true
                    lib.showTextUI('Warning !!!  \n Server Speed Limit: 200 MPH', {
                        position = "top-center",
                        icon = 'car',
                        style = {
                            borderRadius = 5,
                            backgroundColor = 'FFFF0000',
                            color = 'white'
                        }
                    })
                end
            else
                if warningDisplayed then
                    warningDisplayed = false
                    lib.hideTextUI()
                end
            end
        else
            if warningDisplayed then
                warningDisplayed = false
                lib.hideTextUI()
            end
        end
    end
end)