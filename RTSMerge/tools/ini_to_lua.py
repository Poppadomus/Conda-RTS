#!/usr/bin/env python3
"""Convert RA2/YR INI rule data into deterministic Spring Lua tables.

This is a data bridge: values remain sourced from the player's owned install,
while the Spring game consumes a native Lua representation.
"""
from __future__ import annotations

import argparse
import re
from pathlib import Path

def parse_ini(path: Path) -> dict[str, dict[str, str]]:
    sections: dict[str, dict[str, str]] = {}
    current: dict[str, str] | None = None
    for raw in path.read_text(encoding="latin-1", errors="replace").splitlines():
        line = raw.strip()
        if not line or line.startswith(";") or line.startswith("#"):
            continue
        m = re.fullmatch(r"\[([^]]+)\]", line)
        if m:
            current = sections.setdefault(m.group(1), {})
            continue
        if current is None or "=" not in line:
            continue
        key, value = line.split("=", 1)
        current[key.strip()] = value.strip()
    return sections

def lua_string(value: str) -> str:
    return '"' + value.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n") + '"'

def lua_value(value: str) -> str:
    if re.fullmatch(r"-?\d+", value):
        return value
    if re.fullmatch(r"-?(?:\d+\.\d*|\d*\.\d+)", value):
        return value
    if value.lower() == "yes":
        return "true"
    if value.lower() == "no":
        return "false"
    return lua_string(value)

def emit(data: dict[str, dict[str, str]], output: Path, source: str) -> None:
    lines = [
        "-- GENERATED FILE. Do not edit.",
        "-- Source: " + source,
        "return {",
    ]
    for section in sorted(data):
        lines.append("  [" + lua_string(section) + "] = {")
        for key in sorted(data[section]):
            lines.append("    [" + lua_string(key) + "] = " + lua_value(data[section][key]) + ",")
        lines.append("  },")
    lines.append("}")
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text("\n".join(lines) + "\n", encoding="utf-8")

def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("ini", type=Path, nargs="+")
    p.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "gamedata" / "ra2_rules_generated.lua")
    a = p.parse_args()
    merged: dict[str, dict[str, str]] = {}
    for path in a.ini:
        for section, values in parse_ini(path.resolve()).items():
            merged.setdefault(section, {}).update(values)
    emit(merged, a.output, ", ".join(str(p) for p in a.ini))
    print(f"Generated {a.output} from {len(a.ini)} INI file(s) and {len(merged)} sections")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
