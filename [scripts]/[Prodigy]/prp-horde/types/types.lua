---@meta

---@class PerkCard
---@field id string
---@field name string
---@field description string
---@field icon string
---@field isBuff boolean

---@class PerkUIPayload
---@field currentBuffId string|nil
---@field currentDebuffId string|nil
---@field currentVotes table<string, number>
---@field cards table<integer, PerkCard>
---@field selectedCard PerkCard|nil
