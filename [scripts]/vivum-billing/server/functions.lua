function SearchQuery(subjects, query)
	for i = 1, #subjects do
		local subject = subjects[i]

		if subject then
			local factors = {
				subject.id or "",
				subject.charid or "",
				subject.citizenid or "",
				subject.cid or "",
				subject.identifier or "",
				subject.playerId or "",
				subject.name or "",
				subject.firstname or "",
				subject.lastname or "",
				subject.label or "",
			}

			for idx = 1, #factors do
				local factor = factors[idx]

				if factor and type(factor) == "string" and string.find(string.lower(factor), string.lower(query)) then
					return true
				end
			end
		end
	end

	return false
end

function SendNotification(source, targetId, data)
	if GetResourceState("lb-phone") == "started" then
		local sourceNumber = exports["lb-phone"]:GetEquippedPhoneNumber(source)
		local targetNumber = targetId and exports["lb-phone"]:GetEquippedPhoneNumber(targetId) or nil

		if targetId and (not targetNumber or sourceNumber == targetNumber) then
			return
		end

		exports["lb-phone"]:SendNotification(targetNumber or sourceNumber, {
			app = "billing",
			title = data.title,
			content = data.content,
			icon = "https://cfx-nui-" .. GetCurrentResourceName() .. "/dist/app-new.png",
			customData = data.custom,
		})
	else
		-- Sending notifications to target ids not possible
		if targetId then
			return
		end

		TriggerClientEvent("vivum-billing:sendNotification", source, data)
	end
end
