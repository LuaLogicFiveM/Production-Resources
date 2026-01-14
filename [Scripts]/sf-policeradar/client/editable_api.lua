local lastPlate = nil
local boloPlates = {}

function OnPlateChange(plate, isFront)
    if(plate ~= lastPlate) then
        return boloPlates[tostring(plate)]
    end
    return false
end

function OnPlateLock(plate, isFront)
    if(plate ~= lastPlate) then
        return boloPlates[tostring(plate)]
    end
    return false
end

function SetBoloPlate(plate, state)
    -- set to nil otherwise to save some memory
    boloPlates[tostring(plate)] = state and true or nil
end

function SetAllBoloPlates(plates)
    boloPlates = plates
end

exports("SetBoloPlate", SetBoloPlate)
exports("SetAllBoloPlates", SetAllBoloPlates)

if(Config.DevMode) then
    RegisterCommand("addboloplate", function(source, args)
        boloPlates[args[1]] = true
    end, false)
end