# fivem-car-insurance

## Was macht das Script?
Dieses Script zieht automatisch in einem einstellbaren Intervall (z.B. alle 10 Sekunden oder 30 Minuten) für jedes Fahrzeug eines Spielers einen Versicherungsbetrag direkt vom Bankkonto ab. Die Fahrzeuge werden aus der Datenbank (Tabelle `owned_vehicles`) geladen und der Spieler erhält für jedes Fahrzeug eine Benachrichtigung mit dem Kennzeichen.

## Wie kann man das Intervall oder den Betrag ändern?
Öffne die Datei `config.lua` und passe dort folgende Werte an:
- `Config.insuranceCost` – Betrag, der pro Fahrzeug abgezogen wird (Standard: 100)
- `Config.deductionInterval` – Intervall in Minuten (z.B. 0.1667 für 10 Sekunden, 30 für 30 Minuten)

---

## What does the script do?
This script automatically deducts an insurance fee from each player's bank account for every vehicle they own, at a configurable interval (e.g. every 10 seconds or 30 minutes). Vehicles are loaded from the database (`owned_vehicles` table) and the player receives a notification with the license plate for each vehicle.

## How can you change the interval or amount?
Open the file `config.lua` and adjust the following values:
- `Config.insuranceCost` – Amount deducted per vehicle (default: 100)
- `Config.deductionInterval` – Interval in minutes (e.g. 0.1667 for 10 seconds, 30 for 30 minutes)
