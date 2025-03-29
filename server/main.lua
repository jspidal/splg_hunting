lib.locale()
local antifarm = {}

local SharedConfig = require 'config.shared'
local ServerConfig = require 'config.server'

local core <const> = Framework.core or exports.bl_bridge:core()

local Task, _ = require 'server.task'
local tasks = {}

local animals = {}

for key, _ in pairs(SharedConfig.Carcass) do
    animals[#animals + 1] = key
end

lib.versionCheck('jspidal/mana_hunting')
assert(lib.checkDependency('ox_lib', '3.21.0', true))
assert(lib.checkDependency('ox_inventory', '2.28.0', true))
assert(lib.checkDependency('ox_target', '1.8.0'), true)

-- exports.pickle_xp:RegisterXPCategory('hunting', "Hunting", 1000, 0.5, 5)

local function isPlayerFarming(source, coords)
    if ServerConfig.AntiFarm.enable == false then return false end
    if ServerConfig.AntiFarm.personal == false then
        source = 1
    end

    local curentTime = os.time()
    local playerData = antifarm[source]
    if not next(antifarm) or playerData == nil or not next(playerData) then -- table empty
        playerData = {
            {
                time = curentTime, coords = coords, amount = 1
            }
        }
        return false
    end
    for i = 1, #playerData do
        if (curentTime - playerData[i].time) > ServerConfig.AntiFarm.time then    -- delete old table
            playerData[i] = nil
        elseif #(playerData[i].coords - coords) < ServerConfig.AntiFarm.size then -- if found table in coord
            if playerData[i].amount >= ServerConfig.AntiFarm.maxAmount then       -- if amount more than max
                return true
            end
            playerData[i].amount += 1 -- if not amount more than max
            playerData[i].time = curentTime
            return false
        end
    end
    playerData[#playerData + 1] = { time = curentTime, coords = coords, amount = 1 } -- if no table in coords found
    return false
end

local function getCarcassGrade(weapon, bone, carcass)
    local grade = '★☆☆'
    local image = carcass.item .. 1
    local isHeadshot = false
    if lib.table.contains(ServerConfig.GoodWeapon, weapon) then
        grade = '★★☆'
        image = carcass.item .. 2
        if lib.table.contains(carcass.headshotBones, bone) then
            grade = '★★★'
            image = carcass.item .. 3
            isHeadshot = true
        end
    end

    return grade, image, isHeadshot
end

local function map(x, in_min, in_max, out_min, out_max)
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

local function checkTaskConditions(playerId, carcass, weapon, isHeadshot, distance)
    for i = 1, #tasks[playerId] do
        local task = tasks[playerId][i]
        if task then
            task:checkRequirements(carcass, weapon, isHeadshot, distance)
        end
    end
end

RegisterNetEvent('mana_hunting:harvestCarcass', function(entityId, bone)
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local entity = NetworkGetEntityFromNetworkId(entityId)
    local entityCoords = GetEntityCoords(entity)
    if #(playerCoords - entityCoords) >= 5 then
        TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = locale('too_far') })
        return
    end
    if isPlayerFarming(source, entityCoords) then
        TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = locale('stop_farm') })
        return
    end
    local weapon = GetPedCauseOfDeath(entity)
    local carcassModel = GetEntityModel(entity)
    local carcass = SharedConfig.Carcass[carcassModel]
    local grade, image, isHeadshot = getCarcassGrade(weapon, bone, carcass)
    if exports.ox_inventory:CanCarryItem(source, carcass.item, 1) and DoesEntityExist(entity) and GetEntityAttachedTo(entity) == 0 then
        exports.ox_inventory:AddItem(source, carcass.item, 1, { type = grade, image = image })
        DeleteEntity(entity)
        local distance = Entity(entity).state.killedDistance or 0
        checkTaskConditions(source, carcass, weapon, isHeadshot, distance)
    end
end)

if SharedConfig.EnableSelling then
    RegisterNetEvent('mana_hunting:SellCarcass', function(item)
        local itemData = exports.ox_inventory:Search(source, 'slots', item)[1]
        if itemData.count < 1 then return end

        local reward = ServerConfig.SellPrice[item].max * ServerConfig.GradeMultiplier[itemData.metadata.type]
        if ServerConfig.Degrade and itemData.metadata.durability then
            local currentTime = os.time()
            local maxTime = itemData.metadata.durability
            local minTime = maxTime - itemData.metadata.degrade * 60
            if currentTime >= maxTime then
                currentTime = maxTime
            end
            reward = math.floor(
                map(
                    currentTime,
                    maxTime,
                    minTime,
                    ServerConfig.SellPrice[item].min * ServerConfig.GradeMultiplier[itemData.metadata.type],
                    ServerConfig.SellPrice[item].max * ServerConfig.GradeMultiplier[itemData.metadata.type]))
        end
        exports.ox_inventory:RemoveItem(source, item, 1, nil, itemData.slot)
        exports.ox_inventory:AddItem(source, 'money', reward)
    end)
end

RegisterNetEvent('splg_hunting:server:recordDistance', function(victimId, attackerId, weapon)
    local attacker = NetworkGetEntityFromNetworkId(attackerId)
    local victim = NetworkGetEntityFromNetworkId(victimId)
    if not IsPedAPlayer(attacker) then return end
    if GetEntityType(victim) ~= 1 and victim or not lib.table.contains(animals, GetEntityModel(victim)) or GetEntityHealth(victim) > 0 then return end

    local playerPositon = GetEntityCoords(attacker)
    local animalPosition = GetEntityCoords(victim)
    local distance = #(playerPositon - animalPosition)

    Entity(victim).state.killedDistance = distance
end)

lib.callback.register('splg_hunting:server:getTasks', function(source)
    local uniqueId <const> = core.GetPlayer(source).id
    return tasks[uniqueId]
end)

-- Choose initial tasks for player
local function initialTasks(uniqueId)
    if GetInvokingResource() ~= GetCurrentResourceName() then return end
    if not tasks[uniqueId] then
        tasks[uniqueId] = {}
        -- Check if player has any tasks already
        MySQL.prepare('INSERT INTO splg_hunting_users (user_id) VALUES (?) ON DUPLICATE KEY UPDATE user_id = user_id',
            { uniqueId })
        local response = MySQL.query.await('SELECT * FROM splg_hunting_tasks WHERE uniqueId = ? AND completed = 0',
            { uniqueId })
        if response and next(response) then
            for i = 1, #response do
                local task = Task:new(response[i].id, response[i].title, response[i].cash_reward, response[i].xp_reward,
                    response[i].requirements)
                tasks[uniqueId][#tasks[uniqueId] + 1] = task
            end
            return
        end
        for i = 1, 6 do
            local id = MySQL.insert.await(
                'INSERT INTO splg_hunting_tasks (user_id, title, cash_reward, xp_reward, completed, requirements) VALUES (?, ?, ?, ?, ?, ?)',
                { ServerConfig.Tasks[i].title, ServerConfig.Tasks[i].cashReward, ServerConfig.Tasks[i].xpReward,
                    ServerConfig.Tasks[i].requirements })
            local task = Task:new(id, ServerConfig.Tasks[i].title, ServerConfig.Tasks[i].cashReward,
                ServerConfig.Tasks[i].xpReward, false, ServerConfig.Tasks[i].requirements)
            tasks[uniqueId][#tasks[uniqueId] + 1] = task
        end
    end
end

AddEventHandler('bl_bridge:server:playerLoaded', function(src)
    local uniqueId = core.GetPlayer(src).id
    initialTasks(uniqueId)
end)
