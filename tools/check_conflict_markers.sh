#!/usr/bin/env bash
set -euo pipefail

# 扫描仓库中的 Git 冲突标记，避免把冲突内容提交到远端。
# 只匹配“单独成行”的冲突标记，避免误报普通文档文本。
if rg -n "^<{7}|^={7}$|^>{7}" . -g '!tools/check_conflict_markers.sh'; then
  echo "[ERROR] 检测到冲突标记，请先清理后再提交。" >&2
  exit 1
fi

echo "[OK] 未检测到冲突标记。"
