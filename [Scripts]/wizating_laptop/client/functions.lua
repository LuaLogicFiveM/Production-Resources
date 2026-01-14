ESX = nil
QBCore = nil

------------------------------------------
------------------------------------------
-- ALL BELOW ARE EXAMPLES ONLY
-- ADD YOUR OWN LUA OR EDIT WHAT IS HERE
-- DELETE WHAT YOU DO NOT NEED
-- KEEP THE FUNCTIONS FOR REFERENCE
------------------------------------------
------------------------------------------

Citizen.CreateThread(function()

if Config.useESX then
      ESX = exports['es_extended']:getSharedObject()
elseif Config.useQB then
  QBCore = exports[Config.qbObject]:GetCoreObject()
end

end)

--Command for opening the laptop -- Edit as needed
if Config.Command then
  RegisterCommand(Config.CommandName, function(source, args)
    TriggerEvent("wizating_laptop:laptopOpen" , source)
  end)
end


if Config.restrictToESXJob then

   RegisterNetEvent('esx:playerLoaded', function(xPlayer)
     local jobname = xPlayer.job.name                             
     local jobgrade = xPlayer.job.grade
     wizatingJobCheck(jobname,jobgrade)
 end)
 
 RegisterNetEvent('esx:setJob', function(job)
   local jobname = job.name                           
   local jobgrade = job.grade                        
   wizatingJobCheck(jobname,jobgrade)
 end)
 
elseif Config.restrictToQBJob then
   RegisterNetEvent('QBCore:Client:OnJobUpdate')
   AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
     local Job = JobInfo.name                                          -- CHANGE TO HOW YOU GET THE JOB NAME FROM THE JOB DATA
     local JobGrade = JobInfo.grade.level                              -- CHANGE TO HOW YOU GET THE JOB GRADE FROM THE JOB DATA
    
     wizatingJobCheck(Job,JobGrade)
   end)
 
   RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
     local PlayerData = QBCore.Functions.GetPlayerData()
     local Job = PlayerData.job.name                                   -- CHANGE TO HOW YOU GET THE JOB NAME FROM THE PLAYER DATA
     local JobGrade = PlayerData.job.grade.level                       -- CHANGE TO HOW YOU GET THE JOB GRADE FROM THE PLAYER DATA
     wizatingJobCheck(Job,JobGrade) 
   end)
 
elseif Config.restrictToVRPJob then
   RegisterNetEvent('wizating_laptop:vrpSetJob')
   AddEventHandler('wizating_laptop:vrpSetJob', function(JobInfo)
     local jobname = JobInfo
     wizatingJobCheck(jobname) 
   end)
end

wizatingNotifs = function(type,message)
  lib.notify({title = 'Tuning Laptop', description = message, type = type, position = 'top'})
end

wizaPlates = function(value)
  if Config.PlateDebug then
    print("Your vehicles plate is: ["..value.."]")
    print("If you see no spaces, use trimmed.")
    print("If you see a space in the middle and not at the end, use spaces.")
    print("If you see a space in the middle and at the end then use mixed. (mostly for qb and esx vehicleshop users)")
    print("If you have custom plates, then use custom.")
  end
  if Config.Plates == "trimmed" then
   if not value then return nil end
   return (string.gsub(value, "%s+", ""))
  elseif Config.Plates == "spaces" then
   if not value then return nil end
   return (string.gsub(value, "^%s(.-)%s$", "%1"))
  elseif Config.Plates == "mixed" then --mixed QB/ESXVEHSHOP
    if not value then return nil end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
  else
    return tostring(value)
  end
end

