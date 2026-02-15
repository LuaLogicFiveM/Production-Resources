local maps = {
	"prompt_sandy_fire2",
	"prompt_sandy_hospital2",
	"prompt_sandy_gasstation_carwash",
	"prompt_sandy_cityhall",
	"prompt_sandy_beaches"
}

local events = {}

-- Sandy mapdata exists event
RegisterNetEvent("prompt:mapdata_exists", function(cb)
  cb(true)
end)

-- Sandy mapdata list event
RegisterNetEvent("prompt:mapdata_sendList", function(returnevent)
  TriggerEvent(returnevent, maps)
end)

-- Legacy mapdata exists event
RegisterNetEvent("lyn-mapdata:exists", function(cb)
  cb(true)
end)

-- Legacy support for individual map checks
for i = 1, #maps do
  local eventName = maps[i] .. ":mapDataExists"
  if Debug == true then
    print("Creating event: ", eventName)
  end
  local event = RegisterNetEvent(eventName, function(cb)
    cb(true)
  end)
  table.insert(events, event)
end
