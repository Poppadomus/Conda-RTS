#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$ROOT/demo_startscript.txt"

ENGINE="${RECOIL_ENGINE:-}"
if [[ -z "$ENGINE" ]]; then
  if command -v recoil >/dev/null 2>&1; then ENGINE="$(command -v recoil)"
  elif command -v spring >/dev/null 2>&1; then ENGINE="$(command -v spring)"
  elif [[ -x "$ROOT/recoil" ]]; then ENGINE="$ROOT/recoil"
  elif [[ -x "$ROOT/spring" ]]; then ENGINE="$ROOT/spring"
  else
    echo "Recoil/Spring executable not found."
    echo "Install Recoil, put its executable in PATH, or set RECOIL_ENGINE=/path/to/recoil."
    exit 1
  fi
fi

exec "$ENGINE" "$SCRIPT"
