local holograms = {
    { coords = vec3(754.6829, 2512.1665, 73.2237), text = "~p~Leaned Out Roleplay~w~\n~g~These are common keybinds & commands~w~\n~r~The exit is ahead~w~", range = 5.0, link = 'https://discord.com/invite/lorp', key = 38, textUI = '[E] - Copy Discord Link' },
    { coords = vec3(748.8038, 2522.5710, 73.1157), text = "~p~Leaned Out Roleplay~w~\n[~g~E~w~] - ~b~discord.gg/lorp\n~w~Welcome to The ~p~City~w~!", range = 5.0, link = 'https://discord.com/invite/lorp', key = 38, textUI = '[E] - Copy Discord Link' },
}

function RotationToDirection(rotation)
    local adjustedRotation = {
        x = math.rad(rotation.x),
        y = math.rad(rotation.y),
        z = math.rad(rotation.z)
    }

    local direction = vec3(
        -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        math.sin(adjustedRotation.x)
    )

    return direction
end

local function ShowText(x, y, z, textInput, scaleX, scaleY)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vec3(px, py, pz) - vec3(x, y, z))
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = ((1 / dist) * 20) * fov

    SetTextScale(scaleX * scale, scaleY * scale)
    RegisterFontFile('BBN')
    local fontId = RegisterFontId('BBN')
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x, y, z + 2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

local function IsPlayerLookingAtCoords(cameraCoords, targetCoords)
    local camRot = GetGameplayCamRot(2)
    local camDir = RotationToDirection(camRot)
    local directionToHologram = targetCoords - cameraCoords

    directionToHologram = directionToHologram / #directionToHologram

    local dotProduct = camDir.x * directionToHologram.x + camDir.y * directionToHologram.y + camDir.z * directionToHologram.z

    return dotProduct > 0.7
end

CreateThread(function()
    RegisterFontFile('BBN')
    for _, hologramData in ipairs(holograms) do
        local holo = lib.points.new({
            coords = hologramData.coords,
            distance = hologramData.range,
            text = hologramData.text,
            link = hologramData.link,
            key = hologramData.key,
        })

        function holo:onEnter()
            if self.textUI then
                lib.showTextUI(self.textUI)
            end
        end

        function holo:onExit()
            lib.hideTextUI()
        end

        function holo:nearby()
            local cameraCoords = GetGameplayCamCoords()
            if IsPlayerLookingAtCoords(cameraCoords, self.coords) then
                ShowText(self.coords.x, self.coords.y, self.coords.z - 1.4, self.text, 0.1, 0.1)
            end

            if IsControlJustReleased(0, self.key) then
                lib.setClipboard(self.link)
                lib.notify({title = 'Spawn Point', description = 'You copied the link ('..self.link..')', type = 'success', position = 'top'})
            end
        end
    end
end)
