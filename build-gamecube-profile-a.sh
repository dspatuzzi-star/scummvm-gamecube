#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${DEVKITPRO:-}" ]]; then
  echo "ERROR: DEVKITPRO is not set. Example: export DEVKITPRO=/path/to/devkitpro" >&2
  exit 1
fi

if [[ -z "${DEVKITPPC:-}" ]]; then
  echo "ERROR: DEVKITPPC is not set. Example: export DEVKITPPC=\$DEVKITPRO/devkitPPC" >&2
  exit 1
fi

./configure \
  --host=gamecube \
  --disable-all-engines \
  --enable-engine=scumm,gob,groovie,sci,agi,saga,sky,tinsel,sword1,sword2 \
  --enable-static \
  --disable-debug \
  --enable-release \
  --disable-mt32emu \
  --disable-eventrecorder \
  --disable-updates \
  --disable-text-console

make -j"$(nproc)"
make wiidist

echo "Expected GameCube .dol: wiidist/scummvm/scummvm.dol"
