#!/usr/bin/env python3
"""Import RA2/YR INI rules into deterministic Spring Lua.

The importer preserves the original section/key graph and additionally emits
normalized type lists for the sections Spring needs to instantiate. Source INI
files are always local/player-supplied; generated Lua is safe to commit.
"""
from __future__ import annotations
import argparse,re
from pathlib import Path

TYPE_SECTIONS=("VehicleTypes","InfantryTypes","AircraftTypes","BuildingTypes","WeaponTypes","WarheadTypes","SuperWeaponTypes","Countries","Sides")
def parse_ini(path:Path)->dict[str,dict[str,str]]:
    out={}; cur=None
    for raw in path.read_text(encoding="latin-1",errors="replace").splitlines():
        line=raw.strip()
        if not line or line.startswith((";","#")): continue
        m=re.fullmatch(r"\[([^]]+)\]",line)
        if m: cur=out.setdefault(m.group(1),{}); continue
        if cur is not None and "=" in line:
            k,v=line.split("=",1); cur[k.strip()]=v.strip()
    return out
def q(s:str)->str:
    return '"' + s.replace("\","\\").replace('"','\\\"').replace("\n","\\n") + '"'
def val(s:str)->str:
    if re.fullmatch(r"-?\d+",s): return s
    if re.fullmatch(r"-?(?:\d+\.\d*|\d*\.\d+)",s): return s
    if s.lower() in ("yes","true"): return "true"
    if s.lower() in ("no","false"): return "false"
    return q(s)
def emit(data,output,sources):
    lines=["-- GENERATED FILE. Do not edit.","-- Sources: "+", ".join(sources),"return {","  sections = {"]
    for section in sorted(data):
        lines.append("    ["+q(section)+"] = {")
        for k in sorted(data[section]): lines.append("      ["+q(k)+"] = "+val(data[section][k])+",")
        lines.append("    },")
    lines.append("  },\n  indexes = {")
    for section in TYPE_SECTIONS:
        if section not in data: continue
        lines.append("    ["+q(section)+"] = {")
        for k,v in sorted(data[section].items(), key=lambda x:int(x[0]) if x[0].isdigit() else 10**9):
            lines.append("      ["+q(k)+"] = "+q(v)+",")
        lines.append("    },")
    lines += ["  },","}",""]
    output.parent.mkdir(parents=True,exist_ok=True); output.write_text("\n".join(lines),encoding="utf-8")
def main():
    p=argparse.ArgumentParser(); p.add_argument("ini",nargs="+",type=Path); p.add_argument("--output",type=Path,default=Path(__file__).resolve().parents[1]/"gamedata"/"ra2_rules_generated.lua"); a=p.parse_args()
    merged={}
    for f in a.ini:
        for s,v in parse_ini(f.resolve()).items(): merged.setdefault(s,{}).update(v)
    emit(merged,a.output,[str(x) for x in a.ini]); print(f"Generated {a.output} ({len(merged)} sections)")
if __name__=="__main__": main()
