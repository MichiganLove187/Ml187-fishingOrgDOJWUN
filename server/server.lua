local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("anchor", function(source, item)
    TriggerClientEvent('fishing:client:anchor', source)
end)

QBCore.Functions.CreateUseableItem("fishingrod", function(source, item)
    TriggerClientEvent('fishing:fishstart', source)
end)

QBCore.Functions.CreateUseableItem("fishicebox", function(source, item)
    TriggerClientEvent('fishing:client:useFishingBox', source, item.info.boxid or "default")  
end)

QBCore.Functions.CreateUseableItem("fishinglootbig", function(source, item)
    TriggerClientEvent("fishing:client:attemptTreasureChest", source)
end)

QBCore.Functions.CreateUseableItem("fishingloot", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    Player.Functions.RemoveItem("fishingloot", 1)
    Citizen.Wait(1000)
    
    Player.Functions.AddItem('fishingkey', 1)
    Player.Functions.AddItem(Config.smallLootboxReward, 1)
    Player.Functions.AddMoney('cash', Config.smallLootboxCash)
    
    TriggerClientEvent('QBCore:Notify', src, "You found items and $"..Config.smallLootboxCash, "success")
end)

QBCore.Functions.CreateUseableItem("fishtacklebox", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    Player.Functions.RemoveItem("fishtacklebox", 1)
    Citizen.Wait(1250)
    Player.Functions.AddItem('pearlscard', 1)
end)

RegisterNetEvent('fishing:server:removeFishingBait', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('fishbait', 1)
end)

RegisterNetEvent("fishing:server:addTackleBox", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('fishtacklebox', 1)
end)

RegisterNetEvent("fishing:server:returnDeposit", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = math.floor(Config.BoatPrice/2)
    Player.Functions.AddMoney('bank', price)
    TriggerClientEvent('QBCore:Notify', src, "Boat returned for $"..price, "success")
end)

RegisterNetEvent('fishing:server:catch', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local luck = math.random(1, 100)

    if luck == 100 then
        local info = {species = "Orca", weight = math.random(850,1000)}
        Player.Functions.AddItem('killerwhale', 1, nil, info)
    elseif luck >= 98 then
        Player.Functions.AddItem('fishinglootbig', 1)
    elseif luck >= 95 then
        local info = {species = "Dolphin", weight = math.random(10,28)}
        Player.Functions.AddItem('dolphin', 1, nil, info)
    elseif luck >= 92 then
        local info = {species = "Hammerhead Shark", weight = math.random(20,30)}
        Player.Functions.AddItem('sharkhammer', 1, nil, info)
    elseif luck >= 89 then
        local info = {species = "Tiger Shark", weight = math.random(1,6)}
        Player.Functions.AddItem('sharktiger', 1, nil, info)
    elseif luck >= 85 then
        local info = {species = "Stingray", weight = math.random(4,9)}
        Player.Functions.AddItem('stingray', 1, nil, info)
    elseif luck >= 80 then
        local info = {species = "Flounder", weight = math.random(10,15)}
        Player.Functions.AddItem('flounder', 1, nil, info)
    elseif luck >= 75 then
        Player.Functions.AddItem('fishingboot', 1)
    elseif luck >= 70 then
        local info = {species = "Bass", weight = math.random(1,6)}
        Player.Functions.AddItem('bass', 1, nil, info)
    elseif luck >= 65 then
        Player.Functions.AddItem('fishingloot', 1)
    elseif luck >= 60 then
        local info = {species = "Cod", weight = math.random(5,7)}
        Player.Functions.AddItem('codfish', 1, nil, info)
    elseif luck >= 55 then
        Player.Functions.AddItem('fishingtin', 1)
    else
        local info = {species = "Mackerel", weight = math.random(1,5)}
        Player.Functions.AddItem('mackerel', 1, nil, info)
    end
end)

RegisterNetEvent('fishing:server:SellillegalFish', function(args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local args = tonumber(args)
    
    local fishData = {
        [1] = {item = "dolphin", price = Config.dolphinPrice, name = "Dolphin"},
        [2] = {item = "sharktiger", price = Config.sharktigerPrice, name = "Tiger Shark"},
        [3] = {item = "sharkhammer", price = Config.sharkhammerPrice, name = "Hammerhead Shark"},
        [4] = {item = "killerwhale", price = Config.killerwhalePrice, name = "Killer Whale"}
    }
    
    local fish = fishData[args]
    if fish and Player.Functions.GetItemByName(fish.item) then
        Player.Functions.RemoveItem(fish.item, 1)
        Player.Functions.AddMoney('bank', fish.price)
        TriggerClientEvent('QBCore:Notify', src, fish.name.." Sold for $"..fish.price, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have any "..fish.name.." to sell", 'error')
    end
end)

RegisterNetEvent('fishing:server:SellLegalFish', function(args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local args = tonumber(args)
    
    local fishData = {
        [1] = {item = "mackerel", price = Config.mackerelPrice, name = "Mackerel"},
        [2] = {item = "codfish", price = Config.codfishPrice, name = "Cod"},
        [3] = {item = "bass", price = Config.bassPrice, name = "Bass"},
        [4] = {item = "flounder", price = Config.flounderPrice, name = "Flounder"},
        [5] = {item = "stingray", price = Config.stingrayPrice, name = "Stingray"}
    }
    
    local fish = fishData[args]
    if fish and Player.Functions.GetItemByName(fish.item) then
        Player.Functions.RemoveItem(fish.item, 1)
        Player.Functions.AddMoney('bank', fish.price)
        TriggerClientEvent('QBCore:Notify', src, fish.name.." Sold for $"..fish.price, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have any "..fish.name.." to sell", 'error')
    end
end)

RegisterNetEvent('fishing:server:BuyFishingGear', function(args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local args = tonumber(args)
    
    local gearData = {
        [1] = {item = "fishbait", price = Config.fishingBaitPrice, name = "Fishing Bait"},
        [2] = {item = "fishingrod", price = Config.fishingRodPrice, name = "Fishing Rod"},
        [3] = {item = "anchor", price = Config.BoatAnchorPrice, name = "Boat Anchor"},
        [4] = {item = "fishicebox", price = Config.FishingBoxPrice, name = "Fishing Box", hasInfo = true}
    }
    
    local gear = gearData[args]
    if gear and Player.PlayerData.money["bank"] >= gear.price then
        Player.Functions.RemoveMoney('bank', gear.price)
        
        local info = {}
        if gear.hasInfo then
            info = {boxid = math.random(111,999)}
        end
        
        Player.Functions.AddItem(gear.item, 1, nil, info)
        TriggerClientEvent('QBCore:Notify', src, "Purchased "..gear.name, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Not enough money", "error")
    end
end)

QBCore.Functions.CreateCallback('fishing:server:checkMoney', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player.PlayerData.money["bank"] >= Config.BoatPrice then
        Player.Functions.RemoveMoney('bank', Config.BoatPrice)
        TriggerClientEvent('QBCore:Notify', src, "Boat rented for $"..Config.BoatPrice, "success")
        cb(true)
    else
        TriggerClientEvent('QBCore:Notify', src, "Not enough money", "error")
        cb(false)
    end
end)