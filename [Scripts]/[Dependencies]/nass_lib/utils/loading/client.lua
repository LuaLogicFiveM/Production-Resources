
function nass.loadModel(model)
	if type(model) ~= "number" then
		model = joaat(model)
	end
	local startTime = GetGameTimer()
	while not HasModelLoaded(model) do
		RequestModel(model)
		Wait(0)
		if GetGameTimer() - startTime > 3000 then
			break
		end
	end
	return model
end

function nass.requestAnimDict(dict)
    if not DoesAnimDictExist(dict) then return end
    if HasAnimDictLoaded(dict) then return dict end
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end