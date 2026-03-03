for i, v in pairs(Config.Cards) do
	CreateUsable(i, function(source, data, data2)
		local info = data.metadata or data.info or data2.metadata or data2.info
		if info and info.identifier then
			TriggerClientEvent('ak47_idcardv2:useid', source, i, info)
		else
			lib.notify(source, {title = 'Government', description = 'Please ask an officer for a real id'})
		end
	end)
end