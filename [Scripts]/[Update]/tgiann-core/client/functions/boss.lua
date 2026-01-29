--- @return boolean @true if player is boss, false if not
tgiCore.isBoss = function(job)
    if job and job ~= PlayerData.job.name then return end
    return PlayerData.job.boss or PlayerData.job.isboss or (PlayerData.job.grade_name and PlayerData.job.grade_name == "boss")
end

--- Open boss menu for player job
tgiCore.OpenBossMenu = function()
    if not tgiCore.isBoss() then return end
    if config.tgiannServer then
        TriggerEvent('esx_society:openBossMenu', PlayerData.job.name, function(_, menu)
            menu.close()
        end, { wash = false })
    else
        if config.framework == "esx" then
            TriggerEvent('esx_society:openBossMenu', PlayerData.job.name, function() end, { wash = false })
        elseif config.framework == "qb" then
            TriggerEvent("qb-bossmenu:client:OpenMenu")
        end
    end
end
