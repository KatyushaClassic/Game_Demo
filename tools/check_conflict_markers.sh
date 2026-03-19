#!/usr/bin/env bash
set -euo pipefail

# 使用 Python 扫描仓库文本文件，查找未处理的 Git 冲突标记
python - <<'PY'
from pathlib import Path

# 以仓库根目录为扫描起点
root = Path('.')
# 忽略当前脚本自身与 .git 目录
ignore = {Path('tools/check_conflict_markers.sh'), Path('.git')}

# 动态构造冲突标记，避免脚本文本本身被误判
left = chr(60) * 7
mid = chr(61) * 7
right = chr(62) * 7

hit = False
for p in root.rglob('*'):
    if not p.is_file():
        continue
    rel = p.relative_to(root)
    if rel.parts and rel.parts[0] == '.git':
        continue
    if rel in ignore:
        continue
    try:
        text = p.read_text(encoding='utf-8')
    except Exception:
        # 二进制文件或无法解码的文件直接跳过
        continue

    for i, line in enumerate(text.splitlines(), start=1):
        # 单独成行的冲突标记才视为命中
        if line.startswith(left) or line == mid or line.startswith(right):
            print(f"{rel}:{i}:{line}")
            hit = True

if hit:
    raise SystemExit(1)
print('[OK] 未检测到冲突标记。')
PY
