lib.versionCheck('N-fire/nfire_hunting')
if not lib.checkDependency('ox_lib', '2.1.0') then error('You don\'t have latest version of ox_lib') end
if not lib.checkDependency('ox_inventory', '2.7.4') then error('You don\'t have latest version of ox_inventory') end
if not lib.checkDependency('qtarget', '2.1.0') then error('You don\'t have latest version of qtarget') end


RegisterNetEvent('nfire_hunting:harvestCarcass')
AddEventHandler('nfire_hunting:harvestCarcass',function (entityId, bone)
    local entity = NetworkGetEntityFromNetworkId(entityId)
    local weapon = GetPedCauseOfDeath(entity)
    local item = Config.carcass[GetEntityModel(entity)]
    local grade = '★☆☆'
    local image =  item..1
    if InTable(Config.goodWeapon, weapon) then
        grade = '★★☆'
        image =  item..2
        if InTable(Config.headshotBones[GetEntityModel(entity)],bone) then
            grade = '★★★'
            image =  item..3
        end
    end
    if exports.ox_inventory:CanCarryItem(source, item, 1) and DoesEntityExist(entity) and GetEntityAttachedTo(entity) == 0 then
        exports.ox_inventory:AddItem(source, item, 1, {type = grade, image =  image})
        DeleteEntity(entity)
    end
end)

function InTable(table, value)
    for i = 1, #table, 1 do
        if table[i] == value then
            return true
        end
    end
    return false
end

RegisterNetEvent('nfire_hunting:SellCarcass')
AddEventHandler('nfire_hunting:SellCarcass',function (item)
    local itemData = exports.ox_inventory:Search(source,'slots', item)[1]
    if itemData.count >= 1 then
        local reward = Config.sellPrice[item] *  Config.gradeMultiplier[itemData.metadata.type]
        exports.ox_inventory:RemoveItem(source, item, 1, nil, itemData.slot)
        exports.ox_inventory:AddItem(source, 'money', reward)
    end
end)


-- lib.addCommand('group.admin', 'giveCarcass', function(source, args)
--     for key, value in pairs(Config.carcass) do
--         exports.ox_inventory:AddItem(source, value, 1, {type = '★☆☆', image =  value..1})
--         exports.ox_inventory:AddItem(source, value, 1, {type = '★★☆', image =  value..2})
--         exports.ox_inventory:AddItem(source, value, 1, {type = '★★★', image =  value..3})
--     end
-- end)

lib.addCommand('group.admin', 'spawnPed', function(source, args)
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local entity = CreatePed(0, GetHashKey(args.hash), playerCoords, true, true)
end,{'hash:string'})