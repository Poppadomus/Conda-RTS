#!/usr/bin/env python3
"""Validate and stage a user-supplied C&C installation for RTSMerge."""
from pathlib import Path
import argparse

REQUIRED=("CONQUER.MIX","GENERAL.MIX")
OPTIONAL=("LOCAL.MIX","CCLOCAL.MIX","SOUNDS.MIX","SPEECH.MIX")

def find(root,name):
    wanted=name.lower()
    for p in root.rglob('*'):
        if p.is_file() and p.name.lower()==wanted: return p
    return None

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('game_dir',type=Path)
    ap.add_argument('--out',type=Path,default=Path('RTSMerge/assets/imported'))
    a=ap.parse_args(); root=a.game_dir.expanduser().resolve()
    if not root.is_dir(): raise SystemExit(f'Not a directory: {root}')
    missing=[n for n in REQUIRED if find(root,n) is None]
    if missing: raise SystemExit('Missing required C&C data: '+', '.join(missing))
    a.out.mkdir(parents=True,exist_ok=True)
    print(f'Validated C&C data at {root}')
    for n in REQUIRED+OPTIONAL:
        p=find(root,n)
        if p: print(f'  found {n}: {p}')
    print(f'Asset staging directory: {a.out.resolve()}')

if __name__=='__main__': main()
