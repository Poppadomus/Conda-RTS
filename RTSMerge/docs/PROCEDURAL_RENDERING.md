# Procedural RA2/YR rendering

RTSMerge uses generated runtime geometry rather than requiring proprietary RA2/YR art files.

Spring receives a technical placeholder model so UnitDefs remain engine-compatible. The visible representation is produced by LuaUI OpenGL primitives. Visual archetypes cover tanks, MCVs, harvesters, infantry, aircraft, naval units and structures.

The renderer consumes synchronized custom parameters such as faction, visual archetype and damage state. This is intentionally separate from the authoritative Spring simulation.