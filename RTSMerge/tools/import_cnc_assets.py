#!/usr/bin/env python3
"""Stage a legally owned RA2/YR install without committing proprietary data."""
from __future__ import annotations
import argparse,hashlib,json,shutil
from pathlib import Path
BASE=("ra2.mix","language.mix")
YR=("gamemd.exe","ra2md.mix","langmd.mix")
EXT={".mix",".shp",".pal",".tmp",".vxl",".hva",".csf",".aud",".wav",".vqa",".bik",".ini",".map",".mpr",".yrm",".pkt"}
def find(root,name):
    n=name.lower()
    return next((p for p in root.rglob("*") if p.is_file() and p.name.lower()==n),None)
def required(mode):
    return list(BASE)+([] if mode=="ra2" else list(YR))
def validate(root,mode):
    return [n for n in required(mode) if not find(root,n)]
def stage(root,out,mode):
    missing=validate(root,mode)
    if missing: print("Missing required files:",", ".join(missing)); return 2
    out.mkdir(parents=True,exist_ok=True); manifest={"mode":mode,"files":[]}
    for src in root.rglob("*"):
        if not src.is_file() or (src.suffix.lower() not in EXT and src.name.lower() not in YR): continue
        rel=src.relative_to(root); dst=out/rel; dst.parent.mkdir(parents=True,exist_ok=True); shutil.copy2(src,dst)
        h=hashlib.sha256(dst.read_bytes()).hexdigest(); manifest["files"].append({"path":str(rel).replace("\\","/"),"sha256":h,"size":dst.stat().st_size})
    (out/"manifest.json").write_text(json.dumps(manifest,indent=2,sort_keys=True)+"\n",encoding="utf-8")
    print(f"Staged {len(manifest['files'])} files and wrote manifest.json"); return 0
def main():
    p=argparse.ArgumentParser(); p.add_argument("install",type=Path); p.add_argument("--mode",choices=("ra2","yr"),default="yr"); p.add_argument("--out",type=Path,default=Path(__file__).resolve().parents[1]/"assets"/"imported"); a=p.parse_args()
    return stage(a.install.resolve(),a.out.resolve(),a.mode)
if __name__=="__main__": raise SystemExit(main())
