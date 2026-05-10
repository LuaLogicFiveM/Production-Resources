local config = require 'config'

if config.core.auto_sql then
	MySQL.ready(function()
		Wait(1000)
		local success, error = pcall(MySQL.scalar.await, 'SELECT 1 FROM `lualogic_trust`')
		if not success then
			MySQL.query([[
				CREATE TABLE IF NOT EXISTS `lualogic_trust` (
				`identifier` varchar(46) NOT NULL,
				`name` text DEFAULT NULL,
				`data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]',
				`transferred` text NOT NULL DEFAULT 'false',
				PRIMARY KEY (`identifier`)
				) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
			]])
		end
	end)
end

RegisterServerEvent('lualogic_trust:server:requestAction', function(data)
	local action = data.action
	local status = data.status
	if action == 'owner_set' then
		GlobalState.owner_set = status
	elseif action == 'owner_trade' then
		GlobalState.owner_trade = status
	elseif action == 'owner_transfer' then
		GlobalState.owner_transfer = status
	elseif action == 'owner_remove' then
		GlobalState.owner_remove = status
	elseif action == 'owner_clear' then
		GlobalState.owner_clear = status
	elseif action == 'trust_set' then
		GlobalState.trust_set = status
	elseif action == 'trust_give' then
		GlobalState.trust_give = status
	elseif action == 'trust_remove' then
		GlobalState.trust_remove = status
	elseif action == 'trust_clear' then
		GlobalState.trust_clear = status
	elseif action == 'trust_trade' then
		GlobalState.trust_trade = status
	elseif action == 'search_name' then
		GlobalState.search_name = status
	elseif action == 'search_vehicle' then
		GlobalState.search_vehicle = status
	elseif action == 'search_identifier' then
		GlobalState.search_identifier = status
	elseif action == 'admin_menu' then
		GlobalState.admin_menu = status
	elseif action == 'transfer_vehicles' then
		GlobalState.transfer_vehicles = status
	end
end)