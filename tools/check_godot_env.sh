#!/usr/bin/env bash
set -euo pipefail

if command -v godot >/dev/null 2>&1; then
  GODOT_BIN="godot"
elif command -v godot4 >/dev/null 2>&1; then
  GODOT_BIN="godot4"
else
  echo "[ERROR] godot/godot4 均未找到，请先安装 Godot 4 并加入 PATH。" >&2
  exit 127
fi

echo "[INFO] using: $GODOT_BIN"
"$GODOT_BIN" --version

echo "[INFO] import/check project..."
"$GODOT_BIN" --headless --path . --quit
echo "[OK] project recognized by Godot."
