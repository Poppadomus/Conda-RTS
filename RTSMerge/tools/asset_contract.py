#!/usr/bin/env python3
"""Validate the local asset contract for a Spring RA2/YR build."""
from pathlib import Path
import argparse,json
REQUIRED_DIRS=("objects3d","textures","maps")
def main():
 p=argparse.ArgumentParser(); p.add_argument("--root",type=Path,default=Path(__file__).resolve().parents[1]); a=p.parse_args()
 errors=[]
 for d in REQUIRED_DIRS:
  if not (a.root/d).exists(): errors.append(f"missing directory: {d}/")
 if errors:
  print("Asset contract FAILED")
  for e in errors: print(" -",e)
  return 1
 print("Asset contract directories present.")
 return 0
if __name__=="__main__": raise SystemExit(main())
