RegisterNetEvent('lorp_businesses:setProductPrice', function(shop, slot)
    local input = lib.inputDialog(Strings.sell_price, {Strings.amount_input})
    local price = not input and 0 or tonumber(input[1]) --[[@as number]]
    price = price < 0 and 0 or price

    TriggerEvent('ox_inventory:closeInventory')
    TriggerServerEvent('lorp_businesses:setData', shop, slot, math.floor(price))
    lib.notify({
        title = Strings.success,
        description = (Strings.item_stocked_desc):format(price),
        type = 'success'
    })
end)

CreateThread(function()
    local textUI, points = nil, {}
    while not PlayerLoaded do Wait(500) end
    for k,v in pairs(Config.Shops) do
        if not points[k] then points[k] = {} end
        points[k].stash = lib.points.new({
            coords = v.stash.coords,
            distance = v.stash.range,
            shop = k
        })
        points[k].shop = lib.points.new({
            coords = v.shop.coords,
            distance = v.shop.range,
            shop = k
        })
    end

    for _, v in pairs(points) do
        function v.stash:nearby()
            if not self.isClosest or PlayerData.job.name ~= self.shop then return end
            if Config.DrawMarkers then
                DrawMarker(2, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 30, 150, 30, 222, false, false, 0, true, false, false, false)
            end
            if self.currentDistance < self.distance then
                if not textUI then
                    lib.showTextUI(Config.Shops[self.shop].stash.string)
                    textUI = true
                end
                if IsControlJustReleased(0, 38) then
                    exports.ox_inventory:openInventory('stash', self.shop)
                end
            end
        end

        function v.stash:onExit()
            if not self.isClosest then return end
            if textUI then
                lib.hideTextUI()
                textUI = nil
            end
        end

        function v.shop:nearby()
            if not self.isClosest then return end
            if Config.DrawMarkers then
                DrawMarker(2, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 30, 150, 30, 222, false, false, 0, true, false, false, false)
            end
            if self.currentDistance < self.distance then
                if not textUI then
                    lib.showTextUI(Config.Shops[self.shop].shop.string)
                    textUI = true
                end
                if IsControlJustReleased(0, 38) then
                    exports.ox_inventory:openInventory('shop', { type = self.shop, id = 1 })
                end
            end
        end

        function v.shop:onExit()
            if not self.isClosest then return end
            if textUI then
                lib.hideTextUI()
                textUI = nil
            end
        end
    end
end)