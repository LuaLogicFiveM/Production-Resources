local config = lib.load('resource.ped_spawner.shared')

local function loadMarkers()
    if not HasStreamedTextureDictLoaded('ped_markers') then
        RequestStreamedTextureDict('ped_markers', true)
        while not HasStreamedTextureDictLoaded('ped_markers') do
            Wait(100)
        end
    end
end

CreateThread(function()
    loadMarkers()
    for _, locationData in ipairs(config.peds) do
        local point = lib.points.new({
            coords = vec3(locationData.coords.x, locationData.coords.y, locationData.coords.z),
            distance = locationData.distance,
            pedData = locationData,
        })

        function point:onEnter()
            lib.requestModel(self.pedData.model)

            RequestModel(self.pedData.model)
            while not HasModelLoaded(self.pedData.model) do
                Wait(0)
            end

            local pedModel = CreatePed(0, self.pedData.model, self.pedData.coords.x, self.pedData.coords.y, self.pedData.coords.z-1.0, self.pedData.coords.w, true, true)

            FreezeEntityPosition(pedModel, true)
            SetEntityInvincible(pedModel, true)
            SetEntityCollision(pedModel, false, false)
            SetBlockingOfNonTemporaryEvents(pedModel, true)
            GiveWeaponToPed(pedModel, self.pedData.weapon, 0, false, true)
            SetCurrentPedWeapon(pedModel, self.pedData.weapon, true)
            SetPedCurrentWeaponVisible(pedModel, true, false, false, false)
            SetModelAsNoLongerNeeded(self.pedData.model)
            self.ped = pedModel
        end

        function point:onExit()
            DeletePed(self.ped)
        end

        function point:nearby()
            DrawMarker(self.pedData.type, self.pedData.coords.x, self.pedData.coords.y, self.pedData.coords.z+1.0, self.pedData.direction.x, self.pedData.direction.y, self.pedData.direction.z, self.pedData.rotation.x, self.pedData.rotation.y, self.pedData.rotation.z, self.pedData.scale.x, self.pedData.scale.y, self.pedData.scale.z, self.pedData.color.r, self.pedData.color.g, self.pedData.color.b, self.pedData.color.a, self.pedData.bobUpAndDown, self.pedData.faceCamera, self.pedData.rotationOrder, self.pedData.rotate, self.pedData.textureDict, self.pedData.textureName, false)
        end
    end
end)