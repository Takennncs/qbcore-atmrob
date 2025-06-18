local QBCore = exports['qb-core']:GetCoreObject()

if not Config then
    Config = {
        ATMModels = {
            `prop_atm_01`,
            `prop_atm_02`,
            `prop_atm_03`
        },
        ATMCooldown = 10 * 60 * 1000
    }
end

local robbedATMs = {}
local currentATM = nil

Citizen.CreateThread(function()
    for _, model in pairs(Config.ATMModels or {}) do
        exports.ox_target:addModel(model, {
            {
                name = 'takenncs-atm',
                icon = 'fas fa-money-bill',
                label = 'ATM Valikud',
                onSelect = function(entity)
                    OpenATMMenu(entity)
                end
            }
        })
    end
end)

function OpenATMMenu(entity)
    currentATM = entity
    lib.callback('takenncs-atm:hasCard', false, function(hasCard)
        local options = {
            {
                title = 'Vaata kontoseisu',
                description = 'Vaata oma raha kontol',
                icon = 'fas fa-wallet',
                onSelect = function()
                    ShowBalance()
                end
            },
            {
                title = 'Tühista',
                icon = 'fas fa-times',
                onSelect = function() end
            }
        }

        if hasCard then
            table.insert(options, 1, {
                title = 'Röövi ATM',
                description = 'Tühjenda ATM',
                icon = 'fas fa-money-bill',
                onSelect = function()
                    StartRobbery()
                end
            })
        end

        lib.registerContext({
            id = 'atm_robbery_menu',
            title = 'ATM Menüü',
            options = options
        })

        lib.showContext('atm_robbery_menu')
    end)
end

function ShowBalance()
    local player = QBCore.Functions.GetPlayerData()
    local cash = player.money['cash'] or 0
    local bank = player.money['bank'] or 0
    QBCore.Functions.Notify('Sularaha: $' .. cash .. ', Pangas: $' .. bank, 'info', 5000)
end

function StartRobbery()
    if not currentATM then
        QBCore.Functions.Notify('ATM puudub!', 'error')
        return
    end

    if robbedATMs[currentATM] then
        QBCore.Functions.Notify('See ATM on hiljuti röövitud! Proovi hiljem uuesti.', 'error')
        return
    end

    local playerPed = PlayerPedId()

    lib.requestAnimDict('mini@safe_cracking')
    TaskPlayAnim(playerPed, 'mini@safe_cracking', 'dial_turn_anti_fast_1', 8.0, -8.0, -1, 49, 0, false, false, false)

    local success = lib.skillCheck({'easy', 'medium', 'hard'}, {'w', 'a', 's', 'd'})
    ClearPedTasks(playerPed)

    if success then
        robbedATMs[currentATM] = true

        lib.requestAnimDict('mini@repair')
        TaskPlayAnim(playerPed, 'mini@repair', 'fixing_a_player', 8.0, -8.0, -1, 1, 0, false, false, false)

        lib.progressBar({
            duration = 6000,
            label = 'Röövid ATM-i...',
            useWhileDead = false,
            canCancel = false,
            disable = { move = true, car = true, combat = true },
        })

        ClearPedTasks(playerPed)

        SetTimeout(Config.ATMCooldown or (10 * 60 * 1000), function()
            robbedATMs[currentATM] = nil
        end)

        TriggerServerEvent('takenncs-atm:removeCard')
        TriggerServerEvent('takenncs-atm:giveMoney')
    else
        QBCore.Functions.Notify('Sa ei saanud hakkama!', 'error')
    end
end

RegisterNetEvent('takenncs-atm:notify', function(type, message)
    QBCore.Functions.Notify(message, type)
end)
