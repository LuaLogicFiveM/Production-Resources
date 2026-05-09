lib.locale()

if not IsDuplicityVersion() then return end
SetConvarReplicated(("ox:printlevel:%s"):format(GetCurrentResourceName()), config.debug and "debug" or "info")
