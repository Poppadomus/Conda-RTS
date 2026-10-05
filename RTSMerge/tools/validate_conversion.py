#!/usr/bin/env python3
from pathlib import Path
import re,sys
ROOT=Path(__file__).resolve().parents[1]; errors=[]
for name in ("modinfo.lua","gamedata/unitdefs.lua","gamedata/weapondefs.lua","gamedata/sidedata.lua","gamedata/ra2_rules.lua","units/unitdefs.lua","weapons/ra2_weapons.lua"):
 if not (ROOT/name).exists(): errors.append("missing "+name)
for d in ("objects3d","LuaRules/Gadgets","LuaUI/Widgets"):
 if not (ROOT/d).exists(): errors.append("missing "+d)
text=(ROOT/"units/unitdefs.lua").read_text(encoding="utf-8") if (ROOT/"units/unitdefs.lua").exists() else ""
names=re.findall(r"^\s*([A-Za-z0-9_]+)\s*=\s*(?:vehicle|building|infantry)\(",text,re.M)
if not names: errors.append("no authored unit definitions")
gadgets={p.name for p in (ROOT/"LuaRules/Gadgets").glob("*.lua")} if (ROOT/"LuaRules/Gadgets").exists() else set()
for n in ("ra2_production_spawn.lua","ra2_warheads.lua","ra2_refinery_payout.lua"):
 if n not in gadgets: errors.append("missing "+n)
if errors:
 print("RTSMerge conversion validation FAILED")
 for e in errors: print(" - "+e)
 sys.exit(1)
print(f"Static conversion structure passed: {len(names)} authored units.")
