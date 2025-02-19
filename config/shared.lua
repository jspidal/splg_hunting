local Config = {}

---@alias CarcassItem 'carcass_boar' | 'carcass_hawk'|'carcass_cormorant'|'carcass_coyote'|'carcass_deer'|'carcass_mtlion'|'carcass_rabbit'

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
Config.Carcass = {
    [`a_c_boar`] =           {item = 'carcass_boar', headshotBones = {31086}, drag = true, xPos = -0.7, yPos = 1.2, zPos = -1.0, xRot = -200.0, yRot = 0.0, zRot = 0.0},
    [`a_c_chickenhawk`] =   {item = 'carcass_hawk', headshotBones = {39317}, drag = false, xPos = 0.15, yPos = 0.2, zPos = 0.45, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_cormorant`] =     {item = 'carcass_cormorant', headshotBones = {24818}, drag = false, xPos = 0.15, yPos = 0.2, zPos = 0.4, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_coyote`] =        {item = 'carcass_coyote', headshotBones = {31086}, drag = false, xPos = -0.2, yPos = 0.15, zPos = 0.45, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_deer`] =          {item = 'carcass_deer', headshotBones = {31086}, drag = true, xPos = 0.1, yPos = 1.0, zPos = -1.2, xRot = -200.0, yRot = 30.0, zRot = 0.0},
    [`a_c_mtlion`] =        {item = 'carcass_mtlion', headshotBones = {31086}, drag = true, xPos = 0.1, yPos = 0.7, zPos = -1.0, xRot = -210.0, yRot = 0.0, zRot = 0.0},
    [`a_c_rabbit_01`] =     {item = 'carcass_rabbit', headshotBones = {31086}, drag = false, xPos = 0.12, yPos = 0.25, zPos = 0.45, xRot = 0.0, yRot = 90.0, zRot = 0.0},
}

Config.EnableSelling = false

---@class TaskCondition
---@field amount integer the required number of aniamls to complete the task
---@field weapon? string | integer the hash of the required weapon to kill the animal
---@field quality? number the required quality of the carcass
---@field headshot? boolean whether the animal was headshot
---@field minDistance? number the minimum distance from the player to the carcass
---@field maxDistance? number the maximum distance from the player to the carcass

---@class ConfigTask
---@field id number
---@field title string
---@field description string
---@field cashReward number
---@field xpReward number
---@field requirements table<CarcassItem | 'any', TaskCondition>

---@type ConfigTask[]
Config.Tasks = {
    {
        id = 1,
        title = 'Hunting 101',
        description = 'Kill a boar and collect it\'s carcass',
        cashReward = 100,
        xpReward = 1,
        requirements = {
            ['carcass_boar'] = {
                amount = 1,
            }
        }
    },
    {
        id = 2,
        title = 'Birdwatching',
        description = 'Kill a hawk',
        cashReward = 150,
        xpReward = 1,
        requirements = {
            ['carcass_hawk'] = {
                amount = 1
            }
        }
    },
    {
        id = 3,
        title = 'Fishing for compliments',
        description = 'Kill a cormorant',
        cashReward = 100,
        xpReward = 1,
        requirements = {
            ['carcass_cormorant'] = {
                amount = 1
            }
        }
    },
    {
        id = 4,
        title = 'Coyote Ugly',
        description = 'Kill a coyote',
        cashReward = 100,
        xpReward = 1,
        requirements = {
            ['carcass_coyote'] = {
                amount = 1
            }
        }
    },
    {
        id = 5,
        title = 'Deer Hunter',
        description = 'Kill a deer',
        cashReward = 200,
        xpReward = 1,
        requirements = {
            ['carcass_deer'] = {
                amount = 1
            }
        }
    },
    {
        id = 6,
        title = 'Mountain Lion',
        description = 'Kill a mountain lion',
        cashReward = 250,
        xpReward = 1,
        requirements = {
            ['carcass_mtlion'] = {
                amount = 1
            }
        }
    },
    {
        id = 7,
        title = 'Rabbit Season',
        description = 'Kill a rabbit and sell its carcass to the butcher',
        cashReward = 50,
        xpReward = 1,
        requirements = {
            ['carcass_rabbit'] = {
                amount = 1
            }
        }
    }
}

return Config