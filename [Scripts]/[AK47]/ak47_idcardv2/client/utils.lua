Notify = function(msg, type)
    lib.notify({
        type = type or 'info',
        description = msg,
        position = 'top',
    })
end

RegisterNetEvent('ak47_idcardv2:notify', function(msg, type)
	Notify(msg, type)
end)