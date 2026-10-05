#!/usr/bin/env python3
"""Inventory locally supplied RA2/YR maps for conversion."""
from pathlib import Path
import argparse,json,hashlib
def main():
 p=argparse.ArgumentParser(); p.add_argument("root",type=Path); p.add_argument("--output",type=Path,default=Path(__file__).resolve().parents[1]/"assets/map_manifest.json"); a=p.parse_args()
 rows=[]
 for f in sorted(a.root.rglob("*")):
  if f.is_file() and f.suffix.lower() in {".map",".mpr",".yrm"}:
   rows.append({"path":str(f.relative_to(a.root)).replace("\\","/"),"size":f.stat().st_size,"sha256":hashlib.sha256(f.read_bytes()).hexdigest()})
 a.output.parent.mkdir(parents=True,exist_ok=True); a.output.write_text(json.dumps({"maps":rows},indent=2)+"\n",encoding="utf-8")
 print(f"Inventoried {len(rows)} maps.")
if __name__=="__main__": main()
