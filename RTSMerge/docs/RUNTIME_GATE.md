# Runtime gate

Static validation is not completion. A playable milestone requires:
1. Spring loads the game without Lua errors.
2. At least one complete faction can deploy an MCV and build a base.
3. Infantry and vehicles can move and attack.
4. Harvesters can collect and return resources.
5. Production, power, combat and veterancy interact in one match.
6. A save/load or deterministic replay smoke test passes.
7. Converted models are present for every playable unit.
8. A multiplayer synchronization smoke test passes.

Until these checks pass, RTSMerge is a development conversion and must not be described as a finished RA2/YR replacement.
