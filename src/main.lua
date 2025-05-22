local Config = require('config')

local players = {}

--[[
Stelle sicher, dass dieses Script als server_script in der fxmanifest.lua eingetragen ist!
]]

-- Funktioniert nur serversided!

-- Function to deduct insurance cost
local function deductInsurance()
    for playerId, vehicles in pairs(players) do
        -- Prüfe ob Spieler online ist (serverseitig)
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            for _, vehicle in ipairs(vehicles) do
                xPlayer.removeAccountMoney('bank', Config.insuranceCost)
                -- Kennzeichen aus dem Fahrzeugobjekt holen (angenommen vehicle.plate)
                local plate = vehicle.plate or 'Unbekanntes Kennzeichen'
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Für dein Fahrzeug mit dem Kennzeichen ' .. plate .. ' wurden $' .. Config.insuranceCost .. ' Versicherungsgebühr abgezogen!')
            end
        end
    end
end

-- Function to add a player and their vehicles
function AddPlayer(playerId, vehicle)
    if not players[playerId] then
        players[playerId] = {}
    end
    table.insert(players[playerId], vehicle)
end

-- Function to remove a player
function RemovePlayer(playerId)
    players[playerId] = nil
end

-- Set up a timer to deduct insurance every konfigurierbares Intervall
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.deductionInterval * 60 * 1000) -- Intervall in Minuten aus der Config
        deductInsurance()
    end
end)