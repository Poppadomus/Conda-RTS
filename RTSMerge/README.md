# RTSMerge

RTSMerge is an open-source Spring Engine RTS project aiming to reproduce the **systems and feel** of classic Command & Conquer-style real-time strategy without redistributing proprietary game assets.

## Current branch

This work lives on the `RTSMerge` branch of `Conda-RTS`.

## Design

- Spring Engine runtime
- GDI vs Nod architecture
- Tiberium-inspired economy
- Construction Yard / MCV workflow
- Sidebar-style production as the target UI
- Power management
- C&C-style infantry, vehicles and structures
- Deterministic synced gameplay logic
- User-supplied asset import path rather than bundled EA assets

## Repository policy

No EA/Westwood proprietary sprites, maps, sounds, music, logos, or extracted game archives are committed here.

The project code should remain independently distributable. Asset conversion/import tooling should operate on files supplied by the user.

## First playable milestone

1. Start a Spring game with the RTSMerge mod.
2. Spawn a GDI MCV.
3. Deploy a Construction Yard.
4. Build a Refinery, Power Plant and Barracks.
5. Establish a Tiberium field/harvester economy.
6. Produce basic infantry and vehicles.
7. Add Nod as the second playable faction.

## Engine setup

RTSMerge does not bundle the Spring engine. Install a compatible Spring runtime separately, then package this directory as a Spring game/mod according to the runtime's normal content layout.

## Licensing

Code authored for RTSMerge should use GPL-3.0-or-later unless a more permissive license is explicitly chosen for a specific component.

Command & Conquer is a trademark of Electronic Arts/Westwood. This project is unofficial and is not endorsed by EA.

See `LICENSE` and `docs/ASSETS.md` for details.
