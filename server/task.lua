---@class Task : OxClass
---@field id number
---@field title string
---@field description string
---@field cashReward number
---@field xpReward number
---@field canClaim boolean
---@field requirements table<CarcassItem | 'any', TaskCondition>
---@field progress table<CarcassItem | 'any', number>

local Task = lib.class('Task')

function Task:constructor(id, title, cashReward, xpReward, canClaim, requirements, progress)
    self.id = id
    self.title = title
    self.cashReward = cashReward
    self.xpReward = xpReward
    self.canClaim = canClaim
    self.requirements = requirements
    self.progress = progress
end

return Task