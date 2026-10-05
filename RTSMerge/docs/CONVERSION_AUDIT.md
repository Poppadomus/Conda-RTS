# Conversion audit

RTSMerge is an active Spring conversion and is not yet a complete RA2/YR replacement.

The visual architecture now follows the Conda-RTS approach: the playable roster is rendered procedurally by the game at runtime. No proprietary RA2/YR art package is required for the visible unit renderer. Spring receives a tiny technical model placeholder so its UnitDefs remain valid, while LuaUI suppresses that model and generates the visible geometry.

Implemented infrastructure includes faction definitions, procedural unit/structure rendering, expanded Allied/Soviet/Yuri roster data, Spring loaders, synced economy/power/production/combat scaffolding, queued-unit spawning, and runtime visual validation.

Remaining acceptance blockers include exact INI semantic import, exact economy/combat/interface behavior, full country bonuses and superweapons, complete naval/air/psychic/stealth/transport parity, campaigns and AI, multiplayer synchronization, deterministic replay, save/load, and runtime verification on the target Spring engine.

The branch must not be described as finished until these blockers pass actual Spring tests.
