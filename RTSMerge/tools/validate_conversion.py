#!/usr/bin/env python3
"""Fail-fast static validation for the RA2/YR -> Spring conversion."""
from pathlib import Path
import re,sys
ROOT=Path(__file__).resolve().parents[1]; errors=[]; warnings=[]
u=ROOT/"units"/"unitdefs.lua"; w=ROOT/"weapons"/"ra2_weapons.lua"; obj=ROOT/"objects3d"
if not u.exists(): errors.append("units/unitdefs.lua is missing")
else:
 text=u.read_text(encoding="utf-8")
 names=re.findall(r"^\s*([A-Za-z0-9_]+)\s*=\s*(?:vehicle|building|infantry)\(",text,re.M)
 if not names: errors.append("No native unit definitions found")
 if not obj.exists(): errors.append("objects3d/ is missing")
 if not w.exists(): errors.append("weapons/ra2_weapons.lua is missing")
 for n in names:
  block=re.search(rf"^\s*{re.escape(n)}\s*=\s*(.+?)(?=^\s*[A-Za-z0-9_]+\s*=|\Z)",text,re.M|re.S)
  if block and "objectname" not in block.group(1): errors.append(f"{n}: missing objectname")
rules=ROOT/"gamedata"/"ra2_rules.lua"
if not rules.exists(): errors.append("gamedata/ra2_rules.lua is missing")
for d in ("LuaRules/Gadgets","LuaUI/Widgets"): 
 if not (ROOT/d).exists(): errors.append(f"{d} is missing")
if errors:
 print("RTSMerge conversion validation FAILED:")
 for e in errors: print(" -",e)
 sys.exit(1)
print(f"Static validation passed for {len(names)} authored unit definitions.")
if warnings:
 for w in warnings: print("WARNING:",w)
