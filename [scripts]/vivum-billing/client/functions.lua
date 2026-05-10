-- "standalone", "lb-phone"
Mode = "standalone"

function SendAppMessage(data)
	if Mode == "lb-phone" then
		exports["lb-phone"]:SendCustomAppMessage("billing", data)
	else
		SendNUIMessage(data)
	end
end
