config = {}

--- Command used for editing horde levels, set to nil to disable
---@type string|nil
config.adminCommand = 'hordeadmin'

--- Command used for testing purposes, set to nil to disable
---@type string|nil
config.testingCommand = 'hordetest'

--- Command for bypassing disabled horde queue
--- @type string|nil
config.bypassQueueCommand = 'hordobypass'

--- Enables debug prints
---@type boolean
config.debug = false
config.logWebhook = ""
