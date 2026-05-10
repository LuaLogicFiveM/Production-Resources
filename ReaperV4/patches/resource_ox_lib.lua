---@diagnostic disable: undefined-global
-- ox_lib lib:progressProps patch version 1.0.0

local IsDuplicityVersion <const> = IsDuplicityVersion

if IsDuplicityVersion() then
   local SetStateBagKeyProtected <const> = ReaperAC.API.SetStateBagKeyProtected

   SetStateBagKeyProtected("lib:progressProps")
end