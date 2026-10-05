#!/usr/bin/env python3
"""Static structural checks for RTSMerge Lua files."""
from pathlib import Path
import re,sys
ROOT=Path(__file__).resolve().parents[1]
errors=[]
for p in list((ROOT/"LuaRules"/"Gadgets").glob("*.lua"))+list((ROOT/"LuaUI"/"Widgets").glob("*.lua")):
    s=p.read_text(encoding="utf-8")
    if s.count("function ")>s.count("end"):
        errors.append(f"{p.relative_to(ROOT)}: fewer 'end' tokens than function declarations")
    if "gadgetHandler:IsSyncedCode()" in s and "Spring." not in s and "UnitDefs" not in s:
        pass
for p in [ROOT/"gamedata"/"unitdefs.lua",ROOT/"gamedata"/"weapondefs.lua",ROOT/"gamedata"/"sidedata.lua"]:
    if not p.exists(): errors.append(f"missing {p.relative_to(ROOT)}")
if errors:
    print("Lua structural validation FAILED")
    for e in errors: print(" -",e)
    raise SystemExit(1)
print("Lua structural validation passed.")
