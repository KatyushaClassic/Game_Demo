#!/usr/bin/env bash
set -euo pipefail

# 优先使用 godot 命令，其次尝试 godot4
if command -v godot >/dev/null 2>&1; then
  GODOT_BIN="godot"
elif command -v godot4 >/dev/null 2>&1; then
  GODOT_BIN="godot4"
else
  echo "[ERROR] godot/godot4 均未找到，请先安装 Godot 4 并加入 PATH。" >&2
  exit 127
fi

# 输出当前使用的 Godot 可执行文件和版本
echo "[INFO] using: $GODOT_BIN"
"$GODOT_BIN" --version

# 用 headless 模式打开项目，确认项目配置至少能被引擎识别
echo "[INFO] import/check project..."
"$GODOT_BIN" --headless --path . --quit
echo "[OK] project recognized by Godot."
