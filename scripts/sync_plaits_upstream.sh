#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
WORK_DIR="${REPO_ROOT}/.upstream-eurorack"

if [[ ! -d "$WORK_DIR/.git" ]]; then
  git clone --depth 1 --filter=blob:none --sparse https://github.com/pichenettes/eurorack.git "$WORK_DIR"
fi

cd "$WORK_DIR"
git fetch --depth 1 origin master || git fetch --depth 1 origin main
if git show-ref --verify --quiet refs/remotes/origin/master; then
  git checkout -f master
  git reset --hard origin/master
else
  git checkout -f main
  git reset --hard origin/main
fi
git sparse-checkout set plaits
git submodule update --init --depth 1 stmlib stm_audio_bootloader

cd "$REPO_ROOT"
rm -rf src/third_party/eurorack/plaits
rm -rf src/third_party/eurorack/stmlib
rm -rf src/third_party/eurorack/stm_audio_bootloader
mkdir -p src/third_party/eurorack/stm_audio_bootloader

cp -R .upstream-eurorack/plaits src/third_party/eurorack/plaits
cp -R .upstream-eurorack/stmlib src/third_party/eurorack/stmlib
cp -R .upstream-eurorack/stm_audio_bootloader/fsk src/third_party/eurorack/stm_audio_bootloader/fsk

echo "Synced vendored Plaits sources from upstream."
