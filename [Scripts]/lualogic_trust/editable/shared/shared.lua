local config = require 'config'
local debugCfg = config.core.debug

function DebugPrint(data, type)
	if not debugCfg then return end
	if type == 'info' and debugCfg == 'info' then
		return lib.print.info(data)
	elseif type == 'warning' and debugCfg == 'warning' then
		return lib.print.warn(data)
	elseif type == 'error' and debugCfg == 'error' then
		return lib.print.error(data)
	end
end

function GetTableSize(table)
	local n = 0
	for k, v in pairs(table) do
		n = n + 1
	end
	return n
end