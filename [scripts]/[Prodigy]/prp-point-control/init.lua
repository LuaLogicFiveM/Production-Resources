lib.locale()

if not IsDuplicityVersion() then return end
SetConvarReplicated(("ox:printlevel:%s"):format(GetCurrentResourceName()), MainConfig.Debug and "debug" or "info")