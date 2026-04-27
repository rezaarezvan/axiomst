#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

PDF="$TMPDIR/counter-overlays.pdf"
TEXT="$TMPDIR/counter-overlays.txt"
LOG="$TMPDIR/counter-overlays.log"

typst compile --root "$ROOT" "$ROOT/tests/counter-overlays.typ" "$PDF" 2>"$LOG"

pdftotext "$PDF" "$TEXT"

grep -q "Definition 1 First" "$TEXT"
grep -q "Definition 2 Second" "$TEXT"
grep -q "Definition 3 Optimal" "$TEXT"
! grep -q "Definition 2 Optimal" "$TEXT"

test "$(grep -c "Figure 1: Alpha" "$TEXT")" -eq 3
test "$(grep -c "Figure 2: Beta" "$TEXT")" -eq 2

test "$(grep -c "(1)" "$TEXT")" -eq 3
test "$(grep -c "(2)" "$TEXT")" -eq 2
