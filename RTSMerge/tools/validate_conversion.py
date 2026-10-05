#!/usr/bin/env python3
"""Fail-fast validation for the Spring-side RA2/YR conversion."""
from pathlib import Path
import re,sys
ROOT=Path(__file__).resolve().parents[1]; errors=[]
required=["modinfo.lua","gamedata/unitdefs.lua","gamedata/weapondefs.lua","gamedata/sidedata.lua","gamedata/ra2_rules.lua","units/unitdefs.lua","weapons/ra2_weapons.lua"]
for name in required:
 if not (ROOT/name).exists(): errors.append("missing "+name)
text=(ROOT/"units/unitdefs.lua").read_text(encoding="utf-8") if (ROOT/"units/unitdefs.lua").exists() else ""
names=re.findall(r"^\s*([A-Za-z0-9_]+)\s*=\s*(?:vehicle|building|infantry)\(",text,re.M)
if not names: errors.append("no authored unit definitions")
if not (ROOT/"objects3d").exists(): errors.append("missing objects3d directory")
if not (ROOT/"LuaRules/Gadgets").exists(): errors.append("missing gadget directory")
if not (ROOT/"LuaUI/Widgets").exists(): errors.append("missing widget directory")
if errors:
 print("RTSMerge conversion validation FAILED")
 for e in errors: print(" - "+e)
 sys.exit(1)
print(f"Static conversion structure passed: {len(names)} authored units.")
