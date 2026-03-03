function HelpText(textInfo, coords, time, replacement)
    local text = textInfo.text
    local replaceTextType = ""
    if textInfo.displayType == "3DText" or textInfo.displayType == "subtitles" then
        replaceTextType = "TextDisplay3d"
    elseif textInfo.displayType == "topRightDisplay" then
        replaceTextType = "inputIcon"
    end
        
    for _, replace in pairs(replacement) do
        if replace["input"][replaceTextType] == nil then
            text = text:gsub(replace["string"], replace["input"])
        else
            text = text:gsub(replace["string"], replace["input"][replaceTextType])
        end
    end
    HelpTextReciever(text, coords, time, textInfo.displayType)
end

function HelpTextReciever(text, coords, time, displayType)
    if time ~= nil then
        if displayType == "3DText" then
            Citizen.CreateThread(function()
                local drawText = time
                Citizen.CreateThread(function()
                    while drawText > 0 do
                        Citizen.Wait(1)
                        if coords == nil then
                            local playerPed = PlayerPedId()
                            local coords2 = GetEntityCoords(playerPed)
                            coords2 = vector3(coords2.x, coords2.y, coords2.z + 0.2)
                            Draw3DText(coords2.x, coords2.y, coords2.z, text, 4, 0.04, 0.04)
                        else
                            Draw3DText(coords.x, coords.y, coords.z, text, 4, 0.04, 0.04)
                        end
                    end
                end)
                while drawText > 0 do
                    drawText = drawText - 1
                    Citizen.Wait(1000)
                end
            end)
        elseif displayType == "subtitles" then 
            drawSubtitles(text, time*1000)
        elseif displayType == "topRightDisplay" then
            DisplayHelpText(text)
        end
    else
        if displayType == "3DText" then
            if coords == nil then
                local playerPed = PlayerPedId()
                local coords2 = GetEntityCoords(playerPed)
                coords2 = vector3(coords2.x, coords2.y, coords2.z + 0.2)
                Draw3DText(coords2.x, coords2.y, coords2.z, text, 4, 0.04, 0.04)
            else
                Draw3DText(coords.x, coords.y, coords.z, text, 4, 0.04, 0.04)
            end
        elseif displayType == "subtitles" then 
            drawSubtitles(text, 2)
        elseif displayType == "topRightDisplay" then
            DisplayHelpText(text)
        end
    end

end

function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
    local scaleX = scaleX * 1.5
    local scaleY = scaleY * 1.5
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    local scale = (1 / dist) * 20
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    SetTextScale(scaleX * scale, scaleY * scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end



function DisplayHelpText(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(0.5, 0.5)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
    
end

function drawSubtitles(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    EndTextCommandPrint(time, true)
end