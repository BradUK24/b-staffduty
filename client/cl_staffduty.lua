local QBCore = exports['qb-core']:GetCoreObject()
local originalClothing = {}
local dutyStartTime = nil 
local isStaffModeActive = false 


local Config = Config or {}

local function isMale()
    local playerModel = GetEntityModel(PlayerPedId())
    return playerModel == GetHashKey("mp_m_freemode_01")
end

local function getClothingConfig()
    return isMale() and Config.StaffModeClothing.male or Config.StaffModeClothing.female
end

RegisterNetEvent('toggleStaffMode')
AddEventHandler('toggleStaffMode', function(isStaffModeEnabled)
    local playerPed = PlayerPedId()
    local clothingConfig = getClothingConfig()
    local playerName = GetPlayerName(PlayerId())

    if isStaffModeEnabled then
        if isStaffModeActive then
            QBCore.Functions.Notify("Staff mode is already enabled!", "error")
            return
        end

        dutyStartTime = GetGameTimer()
        isStaffModeActive = true

        originalClothing = {
            torso = {drawable = GetPedDrawableVariation(playerPed, 11), texture = GetPedTextureVariation(playerPed, 11)},
            vest = {drawable = GetPedDrawableVariation(playerPed, 9), texture = GetPedTextureVariation(playerPed, 9)},
            bodyArmor = {drawable = GetPedDrawableVariation(playerPed, 8), texture = GetPedTextureVariation(playerPed, 8)},
            legs = {drawable = GetPedDrawableVariation(playerPed, 4), texture = GetPedTextureVariation(playerPed, 4)},
            shoes = {drawable = GetPedDrawableVariation(playerPed, 6), texture = GetPedTextureVariation(playerPed, 6)},
            arms = {drawable = GetPedDrawableVariation(playerPed, 3), texture = GetPedTextureVariation(playerPed, 3)},
            undershirt = {drawable = GetPedDrawableVariation(playerPed, 8), texture = GetPedTextureVariation(playerPed, 8)},
            hats = {drawable = GetPedPropIndex(playerPed, 0), texture = GetPedPropTextureIndex(playerPed, 0)},
            glasses = {drawable = GetPedPropIndex(playerPed, 1), texture = GetPedPropTextureIndex(playerPed, 1)},
            earAccessories = {drawable = GetPedPropIndex(playerPed, 2), texture = GetPedPropTextureIndex(playerPed, 2)},
        }


        SetPedComponentVariation(playerPed, 11, clothingConfig.torso.drawable, clothingConfig.torso.texture, 2)
        SetPedComponentVariation(playerPed, 9, clothingConfig.vest.drawable, clothingConfig.vest.texture, 2)
        SetPedComponentVariation(playerPed, 4, clothingConfig.legs.drawable, clothingConfig.legs.texture, 2)
        SetPedComponentVariation(playerPed, 6, clothingConfig.shoes.drawable, clothingConfig.shoes.texture, 2)
        SetPedComponentVariation(playerPed, 3, clothingConfig.arms.drawable, clothingConfig.arms.texture, 2)
        SetPedComponentVariation(playerPed, 8, clothingConfig.undershirt.drawable, clothingConfig.undershirt.texture, 2)

        ClearPedProp(playerPed, 0)
        ClearPedProp(playerPed, 1)
        ClearPedProp(playerPed, 2)

     
        SetPedArmour(playerPed, Config.StaffModeClothing.armorValue)

        
        QBCore.Functions.Notify("Staff Mode enabled. You are ready!", "success")
    else
        if not isStaffModeActive then
            QBCore.Functions.Notify("Staff mode is not enabled!", "error")
            return
        end

        isStaffModeActive = false

      
        SetPedComponentVariation(playerPed, 11, originalClothing.torso.drawable, originalClothing.torso.texture, 2)
        SetPedComponentVariation(playerPed, 9, originalClothing.vest.drawable, originalClothing.vest.texture, 2)
        SetPedComponentVariation(playerPed, 8, originalClothing.bodyArmor.drawable, originalClothing.bodyArmor.texture, 2)
        SetPedComponentVariation(playerPed, 4, originalClothing.legs.drawable, originalClothing.legs.texture, 2)
        SetPedComponentVariation(playerPed, 6, originalClothing.shoes.drawable, originalClothing.shoes.texture, 2)
        SetPedComponentVariation(playerPed, 3, originalClothing.arms.drawable, originalClothing.arms.texture, 2)
        SetPedComponentVariation(playerPed, 8, originalClothing.undershirt.drawable, originalClothing.undershirt.texture, 2)

     
        ClearPedProp(playerPed, 0)
        ClearPedProp(playerPed, 1)
        ClearPedProp(playerPed, 2)

        
        SetPedArmour(playerPed, 0)


        QBCore.Functions.Notify("Staff Mode disabled. Welcome back!", "error")
    end
end)
