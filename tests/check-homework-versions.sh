#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

compile_version() {
  local version="$1"
  local pdf="$TMPDIR/homework-$version.pdf"
  local text="$TMPDIR/homework-$version.txt"

  typst compile --root "$ROOT" --input "version=$version" "$ROOT/tests/homework-versions.typ" "$pdf"
  pdftotext "$pdf" "$text"
}

compile_version questions
compile_version answers
compile_version solutions

QUESTIONS="$TMPDIR/homework-questions.txt"
ANSWERS="$TMPDIR/homework-answers.txt"
SOLUTIONS="$TMPDIR/homework-solutions.txt"

grep -q "BOTH-QUESTION-CONTENT" "$QUESTIONS"
grep -q "FALLBACK-QUESTION-CONTENT" "$QUESTIONS"
grep -q "QUESTION-ONLY-CONTENT" "$QUESTIONS"
grep -q "Due: June 16, 2026" "$QUESTIONS"
! grep -q "BOTH-ANSWER-CONTENT" "$QUESTIONS"
! grep -q "BOTH-SOLUTION-CONTENT" "$QUESTIONS"
! grep -q "FALLBACK-SOLUTION-CONTENT" "$QUESTIONS"

grep -q "BOTH-QUESTION-CONTENT" "$ANSWERS"
grep -q "BOTH-ANSWER-CONTENT" "$ANSWERS"
grep -q "FALLBACK-SOLUTION-CONTENT" "$ANSWERS"
grep -q "QUESTION-ONLY-CONTENT" "$ANSWERS"
grep -q "Due: June 16, 2026" "$ANSWERS"
! grep -q "BOTH-SOLUTION-CONTENT" "$ANSWERS"

grep -q "BOTH-QUESTION-CONTENT" "$SOLUTIONS"
grep -q "BOTH-SOLUTION-CONTENT" "$SOLUTIONS"
grep -q "FALLBACK-SOLUTION-CONTENT" "$SOLUTIONS"
grep -q "QUESTION-ONLY-CONTENT" "$SOLUTIONS"
grep -q "Due: June 16, 2026" "$SOLUTIONS"
! grep -q "BOTH-ANSWER-CONTENT" "$SOLUTIONS"
