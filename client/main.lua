local isLoggedIn = false
local CurrentItemData = {}
local PlayerData = {}
local CanUse = true
local MultiplierItemAmount = 0

-- // PLAYER LOAD \\ --
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

-- // THREADS \\ --
Citizen.CreateThread(function()
    while true do
        if MultiplierItemAmount > 0 then
            TriggerServerEvent("qb-durability:server:UpdateItemQuality", CurrentItemData)
            TriggerServerEvent("qb-durability:server:SetItemQuality", CurrentItemData)
            Citizen.Wait(1000)
            MultiplierItemAmount = 0
        else
            Citizen.Wait(1000)
        end
    end
    Citizen.Wait(1)
end)

-- // EVENTS \\ --
RegisterNetEvent('qb-durability:client:SetCurrentItem')
AddEventHandler('qb-durability:client:SetCurrentItem', function(data, bool)
    if data ~= false then
        CurrentItemData = data
        MultiplierItemAmount = 1
        Citizen.Wait(1000)
    else
        CurrentItemData = data
    end
    CanUse = bool
end)

RegisterNetEvent('qb-durability:client:SetItemQuality')
AddEventHandler('qb-durability:client:SetItemQuality', function(amount)
    if CurrentItemData ~= true then
        MultiplierItemAmount = 1
        TriggerServerEvent("qb-durability:server:SetItemQuality", CurrentItemData, amount)
    end
end)