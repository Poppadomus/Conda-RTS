# RTSMerge conversion audit

This checklist is intentionally strict: a missing item is a blocker to calling the conversion playable.

## Engine/runtime
- [x] Spring mod metadata
- [x] synced LuaRules architecture
- [x] native LuaUI integration
- [x] Spring sidedata structure
- [ ] actual Spring runtime smoke test
- [ ] deterministic multiplayer replay test
- [ ] save/load test

## Rules
- [x] faction definitions
- [x] construction prerequisites
- [x] native production build options
- [x] MCV deploy/undeploy command
- [x] initial veterancy framework
- [x] power accounting framework
- [ ] exact RA2/YR rules imported from owned INI data
- [ ] exact build costs/times/armor/warheads
- [ ] all RA2/YR country bonuses
- [ ] full veterancy promotion/healing/firepower rules
- [ ] superweapons and charge rules

## Economy
- [x] Spring resource ledger
- [x] credit storage
- [ ] actual ore/gem map fields
- [ ] harvester pathing and loading
- [ ] refinery delivery/unloading
- [ ] ore depletion and regeneration behavior
- [ ] Chrono Miner teleport-return behavior
- [ ] War Miner armor/cargo behavior
- [ ] Yuri Slave Miner/slave-worker behavior

## Content
- [ ] complete RA2 roster
- [ ] complete Yuri's Revenge roster
- [ ] all buildings
- [ ] all infantry
- [ ] all vehicles
- [ ] all aircraft
- [ ] all naval units
- [ ] transports and deployables
- [ ] base defenses, walls and gates
- [ ] bridges and map objects
- [ ] complete weapon/warhead system
- [ ] target/armor classes

## Assets
- [x] proprietary-data-safe local import workflow
- [x] MIX extraction foundation
- [ ] extended/encrypted MIX support
- [ ] MIX filename/hash resolution
- [ ] SHP/PAL/TMP decoding
- [ ] VXL/HVA conversion to Spring models
- [ ] infantry/building/vehicle animations
- [ ] CSF localization conversion
- [ ] audio conversion
- [ ] movie/campaign media integration
- [ ] actual converted assets installed in a playable package

## Interface
- [x] resource HUD
- [x] production sidebar foundation
- [ ] clickable production queues
- [ ] build placement preview
- [ ] unit/structure information panels
- [ ] power warning states
- [ ] superweapon buttons/timers
- [ ] veteran/elite indicators
- [ ] RA2-style tactical controls

## World/game modes
- [ ] fog-of-war parity
- [ ] radar/spy satellite
- [ ] AI/skirmish
- [ ] multiplayer lobby/start configuration
- [ ] RA2/YR map conversion
- [ ] campaign mission framework
- [ ] campaign triggers/objectives
- [ ] mission scripting compatibility

## Quality gate
The branch must not be described as a finished RA2/YR conversion until the unchecked blockers above are implemented and a real Spring runtime smoke test succeeds. In particular, the current unit definitions intentionally fail conversion validation until actual Spring-compatible models are installed.
