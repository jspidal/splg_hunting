Config = {}

---@alias CarcassItem 'carcass_boar'|'carcass_hawk'|'carcass_cormorant'|'carcass_coyote'|'carcass_deer'|'carcass_mtlion'|'carcass_rabbit'

---@class CarcassEntity
---@field item CarcassItem
---@field headshotBones number[] bones on the model which should be considered a headshot for grading purposes
---@field drag boolean whether the carcass is heavy enough to require being dragged
---@field xPos number
---@field yPos number
---@field zPos number
---@field xRot number
---@field yRot number
---@field zRot number

---@type table<number, CarcassEntity>
Config.Carcass  = {
    [`a_c_boar`]=           {item = 'carcass_boar', headshotBones = {31086}, drag = true, xPos = -0.7, yPos = 1.2, zPos = -1.0, xRot = -200.0, yRot = 0.0, zRot = 0.0},
    [`a_c_chickenhawk`] =   {item = 'carcass_hawk', headshotBones = {39317}, drag = false, xPos = 0.15, yPos = 0.2, zPos = 0.45, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_cormorant`] =     {item = 'carcass_cormorant', headshotBones = {24818}, drag = false, xPos = 0.15, yPos = 0.2, zPos = 0.4, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_coyote`] =        {item = 'carcass_coyote', headshotBones = {31086}, drag = false, xPos = -0.2, yPos = 0.15, zPos = 0.45, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_deer`] =          {item = 'carcass_deer', headshotBones = {31086}, drag = true, xPos = 0.1, yPos = 1.0, zPos = -1.2, xRot = -200.0, yRot = 30.0, zRot = 0.0},
    [`a_c_mtlion`] =        {item = 'carcass_mtlion', headshotBones = {31086}, drag = true, xPos = 0.1, yPos = 0.7, zPos = -1.0, xRot = -210.0, yRot = 0.0, zRot = 0.0},
    [`a_c_rabbit_01`] =     {item = 'carcass_rabbit', headshotBones = {31086}, drag = false, xPos = 0.12, yPos = 0.25, zPos = 0.45, xRot = 0.0, yRot = 90.0, zRot = 0.0},
}

---@type number[] hash codes of weapons that lead to higher grade carcasses.
Config.GoodWeapon = {
---@diagnostic disable-next-line: assign-type-mismatch
    `WEAPON_SNIPERRIFLE`,`WEAPON_KNIFE`
}

---@type table<CarcassItem, {min: number, max: number}> min and max sell prices per carcass based on durability
Config.SellPrice = {
    ['carcass_boar'] =      {min = 150,max = 1000}, -- min = 0 durability   max = 100 durability
    ['carcass_hawk'] =      {min = 200,max = 1200},
    ['carcass_cormorant'] = {min = 60,max = 600},
    ['carcass_coyote'] =    {min = 30,max = 300},
    ['carcass_deer'] =      {min = 50,max = 500},
    ['carcass_mtlion'] =    {min = 80,max = 800},
    ['carcass_rabbit'] =    {min = 40,max = 400}
}

Config.Degrade = true

Config.GradeMultiplier = {
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
Config.AntiFarm = {
    enable = true,
    size = 70.0,
    time = 10 * 60,
    maxAmount = 3,
    personal = true
}

Config.EnableSelling = false
