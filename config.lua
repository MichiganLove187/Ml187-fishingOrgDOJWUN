Config = {}

Config.Fish24hours = true
Config.FishingWaitTime = {minTime = 21000, maxTime = 45000}
Config.RentalBoat = "dinghy"
Config.StopFishing = 73
Config.BoatPrice = 100
Config.TestFish = false
Config.Skillbar = "ps-ui"
Config.targetExport = "qb-target"

Config.PearlsSellsBlip = vector3(-1816.406, -1193.334, 13.305)

Config.BoatSpawnLocation = {
    LaPuerta    = vector4(-802.05, -1504.36, -0.47, 112.27),
    PaletoCove  = vector4(-1599.932, 5259.831, 1.578, 20.6317),
    ElGordo     = vector4(3372.705, 5188.673, 0.121, 272.03),
    ActDam      = vector4(1701.506, 43.897, 161.767, 188.579),
    AlamoSea    = vector4(1294.363, 4232.013, 31.709, 160.441),
}

Config.PlayerReturnLocation = {
    LaPuerta    = vector4(-802.883, -1495.654, 1.595, 294.265),
    PaletoCove  = vector4(-1605.342, 5258.052, 2.083, 292.725),
    ElGordo     = vector4(3371.141, 5183.996, 1.46, 99.634),
    ActDam      = vector4(1695.805, 43.456, 161.767, 103.579),
    AlamoSea    = vector4(1301.1, 4233.696, 33.909, 337.548),
}

Config.fishingRodPrice = 50
Config.fishingBaitPrice = 5
Config.BoatAnchorPrice = 500
Config.FishingBoxPrice = 1000

Config.mackerelPrice     = 5
Config.codfishPrice      = 15
Config.bassPrice         = 35
Config.flounderPrice     = 40
Config.stingrayPrice     = 50

Config.dolphinPrice      = 100
Config.sharktigerPrice   = 200
Config.sharkhammerPrice  = 200
Config.killerwhalePrice  = 500

Config.smallLootboxCash = 100
Config.smallLootboxReward = 'diamond_ring'

Config.largeLootboxRewards = {
    [1] = { name = "water", price = 0, amount = 1, info = {}, type = "item", slot = 1, },
    [2] = { name = "sandwich", price = 0, amount = 1, info = {}, type = "item", slot = 2, },
    [3] = { name = "lockpick", price = 0, amount = 1, info = {}, type = "item", slot = 3, },
    [4] = { name = "weapon_knife", price = 0, amount = 1, info = {}, type = "item", slot = 4, },
}

Config.PedList = {
    {
        model = "s_m_y_ammucity_01",
        coords = vector4(-806.17, -1496.57, 0.6, 100.0),
        scenario = "WORLD_HUMAN_STAND_FISHING"
    },
    {
        model = "u_m_m_filmdirector",
        coords = vector4(-1604.236, 5256.483, 1.073, 291.202),
        scenario = "WORLD_HUMAN_STAND_FISHING"
    },
    {
        model = "s_m_o_busker_01",
        coords = vector4(3373.215, 5183.515, 0.46, 266.111),
        scenario = "WORLD_HUMAN_STAND_FISHING"
    },
    {
        model = "ig_cletus",
        coords = vector4(1694.811, 39.927, 160.767, 191.786),
        scenario = "WORLD_HUMAN_STAND_FISHING"
    },
    {
        model = "a_m_m_hillbilly_01",
        coords = vector4(1299.665, 4231.885, 32.909, 81.693),
        scenario = "WORLD_HUMAN_STAND_FISHING"
    },
    {
        model = "s_m_y_busboy_01",
        coords = vector4(-1816.406, -1193.334, 13.305, 325.172),
        scenario = "WORLD_HUMAN_CLIPBOARD"
    },
}