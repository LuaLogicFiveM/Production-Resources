---@docus: Please refer to our resource documentation for assistance with configuring this resource: docs.zeadevelopment.com.

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------

return {
    ---@section tanks
    ---@description: This table facilitates the configuration of the vehicles' foam and water tanks.
    ['tanks'] = {
        canCarryWater = true,
        canCarryFoam = true,

        ['water'] = {start = 1800.0, capacity = 1800.0}, ---|> Measured in liters
        ['foam'] = {start = 200.0, capacity = 200.0}, ---|> Measured in liters
    },

    ---@section panelOffset
    ---@description: This parameter enables the configuration of the panel interaction position on the vehicle.
    panelOffset = vector3(0.9, 0.5, 0.75),

    ---@section valves
    ---@description: This table facilitates the addition and configuration of valves, including intakes and discharges, along with their offsets.
    ['valves'] = {
        intakes = {
            -- # Index Start # --
            {
                label = 'Pump Intake',
                offset = vector3(0.9, 0.5, 0.1)
            },
            -- # Index End # --
            -- # Index Start # --
            {
                label = 'Rear Intake',
                offset = vector3(0.56, -3.679997, 0.04)
            }
            -- # Index End # --
        },

        discharges = {
            -- # Index Start # --
            {
                label = 'Rear Attack Line',
                offset = vector3(0.1, 0.0, 0.6),
                type = 'water&foam' ---|> 'water' | 'foam' | 'water&foam' | 'relay'
            },
            -- # Index End # --
            -- # Index Start # --
            {
                label = 'Rear Discharge',
                offset = vector3(-0.58, -3.759997, -0.04),
                type = 'relay' ---|> 'water' | 'foam' | 'water&foam' | 'relay'
            }
            -- # Index End # --
        }
    },

    ---@section misc
    ---@description: This table facilitates the customization of the vehicle page data within the Pump UI.
    ['misc'] = {
        ---@param vehicle integer
        ---@return boolean
        areLockersOpen = function(vehicle)
            local extras = {1}
            local isOpen = false

            for _, extra in pairs(extras) do
                if DoesExtraExist(vehicle, extra) then
                    if IsVehicleExtraTurnedOn(vehicle, extra) then isOpen = true break end
                end
            end

           return isOpen
        end,

        ---@param vehicle integer
        ---@return boolean | nil
        areEmergencyLightsOn = function(vehicle)
            return IsVehicleSirenOn(vehicle)
        end,

        ---@param vehicle integer
        ---@return boolean | nil
        areSceneLightsOn = function(vehicle)
            local extras = {11}
            local isOn = false

            for _, extra in pairs(extras) do
                if DoesExtraExist(vehicle, extra) then
                    if IsVehicleExtraTurnedOn(vehicle, extra) then isOn = true break end
                end
            end

           return isOn
        end,

        ---@param vehicle integer
        ---@return boolean | nil
        isAdvisorLightOn = function(vehicle)
            local extras = {12}
            local isOn = false

            for _, extra in pairs(extras) do
                if DoesExtraExist(vehicle, extra) then
                    if IsVehicleExtraTurnedOn(vehicle, extra) then isOn = true break end
                end
            end

           return isOn
        end
    }
}

------------- # ------------- # ------------- # ------------- # ------------- # ------------- # ------------- # -------------