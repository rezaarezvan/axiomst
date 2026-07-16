#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

compile_version() {
  local version="$1"
  local pdf="$TMPDIR/homework-labels-$version.pdf"
  local text="$TMPDIR/homework-labels-$version.txt"

  typst compile --root "$ROOT" --input "version=$version" "$ROOT/tests/homework-labels.typ" "$pdf"
  pdftotext "$pdf" "$text"
}

compile_version questions
compile_version answers
compile_version solutions

QUESTIONS="$TMPDIR/homework-labels-questions.txt"
ANSWERS="$TMPDIR/homework-labels-answers.txt"
SOLUTIONS="$TMPDIR/homework-labels-solutions.txt"

grep -q "Global Exercise 1: Inherited Labels" "$QUESTIONS"
grep -q "Local Task 3: Local Labels" "$QUESTIONS"
grep -q "Global Exercise 4: Referenced Heading" "$QUESTIONS"
grep -q "REFERENCE-TEXT: Global Exercise 4" "$QUESTIONS"
! grep -q "GLOBAL-ANSWER-CONTENT" "$QUESTIONS"
! grep -q "GLOBAL-SOLUTION-CONTENT" "$QUESTIONS"
! grep -q "LOCAL-FALLBACK-CONTENT" "$QUESTIONS"

test "$(grep -c "Global answer!" "$ANSWERS")" -eq 2
grep -q "Local response!" "$ANSWERS"
grep -q "GLOBAL-ANSWER-CONTENT" "$ANSWERS"
grep -q "GLOBAL-FALLBACK-CONTENT" "$ANSWERS"
grep -q "LOCAL-FALLBACK-CONTENT" "$ANSWERS"
! grep -q "Global answer!:" "$ANSWERS"

test "$(grep -c "Global solution?" "$SOLUTIONS")" -eq 2
grep -q "Local solution?" "$SOLUTIONS"
grep -q "GLOBAL-SOLUTION-CONTENT" "$SOLUTIONS"
grep -q "GLOBAL-FALLBACK-CONTENT" "$SOLUTIONS"
grep -q "LOCAL-FALLBACK-CONTENT" "$SOLUTIONS"
! grep -q "Local solution?:" "$SOLUTIONS"

SUPPLEMENTS="$(typst query --root "$ROOT" "$ROOT/tests/homework-labels.typ" heading --field supplement)"
grep -q 'Local Task' <<<"$SUPPLEMENTS"
grep -q 'Global Exercise' <<<"$SUPPLEMENTS"
