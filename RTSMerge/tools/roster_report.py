#!/usr/bin/env python3
"""Report authored RA2S unit/weapon roster coverage."""
from pathlib import Path
import re
ROOT=Path(__file__).resolve().parents[1]
u=(ROOT/"units/unitdefs.lua").read_text(encoding="utf-8") if (ROOT/"units/unitdefs.lua").exists() else ""
w=(ROOT/"weapons/ra2_weapons.lua").read_text(encoding="utf-8") if (ROOT/"weapons/ra2_weapons.lua").exists() else ""
units=re.findall(r"^\s*([A-Za-z0-9_]+)\s*=\s*(?:vehicle|building|infantry)\(",u,re.M)
weapons=re.findall(r"^\s*([A-Za-z0-9_]+)\s*=\s*\{",w,re.M)
print("Units:",len(units)); print("Weapons:",len(weapons))
for n in units: print(" UNIT",n)
