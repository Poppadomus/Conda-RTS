# Red Alert 2: Spring

RTSMerge is now being pivoted into a Red Alert 2-style Spring Engine game.

The project uses ra2-games/ra2 as a reference for Red Alert 2 systems and content, while Spring provides the deterministic RTS runtime.

## Target factions

- Allies
- Soviet Union
- Yuri

## Target gameplay

- MCV deployment and Construction Yard
- Ore / gem harvesting and refinery economy
- Power production and power deficits
- Sidebar-style production
- Infantry, vehicles, naval units and aircraft
- Base defenses
- Superweapons
- Veterancy
- Country-specific bonuses
- RA2-style fog of war and combat pacing

## First playable vertical slice

1. Allied MCV
2. Deploy Construction Yard
3. Power Plant
4. Ore Refinery
5. Barracks
6. War Factory
7. Grizzly Tank
8. GI
9. Harvester
10. Ore field economy
11. Soviet and Yuri factions

## Asset strategy

The project is designed to ingest legally supplied Red Alert 2 / Yuri's Revenge game assets. The repository contains conversion/import tooling and Spring definitions; proprietary source game archives are not assumed to be redistributable merely because the source code is public.

## Relationship to ra2-games/ra2

ra2-games/ra2 is a fan-made GPL-3.0 web port of Red Alert 2 with Yuri's Revenge and multiplayer support. RTSMerge is a separate Spring implementation. Compatible open-source code can be reused only where licensing and architecture permit.
