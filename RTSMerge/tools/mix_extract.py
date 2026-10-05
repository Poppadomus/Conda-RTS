#!/usr/bin/env python3
"""Parse and extract unencrypted Westwood MIX archives.

The extractor deliberately preserves numeric entry IDs because MIX indexes store
hashes rather than original filenames. It never guesses filenames or modifies
the source installation.
"""
from __future__ import annotations

import argparse
import struct
from pathlib import Path

def read_index(path: Path):
    data = path.read_bytes()
    if len(data) < 6:
        raise ValueError("not a MIX archive")
    count, data_size = struct.unpack_from("<HI", data, 0)
    pos = 6
    # Classic unencrypted MIX: count + data-size followed by 12-byte entries.
    # Encrypted/extended archives are intentionally rejected rather than
    # silently producing corrupt output.
    if count == 0 or pos + count * 12 > len(data):
        raise ValueError("unsupported or corrupt MIX header")
    entries = []
    for _ in range(count):
        file_id, offset, size = struct.unpack_from("<III", data, pos)
        pos += 12
        entries.append((file_id, offset, size))
    payload_base = pos
    if payload_base + data_size > len(data):
        raise ValueError("MIX payload extends beyond file")
    return data, payload_base, entries

def extract(path: Path, out: Path) -> int:
    data, base, entries = read_index(path)
    out.mkdir(parents=True, exist_ok=True)
    for file_id, offset, size in entries:
        start = base + offset
        end = start + size
        if end > len(data):
            raise ValueError(f"entry {file_id:08x} is outside archive")
        (out / f"{file_id:08x}.bin").write_bytes(data[start:end])
    print(f"Extracted {len(entries)} entries from {path.name} to {out}")
    return len(entries)

def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("mix", type=Path)
    p.add_argument("--out", type=Path)
    a = p.parse_args()
    out = a.out or a.mix.with_suffix("")
    extract(a.mix.resolve(), out.resolve())
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
