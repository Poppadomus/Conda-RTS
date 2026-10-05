# Conda-RTS RTSMerge — Complete Implementation Checklist

Goal: standalone RA2/Yuri-style RTS in Spring with no original RA2/YR asset dependency. All visuals are procedural/generated.

## 0 Runtime / boot
- [x] Spring modinfo; procedural fallback model; procedural renderer
- [x] Missing gamedata/system.lua
- [ ] Verify packaged mod launches; [ ] minimal test map; [ ] CI smoke test

## 1 Match bootstrap
- [x] Spawn exactly one faction MCV when a team has no starting units
- [x] Starting credits; [x] faction detection; [x] basic team elimination/victory

## 2 Construction
- [x] MCV deploy; [x] Construction Yard; [x] prerequisites; [x] build-radius validation
- [x] Footprint/overlap; [x] map-boundary validation; [ ] terrain/water; [ ] refund/cancel; [ ] nanoframe; [ ] multiple builders
- [ ] MCV undeploy; [x] blocked-placement handling; [ ] deployment animation/state

## 3 Economy
- [x] Deterministic logical ore fields; [x] harvester state machine; [x] cargo; [x] refinery unload
- [x] credit payout; [ ] storage cap; [x] multiple harvesters; [ ] destruction/drop; [ ] gems
- [ ] economy UI; [ ] remove competing economy authorities

## 4 Production
- [x] One authoritative queue; [x] multiple queued units; [x] cost charged once; [x] build time
- [ ] pause/resume; [ ] cancel/refund; [ ] rally point; [ ] spawn validation
- [ ] infantry; [ ] vehicles; [ ] aircraft; [ ] naval; [ ] tech tree; [ ] faction availability
- [x] clickable production UI; [x] queue/progress UI

## 5 Combat
- [x] Spring-native firing; [x] armor/warhead matrix; [x] combat XP; [x] veterancy healing
- [ ] target classes; [ ] ROF/range/accuracy tuning; [ ] splash; [ ] crush; [ ] death effects
- [ ] veteran/elite promotions and bonuses; [ ] combat regression tests

## 6 Power
- [x] Power production/drain/ratio
- [x] Powered-building registration; [x] low-power state; [x] factory production pause; [ ] priority; [ ] restoration; [ ] UI

## 7 Vision/radar/stealth
- [ ] Line of sight; [ ] radar; [ ] shroud; [ ] stealth/cloak; [ ] detection; [ ] minimap

## 8 Factions/countries
- [x] Allies/Soviets/Yuri definitions
- [ ] Country selection; [ ] real country bonuses; [ ] faction-specific availability; [ ] balance

## 9 Yuri
- [ ] Mind control; [ ] psychic attack; [ ] Mastermind; [ ] Yuri Prime; [ ] Brute; [ ] Virus
- [ ] Chaos Drone; [ ] Grinder; [ ] Cloning Vats; [ ] Psychic Radar

## 10 Aircraft
- [ ] VTOL movement/landing; [ ] targeting; [ ] ammo/return; [ ] production; [ ] Kirov/Rocketeer/Siege Chopper/Black Eagle

## 11 Naval/amphibious
- [ ] Water movement; [ ] water placement; [ ] shipyards; [ ] submarines; [ ] amphibious; [ ] naval targeting

## 12 Superweapons
- [ ] Charge/cooldown; [ ] target validation; [ ] Chronosphere; [ ] Iron Curtain; [ ] Weather Control
- [ ] Nuclear Missile; [ ] Psychic Dominator; [ ] Genetic Mutator; [ ] Force Shield; [ ] UI/alerts

## 13 Capture/repair/support
- [ ] Engineer capture; [ ] ownership transfer; [ ] repair depot; [ ] unit repair; [ ] spy infiltration/sabotage; [ ] cloning

## 14 UI/UX
- [ ] RA2 sidebar; [ ] build categories; [ ] clickable production; [ ] queue display; [ ] resources/power
- [ ] health/status; [ ] veterancy; [ ] superweapons; [ ] faction panel; [ ] placement preview; [ ] tooltips; [ ] minimap; [ ] alerts; [ ] hotkeys

## 15 Procedural asset pipeline
- [x] Procedural placeholder and renderer; [x] visual-role metadata
- [ ] Building/infantry/vehicle/aircraft/naval generators; [ ] procedural effects; [ ] faction palettes
- [ ] deterministic visual seeds; [ ] zero-original-assets validation; [ ] asset-free distribution test

## 16 Maps/scenarios
- [ ] Minimal skirmish map; [ ] visible ore fields; [ ] start boxes; [ ] water; [ ] test arena; [ ] multiplayer test map

## 17 AI
- [ ] Economy; [ ] construction; [ ] production; [ ] attack groups; [ ] defense; [ ] harvesting; [ ] faction personalities; [ ] Yuri

## 18 Multiplayer/determinism
- [ ] Deterministic economy/visual seeds; [ ] no synced random divergence; [ ] lockstep-safe state
- [ ] Desync diagnostics; [ ] save/rejoin; [ ] 2-player Allies-vs-Soviets; [ ] 3-faction test

## 19 Testing/tooling
- [x] Lua structure/roster/model audit tools
- [ ] Unit/weapon/build-tree/production validators; [ ] economy invariants; [ ] combat matrix tests
- [x] runtime definition self-test; [ ] automated smoke match; [ ] asset-free package test; [ ] regression suite

## 20 Definition of playable
Start → MCV → deploy → Construction Yard → Power → Refinery → ore → credits → Barracks/War Factory → queue → unit spawn → move → target → fire → damage → destroy → enemy elimination → victory.

First milestone: reliable Allies vs Soviets. Yuri and advanced RA2/YR mechanics follow after that path is proven.