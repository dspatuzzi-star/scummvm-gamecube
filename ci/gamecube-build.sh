#!/usr/bin/env bash
set -euo pipefail

export DEVKITPRO=/opt/devkitpro
export DEVKITPPC=/opt/devkitpro/devkitPPC
export PATH="$DEVKITPPC/bin:$DEVKITPRO/tools/bin:$PATH"

./configure \
  --host=gamecube \
  --disable-all-engines \
  --enable-engine=scumm \
  --enable-engine=gob \
  --enable-engine=groovie \
  --enable-engine=sci \
  --enable-engine=agi \
  --enable-engine=saga \
  --enable-engine=sky \
  --enable-engine=tinsel \
  --enable-engine=sword1 \
  --enable-engine=sword2 \
  --enable-static \
  --disable-debug \
  --enable-release

make -j2
make wiidist

test -f wiidist/scummvm/scummvm.dol
