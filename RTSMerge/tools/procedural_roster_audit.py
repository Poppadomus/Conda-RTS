#!/usr/bin/env python3
from pathlib import Path
import re,sys
ROOT=Path(__file__).resolve().parents[1]
files=[ROOT/"units/unitdefs.lua",ROOT/"units/ra2_roster.lua",ROOT/"units/ra2_structures.lua"]
text="\n".join(p.read_text(encoding="utf-8") for p in files if p.exists())
errors=[]
if "ra2_procedural" not in text: errors.append("no procedural unit metadata")
if len(re.findall(r"ra2_visual",text))<20: errors.append("procedural roster is too small")
for name in ("ra2_procedural_renderer.lua","ra2_visual_status.lua"):
 if not (ROOT/"LuaUI/Widgets"/name).exists(): errors.append("missing widget: "+name)
if errors:
 print("Procedural roster audit FAILED")
 for e in errors: print(" - "+e)
 sys.exit(1)
print("Procedural roster audit passed.")
