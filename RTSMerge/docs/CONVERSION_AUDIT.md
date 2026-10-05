# Conversion audit

RTSMerge remains an active Spring conversion and is not yet a complete RA2/YR replacement.

Implemented infrastructure includes faction definitions, Spring loaders, synced economy/power/production/combat scaffolding, an explicit queued-unit spawn path, and local proprietary-asset import tooling.

Remaining acceptance blockers include converted models/textures for the playable roster, complete INI semantic import, exact economy/combat/interface behavior, full country bonuses and superweapons, naval/air/psychic/stealth/transport parity, campaigns and AI, multiplayer synchronization, deterministic replay, save/load, and runtime verification on the target Spring engine.

The branch must not be described as finished until these blockers pass actual Spring tests.
