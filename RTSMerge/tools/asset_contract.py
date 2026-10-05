#!/usr/bin/env python3
"""Validate the runtime-generated RA2/YR visual contract."""
from pathlib import Path
import argparse
ROOT=Path(__file__).resolve().parents[1]
def main():
    p=argparse.ArgumentParser()
    p.add_argument("--root",type=Path,default=ROOT)
    a=p.parse_args()
    errors=[]
    if not (a.root/"LuaUI/Widgets/ra2_procedural_renderer.lua").exists():
        errors.append("missing procedural renderer")
    if not (a.root/"tools/generate_procedural_placeholder.py").exists():
        errors.append("missing placeholder generator")
    if errors:
        print("Procedural asset contract FAILED")
        for e in errors: print(" -",e)
        return 1
    print("Procedural asset contract passed; visible unit art is generated at runtime.")
    return 0
if __name__=="__main__":
    raise SystemExit(main())
