ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Config = require('config')

-- Function to deduct insurance cost for all online players and their vehicles from DB
local function deductInsurance()
    for _, playerId in ipairs(GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(tonumber(playerId))
        if xPlayer then
            -- Fahrzeuge aus der DB holen (Tabelle: owned_vehicles, Spalte: owner = identifier)
            local identifier = xPlayer.getIdentifier()
            MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @identifier', {
                ['@identifier'] = identifier
            }, function(vehicles)
                if vehicles and #vehicles > 0 then
                    for _, vehicle in ipairs(vehicles) do
                        xPlayer.removeAccountMoney('bank', Config.insuranceCost)
                        local plate = vehicle.plate or 'Unbekanntes Kennzeichen'
                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Für dein Fahrzeug mit dem Kennzeichen ' .. plate .. ' wurden $' .. Config.insuranceCost .. ' Versicherungsgebühr abgezogen!')
                    end
                end
            end)
        end
    end
end

-- Set up a timer to deduct insurance every konfigurierbares Intervall
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.deductionInterval * 60 * 1000) -- Intervall in Minuten aus der Config
        deductInsurance()
    end
end)