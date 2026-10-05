# RTSMerge playable demo

This branch now targets a small asset-free RA2-style vertical slice.

## Demo loop

1. Start a two-side Spring skirmish on any compatible Spring map with start positions.
2. Select your MCV and click **DEPLOY CONSTRUCTION YARD**.
3. Select the Construction Yard and use the **CONSTRUCTION** sidebar.
4. Build a Power Plant, then Refinery, then Barracks or War Factory.
5. Your starter harvester automatically travels to the deterministic ore field and waits for a refinery, then delivers ore as metal/credits.
6. Select the Barracks or War Factory and use the **PRODUCTION** sidebar.
7. Queue infantry, tanks, or another harvester.
8. Select produced units and issue normal Spring move/attack orders.
9. Destroy the opposing team's units to trigger victory.

## What is procedural

No Red Alert 2/Yuri's Revenge game assets are required. Units and buildings are represented by the procedural renderer and the repository's generated model.

## Current demo systems

- faction MCV bootstrap
- MCV deployment
- construction prerequisites and placement validation
- starting credits and metal storage
- starter harvester + deterministic ore/refinery loop
- power ratio and low-power state
- low-power factory pause
- clickable construction sidebar
- clickable production sidebar
- deterministic production queue and resource charging
- procedural demo HUD
- native Spring movement/combat
- basic elimination victory condition

## Important limitation

A live Spring engine/map is still required to actually launch the match. This repository does not ship a proprietary RA2/YR map or original game assets. The code can be exercised on a normal Spring map with at least two playable sides.
