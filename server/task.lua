local ServerConfig = require 'config.server'

---@enum TaskRequirementResult
local TaskRequirementResult = {
    PROGRESSED = 0,
    COMPLETED = 1,
    NOT_PROGRESSED = 2,
}

---@class Task : OxClass
---@field id number
---@field title string
---@field description string
---@field cashReward number
---@field xpReward number
---@field canClaim boolean
---@field requirements table<CarcassItem | 'any', TaskCondition>
---@field progress? table<CarcassItem | 'any', number>
---@field checkRequirements fun(self: Task, carcass: table, weapon: string, isHeadshot: boolean, distance: number): TaskRequirementResult

local Task = lib.class('Task')

function Task:constructor(id, title, cashReward, xpReward, canClaim, requirements, progress)
    self.id = id
    self.title = title
    self.cashReward = cashReward
    self.xpReward = xpReward
    self.canClaim = canClaim
    self.requirements = requirements
    self.progress = progress or {}
end

function Task:checkRequirements(carcass, weapon, isHeadshot, distance)
    local task = self.requirements[carcass.item] or self.requirements['any']
    if task then
        if task.weapon and task.weapon ~= weapon then return TaskRequirementResult.NOT_PROGRESSED end
        if task.headshot and not isHeadshot then return TaskRequirementResult.NOT_PROGRESSED end
        if task.minDistance and distance < task.minDistance then return TaskRequirementResult.NOT_PROGRESSED end
        if task.maxDistance and distance > task.maxDistance then return TaskRequirementResult.NOT_PROGRESSED end
        if task.quality and ServerConfig.GradeMultiplier[carcass.grade] < task.quality then return TaskRequirementResult.NOT_PROGRESSED end

        self.progress[carcass.item] = self.progress[carcass.item] + 1
        if task.amount and self.progress[carcass.item] <= task.amount then return TaskRequirementResult.PROGRESSED end
    end

    return TaskRequirementResult.COMPLETED
end

return Task, TaskRequirementResult