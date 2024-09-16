local ServerConfig = {}

---@type number[] hash codes of weapons that lead to higher grade carcasses.
ServerConfig.GoodWeapon = {
    ---@diagnostic disable-next-line: assign-type-mismatch
    `WEAPON_SNIPERRIFLE`, `WEAPON_KNIFE`
}

---@type table<CarcassItem, {min: number, max: number}> min and max sell prices per carcass based on durability
ServerConfig.SellPrice = {
    ['carcass_boar'] =      {min = 150, max = 1000}, -- min = 0 durability   max = 100 durability
    ['carcass_hawk'] =      {min = 200, max = 1200},
    ['carcass_cormorant'] = {min = 60, max = 600},
    ['carcass_coyote'] =    {min = 30, max = 300},
    ['carcass_deer'] =      {min = 50, max = 500},
    ['carcass_mtlion'] =    {min = 80, max = 800},
    ['carcass_rabbit'] =    {min = 40, max = 400}
}


ServerConfig.Degrade = true

ServerConfig.GradeMultiplier = {
    ['★☆☆'] = 0.5, -- not killed by a goodWeapon
    ['★★☆'] = 1.0, -- killed by a goodWeapon
    ['★★★'] = 2.0  -- headshot with a goodWeapon
}

---@class AntiFarm
---@field enable boolean
---@field size number
---@field time integer
---@field maxAmount integer
---@field personal boolean
ServerConfig.AntiFarm = {
    enable = true,
    size = 70.0,
    time = 10 * 60,
    maxAmount = 3,
    personal = true
}

---Function is triggered when a player earns experience.
---@param src number
---@param exp number
ServerConfig.addExperience = function(src, exp)
    
end

return ServerConfig