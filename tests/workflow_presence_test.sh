#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WF="${ROOT_DIR}/.github/workflows/release.yml"

if [[ ! -f "$WF" ]]; then
  echo "missing workflow: .github/workflows/release.yml" >&2
  exit 1
fi

if ! grep -q "tags:" "$WF"; then
  echo "release workflow must trigger on tags" >&2
  exit 1
fi

if ! grep -q "freak-module.tar.gz" "$WF"; then
  echo "release workflow must publish freak-module.tar.gz" >&2
  exit 1
fi

echo "PASS: release workflow checks"
