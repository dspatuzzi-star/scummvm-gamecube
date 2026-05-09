#!/usr/bin/env bash
set -euo pipefail

IMAGE="devkitpro/devkitppc:2021-08-06"
WORKSPACE="${1:-$PWD}"
LOGFILE="${2:-gamecube-build.log}"

mkdir -p "$(dirname "$LOGFILE")" 2>/dev/null || true
: > "$LOGFILE"

docker pull "$IMAGE" 2>&1 | tee -a "$LOGFILE"

docker run --rm \
  -v "$WORKSPACE:/workspace" \
  -w /workspace \
  "$IMAGE" \
  /bin/bash /workspace/ci/gamecube-build.sh 2>&1 | tee -a "$LOGFILE"

ls -lah | tee -a "$LOGFILE"
pwd | tee -a "$LOGFILE"
cat "$LOGFILE" >/dev/null || true
