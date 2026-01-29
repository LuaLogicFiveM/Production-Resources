local esxDuty = nil

--- @return boolean @true if on duty, false if off duty
function tgiCore.IsOnDuty()
    if config.framework == "esx" then
        if config.esx_service then
            if esxDuty == nil then
                local p = promise.new()
                tgiCore.core.TriggerServerCallback('esx_service:isInService', function(isInService)
                    p:resolve(isInService)
                end, PlayerData.job.name)
                esxDuty = Citizen.Await(p)
            end
            return esxDuty
        else
            return true -- If there is no service script, return true for default
        end
    elseif config.framework == "qb" then
        return PlayerData.job.onduty
    end
    return nil
end

--- Toogle on/off duty
--- @return string @ dutyFull | onDuty | offDuty
function tgiCore.ToggleDuty()
    local onDuty = tgiCore.IsOnDuty()
    if onDuty == nil then return end
    if config.framework == "esx" then
        if config.esx_service then
            if onDuty then
                TriggerServerEvent('esx_service:disableService', PlayerData.job.name)
                esxDuty = false
            else
                local p = promise.new()
                -- ESX'in callback sistemi gerekli! ox lib'in callback'i ile çalışmaz!
                tgiCore.core.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
                    esxDuty = canTakeService
                    if not canTakeService then
                        Notify("dutyFull", "error")
                        return p:resolve("dutyFull")
                    end
                    p:resolve("onDuty")
                end, PlayerData.job.name)
                return Citizen.Await(p)
            end
        else
            tgiCore.DebugWarningLog("Not found any service/duty script for ESX! You can edit from 'client/functions/duty.lua'")
            return "offDuty"
        end
    elseif config.framework == "qb" then
        TriggerServerEvent('QBCore:ToggleDuty')
    end
    return onDuty and "offDuty" or "onDuty"
end
