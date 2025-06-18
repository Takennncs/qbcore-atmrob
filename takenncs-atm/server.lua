local QBCore = exports['qb-core']:GetCoreObject()

local Config = {
    MoneyMin = 500,
    MoneyMax = 1500,
    ATMCooldown = 10 * 60 * 1000
}

lib.callback.register('takenncs-atm:hasCard', function(source)
    local hasItem = exports.ox_inventory:Search(source, 'count', 'krediitkaart') -- ROBBERY ITEM
    return hasItem > 0
end)

RegisterServerEvent('takenncs-atm:giveMoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        local amount = math.random(Config.MoneyMin, Config.MoneyMax)
        Player.Functions.AddMoney('cash', amount, "atm-robbery")

        TriggerClientEvent('takenncs-atm:notify', src, 'success', 'Said $' .. amount)
    end
end)

RegisterServerEvent('takenncs-atm:removeCard', function()
    local src = source
    exports.ox_inventory:RemoveItem(src, 'krediitkaart', 1)
end)


