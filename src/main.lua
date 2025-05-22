ESX = nil

local Config = require('config')

-- Function to deduct insurance cost for all online players and their vehicles from DB
local function deductInsurance()
    for _, playerId in ipairs(GetPlayers()) do
        print('Prüfe Spieler:', playerId)
        local xPlayer = ESX.GetPlayerFromId(tonumber(playerId))
        if not xPlayer then print('Kein xPlayer für', playerId) end
        if xPlayer then
            local identifier = xPlayer.getIdentifier()
            print('Identifier:', identifier)
            MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @identifier', {
                ['@identifier'] = identifier
            }, function(vehicles)
                print('Gefundene Fahrzeuge:', json.encode(vehicles))
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

-- Set up a timer to deduct insurance using the interval from config
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.deductionInterval) -- Intervall in Minuten aus der Config (z.B. 0.1667 für 10 Sekunden)
        deductInsurance()
    end
end)