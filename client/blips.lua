CreateThread(function()
    local fishingBlips = {
        {coords = Config.BoatSpawnLocation.LaPuerta, name = "Fishing - La Puerta"},
        {coords = Config.BoatSpawnLocation.PaletoCove, name = "Fishing - Paleto Cove"},
        {coords = Config.BoatSpawnLocation.ElGordo, name = "Fishing - El Gordo"},
        {coords = Config.BoatSpawnLocation.ActDam, name = "Fishing - Act Dam"},
        {coords = Config.BoatSpawnLocation.AlamoSea, name = "Fishing - Alamo Sea"}
    }

    for _, blipInfo in ipairs(fishingBlips) do
        local blip = AddBlipForCoord(blipInfo.coords.x, blipInfo.coords.y, blipInfo.coords.z)
        SetBlipSprite(blip, 410)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 3) 
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(blipInfo.name)
        EndTextCommandSetBlipName(blip)
    end

    local sellBlip = AddBlipForCoord(Config.PearlsSellsBlip.x, Config.PearlsSellsBlip.y, Config.PearlsSellsBlip.z)
    SetBlipSprite(sellBlip, 68) 
    SetBlipDisplay(sellBlip, 4)
    SetBlipScale(sellBlip, 0.7)
    SetBlipColour(sellBlip, 5) 
    SetBlipAsShortRange(sellBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Pearl's Seafood - Fish Sales")
    EndTextCommandSetBlipName(sellBlip)
end)