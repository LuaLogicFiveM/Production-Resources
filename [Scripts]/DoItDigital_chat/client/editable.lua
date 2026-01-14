function FrameworkClient.getPlayerData()
    if Framework == "ESX" then
        return ESX.GetPlayerData()
    elseif Framework == "QBCore" then --same for QBox
        return QBCore.Functions.GetPlayerData()
    else
        -- Your code here for standalone mode or custom framework
        return {}
    end
end

function FrameworkClient.getJobName()
    local data = FrameworkClient.getPlayerData()
    if Framework == "QBCore" then --same for QBox
        return data.job and data.job.name or "unknown"
    elseif Framework == "ESX" then
        return data.job and data.job.name or "unknown"
    end
    -- Your code here for standalone mode or custom framework
    return "unknown"
end

function FrameworkClient.isStaff()
    return amIstaff
    -- we use a basic check here (see server/editable.lua isAdmin), but you can add your own logic
    -- to check if the player is a staff member
    -- for example, checking if the player has a specific job or permission
    -- or if they are in a specific group
    --dont hesitate to ask for help if you need it
end

function canReadThisChat(channel)
    --see codeSnippets.lua for examples
    --this function is called when a player sends a message
    --you can use this to check if the player has access to the chat chanel
    --you can create your own logic on top of our chat sytem to suit your needs
    --for example, you can check if the player is in a specific job or group
    --or if they are in a specific location
    --or if they are in a specific vehicle
    --or if they are in a specific area
    --or if they are in a specific job
    --or if they are in a specific group
    --EXAMPLE
    -- if channel == "pd" then
    --     local playerData = FrameworkClient.getPlayerData()
    --     if playerData.job and playerData.job.name ~= "police" then
    --         return false
    --     end
    --end
    --disable police to see anon chat
    -- if channel == "anon" then
    --     local playerData = FrameworkClient.getPlayerData()
    --     if playerData.job and playerData.job.name == "police" then
    --         return false
    --     end
    --end
    return true
end

--SETTINGS AND FUNCTION TO SHOW CHAT TEXT ABOVE SENDERS HEAD

local nbrDisplaying = 1 --Dont change this
-- Settings
local color = { r = 255, g = 255, b = 255, alpha = 255 } -- Color of the text 
local font = 0 -- Font of the text
local time = 4000 -- Duration of the display of the text : 1000ms = 1sec
local enableBackgroundColor = true
local dropShadow = true
function showTextAboveHead(msg,ped,bgcolor)
    local displaying = true
    
    local offset = 1 + (nbrDisplaying*0.14)
    local time = 4000 -- Duration of the display of the text : 1000ms = 1sec
    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        
		while displaying do
            Wait(0)
            local coords = GetEntityCoords(ped, false)
			DrawText3D(coords['x'], coords['y'], coords['z']+offset, msg,bgcolor)
        end
		
        nbrDisplaying = nbrDisplaying - 1
    end)

end
function DrawText3D(x,y,z, text,bgcolor)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

    if onScreen then

        -- Formalize the text
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextCentre(true)
        if dropShadow then
            SetTextDropshadow(10, 100, 100, 100, 255)
        end

        -- Calculate width and height
        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.55*scale, font)
        local width = EndTextCommandGetWidth(font)

        -- Diplay the text
        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)

        if enableBackgroundColor then
            local alpha = 200
            DrawRect(_x, _y+scale/45, width, height, bgcolor[1], bgcolor[2], bgcolor[3] , alpha)
        end
    end
end