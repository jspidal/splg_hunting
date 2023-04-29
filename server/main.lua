lib.locale()
local antifarm = {}

lib.versionCheck('manason/mana_hunting')
if not lib.checkDependency('ox_lib', '3.2.1') then error() end
if not lib.checkDependency('ox_inventory', '2.28.0') then error() end
if not lib.checkDependency('ox_target', '1.8.0') then error() end

local function arrayContains(array, value)
    for i = 1, #array, 1 do
        if array[i] == value then
            return true
        end
    end
    return false
end

local function isPlayerFarming(source, coords)
    if Config.AntiFarm.enable == false then return false end
    if Config.AntiFarm.personal == false then
        source = 1
    end

    local curentTime = os.time()
    local playerData = antifarm[source]
    if not next(antifarm) or playerData == nil or not next(playerData) then -- table empty
        playerData = {
            {
                time = curentTime, coords = coords, amount= 1
            }
        }
        return false
    end
    for i = 1, #playerData do
        if (curentTime - playerData[i].time) > Config.AntiFarm.time then -- delete old table
            playerData[i] = nil
        elseif #(playerData[i].coords - coords) < Config.AntiFarm.size then -- if found table in coord
            if playerData[i].amount >= Config.AntiFarm.maxAmount then -- if amount more than max
                return true
            end
            playerData[i].amount += 1 -- if not amount more than max
            playerData[i].time = curentTime
            return false
        end
    end
    playerData[#playerData+1] = {time = curentTime, coords = coords, amount= 1} -- if no table in coords found
    return false
end

local function getCarcassGrade(weapon, carcassModel, bone, item)
    local grade = '★☆☆'
    local image =  item..1
    if arrayContains(Config.GoodWeapon, weapon) then
        grade = '★★☆'
        image =  item..2
        if arrayContains(Config.HeadshotBones[carcassModel], bone) then
            grade = '★★★'
            image =  item..3
        end
    end

    return grade, image
end

local function map(x, in_min, in_max, out_min, out_max)
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

RegisterNetEvent('mana_hunting:harvestCarcass',function (entityId, bone)
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local entity = NetworkGetEntityFromNetworkId(entityId)
    local entityCoords = GetEntityCoords(entity)
    if #(playerCoords - entityCoords) >= 5 then
        TriggerClientEvent('ox_lib:notify', source, {type = 'error', description = locale('too_far')})
        return
    end
    if isPlayerFarming(source, entityCoords) then
        TriggerClientEvent('ox_lib:notify', source, {type = 'error', description = locale('stop_farm')})
        return
    end
    local weapon = GetPedCauseOfDeath(entity)
    local carcassModel = GetEntityModel(entity)
    local item = Config.CarcassPos[carcassModel].item
    local grade, image = getCarcassGrade(weapon, carcassModel, bone, item)
    if exports.ox_inventory:CanCarryItem(source, item, 1) and DoesEntityExist(entity) and GetEntityAttachedTo(entity) == 0 then
        exports.ox_inventory:AddItem(source, item, 1, {type = grade, image =  image})
        DeleteEntity(entity)
    end
end)

RegisterNetEvent('mana_hunting:SellCarcass',function (item)
    local itemData = exports.ox_inventory:Search(source, 'slots', item)[1]
    if itemData.count < 1 then return end

    local reward = Config.SellPrice[item].max * Config.GradeMultiplier[itemData.metadata.type]
    if Config.Degrade and itemData.metadata.durability then
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
                Config.SellPrice[item].min * Config.GradeMultiplier[itemData.metadata.type],
                Config.SellPrice[item].max * Config.GradeMultiplier[itemData.metadata.type]))
    end
    exports.ox_inventory:RemoveItem(source, item, 1, nil, itemData.slot)
    exports.ox_inventory:AddItem(source, 'money', reward)
end)