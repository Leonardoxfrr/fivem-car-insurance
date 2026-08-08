# FiveM Car Insurance

Serverseitiger ESX-Prototyp für wiederkehrende Versicherungsabbuchungen pro registriertem Fahrzeug. In einem festen Intervall werden die Fahrzeuge aktuell verbundener Spieler aus `owned_vehicles` gelesen und die konfigurierte Gebühr vom Bankkonto abgezogen.

## Funktionsweise

1. Der Server wartet das in `Config.deductionInterval` definierte Intervall ab.
2. Für jeden aktuell verbundenen ESX-Spieler werden dessen Einträge aus `owned_vehicles` geladen.
3. Pro gefundenem Fahrzeug wird `Config.insuranceCost` vom Bankkonto abgezogen.
4. Der Spieler erhält eine Meldung über die Gesamtabbuchung.

Standardwerte:

```lua
Config.insuranceCost = 100
Config.deductionInterval = 30 -- Minuten
```

Die Zahl `30` wird vom Code als Minuten verarbeitet. Anderslautende ältere Kommentare in der Konfiguration sind nicht maßgeblich.

## Voraussetzungen

- FiveM/FXServer
- ESX
- `oxmysql`
- eine ESX-kompatible Tabelle `owned_vehicles` mit mindestens der Spalte `owner`

## Installation

1. Ressource in das FiveM-Ressourcenverzeichnis kopieren.
2. Gebühren und Intervall in `config.lua` festlegen.
3. Startreihenfolge konfigurieren:

```cfg
ensure oxmysql
ensure es_extended
ensure fivem-car-insurance
```

4. Ablauf mit Testkonten und mehreren Fahrzeugen in einer Staging-Datenbank prüfen.

## Grenzen des aktuellen Prototyps

- Nur online befindliche Spieler werden verarbeitet; für Offline-Spieler gibt es keine Nachverrechnung.
- Jeder Datensatz in `owned_vehicles` zählt als ein versichertes Fahrzeug, unabhängig von Zustand oder Fahrzeugklasse.
- Es gibt keine eigene Versicherungstabelle, Police, Fälligkeit oder Historie.
- Der Zeitplan wird nur im Arbeitsspeicher geführt und ist nicht idempotent oder neustartsicher.
- Kontostand, Negativlimit und mögliche Fehlbuchungen werden nicht als eigener Geschäftsfall behandelt.
- Datenbank- und Abbuchungsfehler besitzen keinen vollständigen Wiederholungs- oder Ausgleichsmechanismus.

## Produktionshinweise

Vor einem Live-Einsatz sollten Policen und Zahlungen persistent modelliert, Buchungen transaktional abgesichert und doppelte Ausführungen verhindert werden. Zusätzlich sind Audit-Logs, Offline-Verarbeitung, klare Regeln für nicht gedeckte Konten und administrative Korrekturmöglichkeiten sinnvoll.
