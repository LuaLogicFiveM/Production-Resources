
_G.GetGRP = function()
    return exports['grp_bridge']:GetGRP()
end

CreateThread(function()
    local attempts = 0
    while attempts < 100 do
        local success, grp = pcall(function()
            return exports['grp_bridge']:GetGRP()
        end)
        
        if success and grp then
            _G.GRP = grp
            break
        end
        
        Wait(100)
        attempts = attempts + 1
    end
end)
