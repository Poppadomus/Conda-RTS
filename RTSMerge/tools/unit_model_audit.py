#!/usr/bin/env python3
"""Audit the RA2 roster for runtime-generated visual metadata."""
from pathlib import Path
import re,sys
ROOT=Path(__file__).resolve().parents[1]
u=ROOT/"units/unitdefs.lua"
r=ROOT/"units/ra2_roster.lua"
w=ROOT/"LuaUI/Widgets/ra2_procedural_renderer.lua"
if not u.exists() or not r.exists() or not w.exists():
    raise SystemExit("procedural roster files missing")
s=(u.read_text(encoding="utf-8")+r.read_text(encoding="utf-8"))
count=len(re.findall(r"ra2_procedural",s))
arches=set(re.findall(r'ra2_visual[=]?"?([A-Za-z_]+)',s))
if count < 20:
    print("Too few procedural unit definitions:",count); sys.exit(1)
print(f"Audited {count} procedural visual declarations.")
