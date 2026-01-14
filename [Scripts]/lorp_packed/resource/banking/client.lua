CreateThread(function()
    local locations = {
        vec3(149.9499, -1040.7720, 29.3741),
        vec3(-1212.98, -330.84, 37.79),
        vec3(-2962.58, 482.63, 15.71),
        vec3(314.19, -278.62, 54.17),
        vec3(-351.53, -49.53, 49.04),
        vec3(-111.1939, 6468.2202, 31.6267),
        vec3(1174.8418, 2706.9104, 38.0940)
    }

    for i = 1, #locations do
        local bank = lib.points.new(locations[i], 2)

        function bank:onEnter()
            lib.showTextUI('[E] - Open Bank')
        end

        function bank:onExit()
            lib.hideTextUI()
        end

        function bank:nearby()
            if IsControlJustReleased(0, 38) then
                local input = lib.inputDialog('Banking', {
                    {type = 'number', label = 'Amount', required = true},
                    {type = 'select', label = 'Type', required = true, options = {
                        {label = 'Deposit', value = 'deposit'},
                        {label = 'Withdraw', value = 'withdraw'}
                    }}
                })

                if not input then return end

                TriggerServerEvent('lorp_packed:server:requestTransaction', input[2], input[1])
            end
        end
    end
end)