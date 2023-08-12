local function getNearestTireId(entity)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local nearestTire = nil
    local shortestDistance = Config.slashDistance + 0.25

    for tireId, boneName in pairs(Config.wheelBones) do
        local boneIndex = GetEntityBoneIndexByName(entity, boneName)
        if boneIndex > 0 then
            local boneCoords = GetEntityBonePosition_2(entity, boneIndex)
            local distance = Vdist(
                pedCoords.x, pedCoords.y, pedCoords.z,
                boneCoords.x, boneCoords.y, boneCoords.z
            )

            if distance < shortestDistance then
                shortestDistance, nearestTire = distance, tireId
            end
        end
    end

    return nearestTire
end

local function canSlash(entity)
    local tireId = getNearestTireId(entity)
    if IsVehicleTyreBurst(entity, tireId) then
        return false
    end

    local currentWeapon = GetSelectedPedWeapon(PlayerPedId())
    for _, weapon in pairs(Config.weapons) do
        if currentWeapon == GetHashKey(weapon) then return true end
    end

    return false
end

local function doSlash(entity)
    local ped = PlayerPedId()
    local tireId = getNearestTireId(entity)

    if tireId then
        RequestAnimDict(Config.animDict)
        while not HasAnimDictLoaded(Config.animDict) do Wait(100) end

        TaskPlayAnim(ped, Config.animDict, Config.animName, 4.0, 2.0, Config.animTime, 0, 0, false, false, false)

        Wait(Config.animWait)

        SetVehicleTyreBurst(entity, tireId, true, 1.0)
        SetVehicleTyreFixed(entity, tireId)
        SetVehicleTyreBurst(entity, tireId, false, 1.0)

        TriggerServerEvent('vx-tire-slash:client:subDurability')
    end
end

exports['qb-target']:AddTargetBone(Config.wheelBones, {
    options = {
        {
            type = "client",
            icon = 'fas fa-scissors',
            label = Config.prompt,
            action = doSlash, -- entity
            canInteract = canSlash -- entity, distance, data
        }
    },
    distance = Config.slashDistance
})

RegisterNetEvent('vx-tire-slash:server:clearWeapon', function()
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
end)