#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

required=(
  "src/third_party/eurorack/plaits/dsp/voice.h"
  "src/third_party/eurorack/plaits/dsp/voice.cc"
  "src/third_party/eurorack/plaits/dsp/engine/fm_engine.cc"
  "src/third_party/eurorack/stmlib/stmlib.h"
  "src/third_party/eurorack/stmlib/dsp/units.cc"
  "src/third_party/eurorack/stm_audio_bootloader/fsk/packet_decoder.cc"
)

for path in "${required[@]}"; do
  if [[ ! -f "${ROOT_DIR}/${path}" ]]; then
    echo "missing: ${path}" >&2
    exit 1
  fi
done

echo "PASS: plaits vendor layout"
