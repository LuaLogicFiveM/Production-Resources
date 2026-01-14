CreateThread(function()
    local url = 'https://raw.githubusercontent.com/Vyast/versions/main/queue.txt'
    local version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)

    PerformHttpRequest(url, function(status, body)
        if body and status == 200 then
            body = body:match('%d%.%d+%.%d+')
            if version < body then
                print(('^5[n4_queue]: A new version is available. ^7(Current Version: ^1%s^7, Latest Version: ^2%s^7)')
                    :format(version, body))
            end
        end
    end, 'GET')
end)
