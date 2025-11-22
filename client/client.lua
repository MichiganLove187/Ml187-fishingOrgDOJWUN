local QBCore = exports['qb-core']:GetCoreObject()
local fishing = false
local pause = false
local pausetimer = 0
local correct = 0
local genderNum = 0
local peds = {} 

CreateThread(function()
    for k, v in pairs(Config.PedList) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
            Wait(1)
        end

        local ped = CreatePed(0, GetHashKey(v.model), v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, false)
        SetEntityAsMissionEntity(ped, true, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedFleeAttributes(ped, 0, 0)
        SetPedCombatAttributes(ped, 46, true)
        SetPedCanRagdollFromPlayerImpact(ped, false)
        
        if v.scenario then
            TaskStartScenarioInPlace(ped, v.scenario, 0, true)
        end
        
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
    end
end)

CreateThread(function()
    for _, location in pairs(Config.BoatSpawnLocation) do
        local blip = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite(blip, 410)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 3)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Fishing Spot")
        EndTextCommandSetBlipName(blip)
    end

    local sellBlip = AddBlipForCoord(Config.PearlsSellsBlip.x, Config.PearlsSellsBlip.y, Config.PearlsSellsBlip.z)
    SetBlipSprite(sellBlip, 68)
    SetBlipDisplay(sellBlip, 4)
    SetBlipScale(sellBlip, 0.7)
    SetBlipColour(sellBlip, 5)
    SetBlipAsShortRange(sellBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Fish Sales")
    EndTextCommandSetBlipName(sellBlip)
end)

if Config.TestFish then 
    RegisterCommand("startfish", function()
        TriggerEvent("fishing:fishstart")
    end)

    RegisterCommand('spawnfish', function()
        TriggerServerEvent('fishing:server:catch') 
    end)
end

CreateThread(function()
    while true do
        Wait(1200)
        if pause and fishing then
            pausetimer = pausetimer + 1
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        if fishing then
            if IsControlJustReleased(0, 23) then
                input = 1
            end

            if IsControlJustReleased(0, Config.StopFishing) then
                endFishing()
                QBCore.Functions.Notify('You Stopped Fishing', 'error')
            end

            if fishing then
                local playerPed = PlayerPedId()
                local pos = GetEntityCoords(playerPed)
                if not GetWaterHeight(pos.x, pos.y, pos.z-2, pos.z -3.0) then
                    endFishing()
                    QBCore.Functions.Notify('Water isnt deep enough to fish', 'error')
                end
                if IsEntityDead(playerPed) then
                    endFishing()
                    QBCore.Functions.Notify('Fishing ended', 'error')
                end
            end
            
            if pausetimer > 3 then
                input = 99
            end
            
            if pause and input ~= 0 then
                pause = false
                if input == correct then
                    TriggerEvent('fishing:SkillBar')
                else
                    QBCore.Functions.Notify('The Fish Escaped!', 'error')
                    exports["qb-core"]:HideText()
                    loseBait()
                end
            end
        end
    end
end)

CreateThread(function()
    while true do
        local wait = math.random(Config.FishingWaitTime.minTime, Config.FishingWaitTime.maxTime)
        Wait(wait)
        if fishing then
            pause = true
            correct = 1
            QBCore.Functions.Notify('Fish is biting! Press F', 'primary')
            input = 0
            pausetimer = 0
        end
    end
end)

RegisterNetEvent('fishing:client:attemptTreasureChest', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("open_chest", "Opening Treasure Chest...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function()
        openedTreasureChest()
    end, function()
        QBCore.Functions.Notify("Canceled!", "error")
    end)
end)

RegisterNetEvent('fishing:SkillBar', function()
    if Config.Skillbar == "ps-ui" then
        exports['ps-ui']:Circle(function(success)
            if success then
                catchAnimation()
            else
                QBCore.Functions.Notify('The Fish Got Away!', 'error')
                loseBait()
            end
        end, 3, 8)
    end
end)

RegisterNetEvent('fishing:client:useFishingBox', function(BoxId)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'FishingBox_'..BoxId, {maxweight = 180000, slots = 50})
    TriggerEvent("inventory:client:SetCurrentStash", 'FishingBox_'..BoxId) 
end)

RegisterNetEvent('fishing:fishstart', function()
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed) 
    
    if IsPedSwimming(playerPed) then 
        return QBCore.Functions.Notify("You can't be swimming and fishing at the same time.", "error") 
    end 
    if IsPedInAnyVehicle(playerPed) then 
        return QBCore.Functions.Notify("You need to exit your vehicle to start fishing.", "error") 
    end 
    
    if GetWaterHeight(pos.x, pos.y, pos.z-2, pos.z - 3.0) then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Notify('Started Fishing', 'success')
                fishAnimation()
            else
                QBCore.Functions.Notify("You don't have any fishing bait", "error")
            end
        end, "fishbait")
    else
        QBCore.Functions.Notify('You need to go further away from the shore', 'error')
    end
end)

RegisterNetEvent('doj:client:ReturnBoat', function(args)
    local ped = PlayerPedId()
    local args = tonumber(args)
    if IsPedInAnyVehicle(ped) then
        local returnLocs = {
            [1] = Config.PlayerReturnLocation.LaPuerta,
            [2] = Config.PlayerReturnLocation.PaletoCove,
            [3] = Config.PlayerReturnLocation.ElGordo,
            [4] = Config.PlayerReturnLocation.ActDam,
            [5] = Config.PlayerReturnLocation.AlamoSea
        }
        
        local location = returnLocs[args]
        if location then
            local boat = GetVehiclePedIsIn(ped,true) 
            QBCore.Functions.DeleteVehicle(boat)
            SetEntityCoords(ped, location.x, location.y, location.z, 0, 0, 0, false) 
            SetEntityHeading(ped, location.w)
            TriggerServerEvent('fishing:server:returnDeposit')
        end
    end
end)

RegisterNetEvent('doj:client:rentaBoat', function(args)
    local args = tonumber(args)
    QBCore.Functions.TriggerCallback('fishing:server:checkMoney', function(isSuccess)
        if isSuccess then 
            local spawnLocs = {
                [1] = Config.BoatSpawnLocation.LaPuerta,
                [2] = Config.BoatSpawnLocation.PaletoCove,
                [3] = Config.BoatSpawnLocation.ElGordo,
                [4] = Config.BoatSpawnLocation.ActDam,
                [5] = Config.BoatSpawnLocation.AlamoSea
            }
            
            local location = spawnLocs[args]
            if location then
                QBCore.Functions.SpawnVehicle(Config.RentalBoat, function(boat)
                    SetVehicleNumberPlateText(boat, "FISH"..math.random(1000,9999))
                    exports['cdn-fuel']:SetFuel(boat, 100.0)
                    SetEntityHeading(boat, location.w)
                    TaskWarpPedIntoVehicle(PlayerPedId(), boat, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(boat))
                    SetVehicleEngineOn(boat, true, true)
                end, location, true)
            end
        end
    end)
end)

local rodHandle = 0

function fishAnimation()
    local ped = PlayerPedId()
    local animDict = "amb@world_human_stand_fishing@idle_a"
    local animName = "idle_c"
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(100)
    end
    
    TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, -1, 11, 0, 0, 0, 0)
    
    local fishingRodHash = `prop_fishing_rod_01`
    RequestModel(fishingRodHash)
    while not HasModelLoaded(fishingRodHash) do
        Wait(100)
    end
    
    local pedPos = GetEntityCoords(ped)
    rodHandle = CreateObject(fishingRodHash, pedPos.x, pedPos.y, pedPos.z, true, true, true)
    local bone = GetPedBoneIndex(ped, 18905)
    AttachEntityToEntity(rodHandle, ped, bone, 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
    
    fishing = true
end

function endFishing()
    local ped = PlayerPedId()
    if rodHandle ~= 0 then
        DeleteEntity(rodHandle)
        ClearPedTasks(ped)
        fishing = false
        rodHandle = 0
    end
end

function catchAnimation()
    local ped = PlayerPedId()
    local animDict = "mini@tennis"
    local animName = "forehand_ts_md_far"
    
    DeleteEntity(rodHandle)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(100)
    end
    
    TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1.0, 0, 0, 0, 48, 0)
    QBCore.Functions.Notify('Fish Caught!', 'success', 1750)
    Wait(1750)
    TriggerServerEvent('fishing:server:catch') 
    loseBait()
    PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    RemoveAnimDict(animDict)
    endFishing()
end

function loseBait()
    local chance = math.random(1, 15)
    if chance <= 5 then
        TriggerServerEvent("fishing:server:removeFishingBait")
    end
end

function openedTreasureChest()
    if math.random(1,15) == 10 then
        TriggerServerEvent("QBCore:Server:RemoveItem", "fishingkey", 1)
        QBCore.Functions.Notify("The corroded key has snapped", "error", 7500)
    end
    
    TriggerServerEvent("QBCore:Server:RemoveItem", "fishinglootbig", 1)
    QBCore.Functions.Notify("Treasure chest opened!", "success", 7500)
    
    local ShopItems = {} 
    ShopItems.label = "Treasure Chest"
    ShopItems.items = Config.largeLootboxRewards
    ShopItems.slots = #Config.largeLootboxRewards
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Vendingshop_", ShopItems)
end