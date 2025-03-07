RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    local uniqueId = player.PlayerData.citizenid
    exports[GetCurrentResourceName()]:initialTasks(uniqueId)
end)