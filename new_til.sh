#!/usr/bin/env bash
# 오늘 날짜로 새 TIL 노트를 만든다.
# 사용법: ./new_til.sh [주제]  (TIL/ 안에 파일을 만든다)   (주제는 영문 슬러그 권장, 비우면 날짜만 사용)
set -euo pipefail

cd "$(dirname "$0")/TIL"

TEMPLATE="_template.md"
README="README.md"
DATE="$(date +%F)"

TOPIC="${1:-}"
if [[ -z "$TOPIC" ]]; then
  read -r -p "주제 (영문 권장, 비우면 날짜만): " TOPIC
fi

# 앞뒤 공백 제거, 공백 → '-'
TOPIC="$(printf '%s' "$TOPIC" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
SLUG="${TOPIC// /-}"

if [[ -n "$SLUG" ]]; then
  FILE="${DATE}-${SLUG}.md"
  TITLE="$TOPIC"
else
  FILE="${DATE}.md"
  TITLE="주제"
fi

if [[ -e "$FILE" ]]; then
  echo "이미 있음: $FILE" >&2
  exit 1
fi
if [[ ! -f "$TEMPLATE" ]]; then
  echo "템플릿 없음: $TEMPLATE" >&2
  exit 1
fi

# 첫 줄만 바꾸고 나머지는 템플릿 그대로
{
  printf '# %s · %s\n' "$DATE" "$TITLE"
  tail -n +2 "$TEMPLATE"
} > "$FILE"

# README 표의 마지막 행 뒤에 한 줄 추가
if [[ -f "$README" ]]; then
  ROW="| ${DATE} | [${TITLE}](${FILE}) |  |"
  TMP="$(mktemp)"
  awk -v row="$ROW" '
    { lines[NR] = $0; if ($0 ~ /^\|/) last = NR }
    END {
      for (i = 1; i <= NR; i++) {
        print lines[i]
        if (i == last) print row
      }
    }
  ' "$README" > "$TMP"
  mv "$TMP" "$README"
fi

echo "생성: $(pwd)/$FILE"
