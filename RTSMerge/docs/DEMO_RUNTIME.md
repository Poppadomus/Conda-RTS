# RTSMerge Demo Runtime

The demo is intended to run as a Recoil game archive/SDD with a compatible Spring/Recoil map. Recoil development copies may be regular folders ending in `.SDD`; production games/maps are normally archives. The engine receives the map and game through the start script.

## Demo loop

Allies or Soviets start with an MCV and harvester. Deploy the MCV, construct power and refinery infrastructure, harvest resources, build Barracks/War Factory units, move and attack the opposing side, and win by eliminating the enemy allyteam.

The current branch contains the gameplay scaffolding and asset-free procedural renderer. A bundled original binary map is intentionally not fabricated in Lua: Spring/Recoil map layout is supplied by a map archive. Use an original development map or compile one with PyMapConv/SpringBoard.

## Development launch

1. Put `RTSMerge` in a Recoil development games directory as `RTSMerge.SDD`.
2. Supply an original compatible map with at least two start positions.
3. Launch the game with `RTSMerge` selected.
4. Verify the runtime self-test output in the infolog.

No original Red Alert 2/Yuri's Revenge assets are required by RTSMerge.
