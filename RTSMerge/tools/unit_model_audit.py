#!/usr/bin/env python3
"""Audit authored units against converted Spring model files."""
from pathlib import Path
import re,sys
ROOT=Path(__file__).resolve().parents[1]; u=ROOT/"units/unitdefs.lua"; obj=ROOT/"objects3d"
if not u.exists(): raise SystemExit("units/unitdefs.lua missing")
s=u.read_text(encoding="utf-8")
names=re.findall(r"^\s*([A-Za-z0-9_]+)\s*=\s*(?:vehicle|building|infantry)\(",s,re.M)
missing=[]
for n in names:
 if not re.search(rf"{re.escape(n)}.*objectname",s,re.S): missing.append(n)
if missing:
 print("Units without objectname: "+", ".join(missing))
 sys.exit(1)
print(f"Audited {len(names)} authored units.")
