#!/usr/bin/env python3
"""Build a manifest of converted Spring models without copying proprietary source assets."""
from pathlib import Path
import hashlib,json,argparse
def main():
 p=argparse.ArgumentParser(); p.add_argument("--root",type=Path,default=Path(__file__).resolve().parents[1]/"objects3d"); p.add_argument("--output",type=Path,default=Path(__file__).resolve().parents[1]/"assets/model_manifest.json"); a=p.parse_args()
 rows=[]
 if a.root.exists():
  for f in sorted(a.root.rglob("*")):
   if f.is_file():
    rows.append({"path":str(f.relative_to(a.root)).replace("\\","/"),"size":f.stat().st_size,"sha256":hashlib.sha256(f.read_bytes()).hexdigest()})
 a.output.parent.mkdir(parents=True,exist_ok=True); a.output.write_text(json.dumps({"models":rows},indent=2)+"\n",encoding="utf-8")
 print(f"Manifested {len(rows)} converted model files.")
if __name__=="__main__": main()
