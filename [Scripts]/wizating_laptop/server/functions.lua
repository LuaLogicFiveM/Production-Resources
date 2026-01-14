ESX = nil 
QBCore = nil
Tunnel = ""
Proxy = ""
vRP = ""

vRPclient = ""
vRPpc = {}
vRPpcC = ""


------------------------------------------
------------------------------------------
-- ALL BELOW ARE EXAMPLES ONLY
-- ADD YOUR OWN LUA OR EDIT WHAT IS HERE
-- DELETE WHAT YOU DO NOT NEED
-- KEEP THE FUNCTIONS FOR REFERENCE
------------------------------------------
------------------------------------------

if Config.useESX then
  ESX = exports['es_extended']:getSharedObject()
elseif Config.useQB then
  QBCore = exports[Config.qbObject]:GetCoreObject()
elseif Config.useVRP then
  Tunnel = module("vrp", "lib/Tunnel")
  Proxy = module("vrp", "lib/Proxy")
  vRP = Proxy.getInterface("vRP")
  vRPclient = Tunnel.getInterface("vRP","wizating_laptop")
  vRPpc = {}
  Tunnel.bindInterface("wizating_laptop",vRPpc)
  Proxy.addInterface("wizating_laptop",vRPpc)
  vRPpcC = Tunnel.getInterface("wizating_laptop","wizating_laptop")
end

wizatingNotifs = function(source,type,message) --- DONT RENAME THIS FUNCTION
  lib.notify(source, {title = 'Tuning Laptop', description = message, type = type, position = 'top'})
  --exports['wizating_notify']:wizating_notify_servermsg(source, type, message, 3500) --GET OUR NOTIFY HERE https://store.wizating.com/package/6512110
end

local drag_strips = {
  vec3(-2655.1777, 3231.4644, 32.8118),
  vec3(2737.2234, 4922.6118, 30.6787),
  vec3(4074.2888, 5263.6216, 23.9877),
  vec3(-3180.4773, 4409.3726, 27.5184),
  vec3(-2028.9977, -505.9415, 12.2082),
  vec3(2276.6951, -3188.9204, 22.8168)
}

RegisterCommand('tune', function(source)
  local pCoords = GetEntityCoords(GetPlayerPed(source))
  for _,dCoords in pairs(drag_strips) do
    if #(pCoords - dCoords) < 300.0 then
      TriggerClientEvent("wizating_laptop:laptopOpen" , source)
    end
  end
end, true)

if Config.useESXitem then
    ESX.RegisterUsableItem(Config.ItemName, function(source)
          TriggerClientEvent('wizating_laptop:laptopOpen', source)
    end)
    
   ESX.RegisterServerCallback('wizating_laptop:hasitem', function(source, cb)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local amount = 1
    local sourceItem = sourceXPlayer.getInventoryItem(Config.ItemName)
    if sourceItem.count >= amount then
      cb(true)
    else
      cb(false)
    end
   end)
elseif Config.useQBitem then
    QBCore.Functions.CreateUseableItem(Config.ItemName, function(source, item)
      local Player = QBCore.Functions.GetPlayer(source)
      if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent('wizating_laptop:laptopOpen', source)
      end
    end)

elseif Config.useVRP then
    RegisterServerEvent('wizating_laptop:vrpOpenCheck')
    AddEventHandler('wizating_laptop:vrpOpenCheck', function()
      thePlayer = source
        ide = vRP.getUserId({thePlayer})
      if Config.restrictToVRPJob then
        if vRP.hasGroup({ide,Config.JobRole}) then
          TriggerClientEvent('wizating_laptop:vrpSetJob', source, Config.JobRole)
        else
          local jobrole = Config.JobRole
          wizatingNotifs('inform','You need to be a '..jobrole..' to use the laptop!')
        end
      end
  
      if Config.useVRPitem then
        if vRP.getInventoryItemAmount({ide,"Tuner Laptop"}) >= 1 then
         TriggerClientEvent('wizating_laptop:vrpOpen', source)
        else
          wizatingNotifs('error', 'You do not have the required item to use this!')
        end 
      else
        TriggerClientEvent('wizating_laptop:vrpOpen', source)
      end
  
    end)
end

wizatingPlayerCheck = function(player)
  local id = nil
  if Config.useESX then
      local xPlayer = ESX.GetPlayerFromId(player)
      id = xPlayer.identifier
  elseif Config.useQB then
      local Player = QBCore.Functions.GetPlayer(player)
      id = Player.PlayerData.citizenid
  elseif Config.useVRP then
      id = vRP.getUserId({player})
  else
      id = GetPlayerIdentifier(player)
  end
  return id
end