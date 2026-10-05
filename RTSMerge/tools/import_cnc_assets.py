#!/usr/bin/env python3
"""Validate and stage a legally owned Red Alert 2 / Yuri's Revenge install.

The importer never commits proprietary game data. It only copies source files
into the ignored assets/imported directory for a local conversion workflow.
"""
from __future__ import annotations

import argparse
import shutil
from pathlib import Path

RA2_REQUIRED = ("ra2.mix", "language.mix")
YR_REQUIRED = ("gamemd.exe", "ra2md.mix", "langmd.mix")
EXTENSIONS = {".mix", ".shp", ".pal", ".tmp", ".vxl", ".hva", ".csf", ".aud", ".wav", ".vqa", ".bik", ".ini"}

def find_case_insensitive(root: Path, name: str) -> Path | None:
    target = name.lower()
    for p in root.rglob("*"):
        if p.is_file() and p.name.lower() == target:
            return p
    return None

def validate(root: Path) -> list[str]:
    missing = [name for name in RA2_REQUIRED if find_case_insensitive(root, name) is None]
    return missing

def stage(root: Path, out: Path) -> int:
    missing = validate(root)
    if missing:
        print("Missing RA2 baseline files:", ", ".join(missing))
        return 2

    out.mkdir(parents=True, exist_ok=True)
    copied = 0
    for src in root.rglob("*"):
        if not src.is_file():
            continue
        if src.suffix.lower() not in EXTENSIONS and src.name.lower() not in YR_REQUIRED:
            continue
        rel = src.relative_to(root)
        dst = out / rel
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dst)
        copied += 1

    print(f"Staged {copied} RA2/YR resource files under {out}")
    print("INI rule data is staged alongside art/audio resources for conversion.")
    print("Proprietary source data remains ignored and local.")
    return 0

def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("install", type=Path, help="RA2/YR installation directory")
    parser.add_argument("--out", type=Path, default=Path(__file__).resolve().parents[1] / "assets" / "imported")
    args = parser.parse_args()
    return stage(args.install.resolve(), args.out.resolve())

if __name__ == "__main__":
    raise SystemExit(main())
