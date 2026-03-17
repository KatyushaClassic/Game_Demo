#!/usr/bin/env bash
set -euo pipefail

python - <<'PY'
from pathlib import Path

root = Path('.')
ignore = {Path('tools/check_conflict_markers.sh'), Path('.git')}

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
        continue

    for i, line in enumerate(text.splitlines(), start=1):
        if line.startswith(left) or line == mid or line.startswith(right):
            print(f"{rel}:{i}:{line}")
            hit = True

if hit:
    raise SystemExit(1)
print('[OK] 未检测到冲突标记。')
PY
