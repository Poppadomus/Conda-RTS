#!/usr/bin/env python3
"""Generate the invisible technical 3DO placeholder used by the procedural renderer."""
from pathlib import Path
import struct
ROOT=Path(__file__).resolve().parents[1]
out=ROOT/"objects3d"/"ra2_procedural.3do"
out.parent.mkdir(parents=True,exist_ok=True)
name=b"ra2_procedural\0"
name_off=52
verts_off=name_off+len(name)
prim_off=verts_off+48
idx_off=prim_off+32
buf=bytearray(idx_off+8)
struct.pack_into("<13i",buf,0,1,4,1,0,0,0,0,name_off,0,verts_off,prim_off,0,0)
buf[name_off:name_off+len(name)]=name
for i,(x,y,z) in enumerate(((-1,0,-1),(1,0,-1),(1,0,1),(-1,0,1))):
    struct.pack_into("<3i",buf,verts_off+i*12,x<<16,y<<16,z<<16)
struct.pack_into("<8i",buf,prim_off,0,4,0,idx_off,0,0,0,0)
struct.pack_into("<4H",buf,idx_off,0,1,2,3)
out.write_bytes(buf)
print(f"generated {out} ({len(buf)} bytes)")
