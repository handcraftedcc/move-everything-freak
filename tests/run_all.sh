#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

echo "[1/5] vendor layout"
bash tests/plaits_vendor_layout_test.sh

echo "[2/5] modulation matrix"
g++ -std=c++14 -Isrc/dsp tests/plaits_mod_matrix_test.cpp -o /tmp/plaits_mod_matrix_test
/tmp/plaits_mod_matrix_test

echo "[3/5] plugin smoke"
bash tests/run_plaits_plugin_smoke.sh

echo "[4/5] engine voice behavior"
bash tests/run_plaits_engine_behavior.sh

echo "[5/5] module metadata"
python3 tests/module_metadata_test.py

echo "PASS: all checks"
