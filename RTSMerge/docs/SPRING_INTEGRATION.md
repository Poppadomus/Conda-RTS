# Spring integration contract

RTSMerge is a Spring game definition, not a rewrite of Spring's simulation core. Spring remains responsible for deterministic simulation, pathfinding, rendering, networking, commands, and resource accounting.

## Rules
1. Spring metal is the authoritative RA2 credit ledger; UI may label it Credits.
2. Spring energy is the authoritative RA2 power ledger.
3. RA2-specific rules belong in units, weapons, gamedata, LuaRules/Gadgets, and LuaUI.
4. The ra2-games/ra2 project is a behavioral/resource reference; its documentation confirms original game files remain player-provided resources.
5. Original RA2/YR MIX, SHP, PAL, TMP, VXL, HVA and CSF data is imported locally and converted to Spring-native assets.
6. A feature is not complete until its synced implementation has a deterministic validation path.

## Current vertical slice
- Three factions: Allies, Soviet Union, Yuri
- MCV units and faction construction yards
- Core power, refinery, barracks and war factory structures
- Allied Grizzly + GI
- Soviet Rhino + Conscript
- Yuri Lasher + Initiate
- Faction harvesters
- Spring metal = RA2 credits; Spring energy = RA2 power

Not yet claimed complete: MCV deployment, sidebar UI, ore-field maps, country bonuses, veterancy, superweapons, aircraft, naval rules, and complete asset conversion.
