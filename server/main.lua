-- // EVENTS \\ --
RegisterServerEvent('qb-durability:server:UpdateItemQuality')
AddEventHandler('qb-durability:server:UpdateItemQuality', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ItemSlot = Player.PlayerData.items[data.slot]
    local DecreaseAmount = Config.DurabilityMultiplier[data.name]
    local date = os.time(os.date("!*t"))

    if Config.DurabilityMultiplier[data.name] ~= nil then
        if ItemSlot.info.quality ~= nil then
            if ItemSlot.info.quality - DecreaseAmount > 0 then
                ItemSlot.info.quality = ItemSlot.info.quality - DecreaseAmount / ItemSlot.amount
            else
                ItemSlot.info.quality = 0
                TriggerClientEvent('inventory:client:UseItem', src, data)
                TriggerClientEvent('QBCore:Notify', src, "Your item is broken and cant be used..", "error")
            end
        end
    end
    Player.Functions.SetInventory(Player.PlayerData.items)
end)

RegisterServerEvent("qb-durability:server:SetItemQuality")
AddEventHandler("qb-durability:server:SetItemQuality", function(data, hp)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local itemSlot = Player.Functions.GetItemBySlot(slot)
    local DecreaseAmount = Config.DurabilityMultiplier[data.name]
    itemSlot = slot
    itemSlot.info.quality = hp
    Player.Functions.SetInventory(Player.PlayerData.items)
end)