RegisterNetEvent('vx-tire-slash:client:subDurability', function()
    local src = source
    local currentWeapon = exports.ox_inventory:GetCurrentWeapon(src)
    local currentDurability = currentWeapon.metadata.durability

    if currentDurability <= Config.subDurability then
        exports.ox_inventory:RemoveItem(src, currentWeapon.name, 1, currentWeapon.metadata, currentWeapon.slot)
        TriggerClientEvent('vx-tire-slash:server:clearWeapon', src)
    else
        exports.ox_inventory:SetDurability(src, currentWeapon.slot, currentDurability - Config.subDurability)
    end
end)