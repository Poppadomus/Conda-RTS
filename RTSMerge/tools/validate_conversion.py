#!/usr/bin/env python3
"""Static validation for the RA2/YR -> Spring conversion.

This intentionally fails when the game would silently lose content at load time.
It does not validate proprietary source files; those remain player-supplied.
"""

from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
units = ROOT / "units" / "unitdefs.lua"
objects = ROOT / "objects3d"
errors = []

text = units.read_text(encoding="utf-8")
names = re.findall(r"^\s*([A-Za-z0-9_]+)\s*=\s*(?:vehicle|building|infantry)\(", text, re.M)
if not names:
    errors.append("No unit definitions were found.")

for name in names:
    block = re.search(rf"^\s*{re.escape(name)}\s*=\s*(.+?)(?=^\s*[A-Za-z0-9_]+\s*=|\Z)", text, re.M | re.S)
    if block and "objectname" not in block.group(1):
        errors.append(f"{name}: missing objectname; Spring will remove this unit.")

if not objects.exists():
    errors.append("objects3d/ is missing; no Spring unit models are installed.")

if errors:
    print("RTSMerge conversion validation FAILED:")
    for error in errors:
        print(" -", error)
    sys.exit(1)

print("RTSMerge conversion validation passed.")
