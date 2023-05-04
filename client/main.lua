lib.locale()
local carriedCarcass = 0
local heaviestCarcass = 0

local animals = {}
local listItemCarcass = {}
local carcassByItem = {}
for key, value in pairs(Config.Carcass) do
    animals[#animals+1] = key
    listItemCarcass[#listItemCarcass+1] = value.item
    carcassByItem[value.item] = key
end

local function customControl()
    Citizen.CreateThread(function()
        local playerPed = cache.ped
        local enable = true

        while enable do
            if IsControlPressed(0, 35) then -- Right
                FreezeEntityPosition(playerPed, false)
                SetEntityHeading(playerPed, GetEntityHeading(playerPed)+0.5)
            elseif IsControlPressed(0, 34) then -- Left
                FreezeEntityPosition(playerPed, false)
                SetEntityHeading(playerPed, GetEntityHeading(playerPed)-0.5)
            elseif IsControlPressed(0, 32) or IsControlPressed(0, 33) then
                FreezeEntityPosition(playerPed, false)
            else
                FreezeEntityPosition(playerPed, true)
                TaskPlayAnim(cache.ped, 'combat@drag_ped@', 'injured_drag_plyr', 0.0, 0.0, 1, 2, 7, false, false, false)
            end
            Wait(7)
            if heaviestCarcass ~= 0 then
                enable = Config.Carcass[heaviestCarcass].drag
            else
                enable = false
            end
        end
        FreezeEntityPosition(playerPed, false)
        ClearPedSecondaryTask(playerPed)
        ClearPedTasksImmediately(playerPed)
    end)
end

local function playCarryAnim()
    if carriedCarcass == 0 then
        ClearPedSecondaryTask(cache.ped)
        return
    end
    if Config.Carcass[heaviestCarcass].drag then
        lib.requestAnimDict('combat@drag_ped@')
        TaskPlayAnim(cache.ped, 'combat@drag_ped@', 'injured_drag_plyr', 2.0, 2.0, 100000, 1, 0, false, false, false)
        customControl()
        while carriedCarcass ~= 0 do
            while not IsEntityPlayingAnim(cache.ped, 'combat@drag_ped@', 'injured_drag_plyr', 1) do
                TaskPlayAnim(cache.ped, 'combat@drag_ped@', 'injured_drag_plyr', 2.0, 2.0, 100000, 1, 0, false, false, false)
                Wait(0)
            end
            Wait(500)
        end
    else
        lib.requestAnimDict('missfinale_c2mcs_1')
        TaskPlayAnim(cache.ped, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, 100000, 49, 0, false, false, false)
        while carriedCarcass ~= 0 do
            while not IsEntityPlayingAnim(cache.ped, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 49) do
                TaskPlayAnim(cache.ped, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, 100000, 49, 0, false, false, false)
                Wait(0)
            end
            Wait(500)
        end
    end
end

local function carryCarcass()
    TriggerEvent('ox_inventory:disarm')
    FreezeEntityPosition(cache.ped, false)
    heaviestCarcass = 0
    local carcassCount = 0
    for _, value in pairs(exports.ox_inventory:Search('count', listItemCarcass)) do
        carcassCount += value
    end
    if carcassCount > 0 then
        local inventory = exports.ox_inventory:Search('slots', listItemCarcass)
        local weight = 0
        for key, value in pairs(inventory) do
            if next(value) ~= nil and value[1].weight > weight then
                weight = value[1].weight
                heaviestCarcass = carcassByItem[key]
            end
        end

        lib.requestModel(heaviestCarcass)
        DeleteEntity(carriedCarcass)
        carriedCarcass = CreatePed(1, heaviestCarcass, GetEntityCoords(cache.ped), GetEntityHeading(cache.ped), true, true)
        SetEntityInvincible(carriedCarcass, true)
        SetEntityHealth(carriedCarcass, 0)
        local pos = Config.Carcass[heaviestCarcass]
        AttachEntityToEntity(carriedCarcass, cache.ped, 11816, pos.xPos, pos.yPos, pos.zPos, pos.xRot, pos.yRot, pos.zRot, false, false, false, true, 2, true)
        playCarryAnim()
    else
        DeleteEntity(carriedCarcass)
        carriedCarcass = 0
        playCarryAnim()
    end
end

exports('CarryCarcass', carryCarcass)

RegisterNetEvent('ox:playerLoaded', function()
    carryCarcass()
end)
RegisterNetEvent('esx:playerLoaded',function ()
    carryCarcass()
end)

local function pickupCarcass(data)
    local entity = data.entity
    TriggerEvent('ox_inventory:disarm')
    local _, bone = GetPedLastDamageBone(entity)
    TaskTurnPedToFaceEntity(cache.ped, entity, -1)
    Wait(500)
    if lib.progressCircle({
        duration = 3000,
        label = locale('pickup_carcass'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false
        },
        anim = {
            dict = 'amb@medic@standing@kneel@idle_a',
            clip = 'idle_a',
            flag = 1,
        },
    }) then
        TriggerServerEvent('mana_hunting:harvestCarcass', NetworkGetNetworkIdFromEntity(entity), bone)
    end
end

exports.ox_target:addModel(animals, {
    {
        icon = "fa-solid fa-paw",
        label = locale('pickup_carcass'),
        canInteract = function(entity)
            return IsEntityDead(entity) and not IsEntityAMissionEntity(entity)
        end,
        onSelect = pickupCarcass
    }
})

RegisterCommand('carcass', function ()
    lib.requestAnimDict('amb@medic@standing@kneel@idle_a')
    TaskPlayAnim(cache.ped, 'amb@medic@standing@kneel@idle_a', 'idle_a', 8.0, -8.0, 10000, 1, 0, false, false, false)
end)


--------------------- SELL -----------------------------------

if Config.EnableSelling then

    local function sellCarcass()
        if lib.progressCircle({
            duration = 3000,
            label = locale('sell_in_progress'),
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                car = true,
                combat = true,
                mouse = false
            },
        }) then
            TriggerServerEvent('mana_hunting:SellCarcass', Config.Carcass[heaviestCarcass].item)
        end
    end

    exports.ox_target:addBoxZone({
        coords = vec3(963.34, -2115.39, 31.47),
        size = vec3(6.8, 1, 3),
        rotation = 355,
        options = {
            {
                onSelect = sellCarcass,
                icon = "fa-solid fa-sack-dollar",
                label = locale('sell_carcass'),
                canInteract = function()
                    return heaviestCarcass ~= 0
                end
            }
        }
    })

    CreateThread(function()
        blip = AddBlipForCoord(963.34, -2115.39)
        SetBlipSprite(blip, 141)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 43)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(locale('blip_name'))
        EndTextCommandSetBlipName(blip)
    end)
end