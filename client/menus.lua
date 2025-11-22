local QBCore = exports['qb-core']:GetCoreObject()

function BoatMenuLaPuerta()
    exports['qb-menu']:openMenu({
        {
            header = "La Puerta Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Rent Boat: "..Config.RentalBoat,
            txt = "Price: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
                args = 1
            }
        },
        {
            header = "Close",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

function BoatMenuPaletoCove()
    exports['qb-menu']:openMenu({
        {
            header = "Paleto Cove Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Rent Boat: "..Config.RentalBoat,
            txt = "Price: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
                args = 2
            }
        },
        {
            header = "Close",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

function BoatMenuElGordo()
    exports['qb-menu']:openMenu({
        {
            header = "El Gordo Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Rent Boat: "..Config.RentalBoat,
            txt = "Price: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
                args = 3
            }
        },
        {
            header = "Close",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

function BoatMenuActDam()
    exports['qb-menu']:openMenu({
        {
            header = "Act Dam Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Rent Boat: "..Config.RentalBoat,
            txt = "Price: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
                args = 4
            }
        },
        {
            header = "Close",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

function BoatMenuAlamoSea()
    exports['qb-menu']:openMenu({
        {
            header = "Alamo Sea Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Rent Boat: "..Config.RentalBoat,
            txt = "Price: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
                args = 5
            }
        },
        {
            header = "Close",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

function ReturnBoatLaPuerta()
    exports['qb-menu']:openMenu({
        {
            header = "Return Fishing Boat",
            isMenuHeader = true
        },
        {
            header = "Return Boat",
            txt = "Get refund: $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
                args = 1
            }
        },
        {
            header = "Close",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

function ReturnBoatPaletoCove()
    exports['qb-menu']:openMenu({
        {
            header = "Return Fishing Boat",
            isMenuHeader = true
        },
        {
            header = "Return Boat",
            txt = "Get refund: $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
                args = 2
            }
        },
        {
            header = "Close",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

function ReturnBoatElGordo()
    exports['qb-menu']:openMenu({
        {
            header = "Return Fishing Boat",
            isMenuHeader = true
        },
        {
            header = "Return Boat",
            txt = "Get refund: $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
                args = 3
            }
        },
        {
            header = "Close",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

function ReturnBoatActDam()
    exports['qb-menu']:openMenu({
        {
            header = "Return Fishing Boat",
            isMenuHeader = true
        },
        {
            header = "Return Boat",
            txt = "Get refund: $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
                args = 4
            }
        },
        {
            header = "Close",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

function ReturnBoatAlamoSea()
    exports['qb-menu']:openMenu({
        {
            header = "Return Fishing Boat",
            isMenuHeader = true
        },
        {
            header = "Return Boat",
            txt = "Get refund: $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
                args = 5
            }
        },
        {
            header = "Close",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

RegisterNetEvent('doj:client:SellLegalFish', function()
    exports['qb-menu']:openMenu({
        {
            header = "Pearl's Seafood Restaurant - Sell Fish",
            isMenuHeader = true
        },
        {
            header = "Sell Mackerel",
            txt = "Price: $"..Config.mackerelPrice.." each",
            params = {
                isServer = true,
                event = "fishing:server:SellLegalFish",
                args = 1
            }
        },
        {
            header = "Sell Codfish",
            txt = "Price: $"..Config.codfishPrice.." each",
            params = {
                isServer = true,
                event = "fishing:server:SellLegalFish",
                args = 2
            }
        },
        {
            header = "Sell Bass",
            txt = "Price: $"..Config.bassPrice.." each",
            params = {
                isServer = true,
                event = "fishing:server:SellLegalFish",
                args = 3
            }
        },
        {
            header = "Sell Flounder",
            txt = "Price: $"..Config.flounderPrice.." each",
            params = {
                isServer = true,
                event = "fishing:server:SellLegalFish",
                args = 4
            }
        },
        {
            header = "Sell Stingray",
            txt = "Price: $"..Config.stingrayPrice.." each",
            params = {
                isServer = true,
                event = "fishing:server:SellLegalFish",
                args = 5
            }
        },
        {
            header = "Close",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('doj:client:buyFishingGear', function()
    exports['qb-menu']:openMenu({
        {
            header = "Fishing Gear Shop",
            isMenuHeader = true
        },
        {
            header = "Buy Fishing Bait",
            txt = "Price: $"..Config.fishingBaitPrice,
            params = {
                isServer = true,
                event = "fishing:server:BuyFishingGear",
                args = 1
            }
        },
        {
            header = "Buy Fishing Rod",
            txt = "Price: $"..Config.fishingRodPrice,
            params = {
                isServer = true,
                event = "fishing:server:BuyFishingGear",
                args = 2
            }
        },
        {
            header = "Buy Boat Anchor",
            txt = "Price: $"..Config.BoatAnchorPrice,
            params = {
                isServer = true,
                event = "fishing:server:BuyFishingGear",
                args = 3
            }
        },
        {
            header = "Buy Fishing Box",
            txt = "Price: $"..Config.FishingBoxPrice,
            params = {
                isServer = true,
                event = "fishing:server:BuyFishingGear",
                args = 4
            }
        },
        {
            header = "Close",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('doj:client:SellillegalFish', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
            local charinfo = QBCore.Functions.GetPlayerData().charinfo
            QBCore.Functions.Notify('Welcome, '..charinfo.firstname..' '..charinfo.lastname, 'success')
            
            exports['qb-menu']:openMenu({
                {
                    header = "Pearl's Seafood - Exotic Fish",
                    isMenuHeader = true
                },
                {
                    header = "Sell Dolphin",
                    txt = "Price: $"..Config.dolphinPrice.." each",
                    params = {
                        isServer = true,
                        event = "fishing:server:SellillegalFish",
                        args = 1
                    }
                },
                {
                    header = "Sell Tiger Shark",
                    txt = "Price: $"..Config.sharktigerPrice.." each",
                    params = {
                        isServer = true,
                        event = "fishing:server:SellillegalFish",
                        args = 2
                    }
                },
                {
                    header = "Sell Hammerhead Shark",
                    txt = "Price: $"..Config.sharkhammerPrice.." each",
                    params = {
                        isServer = true,
                        event = "fishing:server:SellillegalFish",
                        args = 3
                    }
                },
                {
                    header = "Sell Killer Whale",
                    txt = "Price: $"..Config.killerwhalePrice.." each",
                    params = {
                        isServer = true,
                        event = "fishing:server:SellillegalFish",
                        args = 4
                    }
                },
                {
                    header = "Close",
                    params = {
                        event = "qb-menu:closeMenu"
                    }
                },
            })
        else
            QBCore.Functions.Notify('You need a Pearl\'s membership card to sell exotic fish', 'error', 3500)
        end
    end, "pearlscard")
end)