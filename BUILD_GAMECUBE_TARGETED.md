# GameCube Targeted ScummVM Build Profiles

This guide provides two **targeted** Nintendo GameCube build profiles for ScummVM.

Both profiles are intentionally limited:
- **No plugins** (no dynamic engines)
- **Static linking only**
- **Only profile-specific engines enabled**
- **No full generic ScummVM build**

---

## Prerequisites

Set up your devkitPro environment before building:

```bash
export DEVKITPRO=/path/to/devkitpro
export DEVKITPPC=$DEVKITPRO/devkitPPC
```

Both variables are required for GameCube cross-compilation and tooling.

---

## Profile A — Stable legacy adventure build

### Engines

```text
scumm,gob,groovie,sci,agi,saga,sky,tinsel,sword1,sword2
```

### Configure command

```bash
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
```

### Build commands

```bash
make -j"$(nproc)"
make wiidist
```

### Expected `.dol` output path

```text
wiidist/scummvm/scummvm.dol
```

### Suggested test order

1. Monkey Island 1 (SCUMM)
2. Monkey Island 2 (SCUMM)
3. The 7th Guest (Groovie)
4. Beneath a Steel Sky (Sky)
5. Broken Sword 1 (Sword1)
6. Broken Sword 2 (Sword2)
7. Woodruff (Gob)
8. I Have No Mouth and I Must Scream (Saga)
9. Discworld 1 (Tinsel)
10. Gabriel Knight 1 (SCI)

### Expected compatibility (Profile A)

| Game group | Engine | Expectation on GameCube |
|---|---|---|
| Monkey Island 1/2/3 | scumm | Realistic |
| Woodruff | gob | Likely |
| The 7th Guest | groovie | Likely |
| IHNMAIMS | saga | Likely |
| Beneath a Steel Sky | sky | Realistic |
| Broken Sword 1/2 | sword1/sword2 | Realistic |
| Discworld 1/2 | tinsel | Likely |
| Larry / Police Quest / GK1 | sci | Mixed, generally feasible |
| GK2 / Phantasmagoria 1/2 | sci (SCI32/FM V heavy) | Experimental |

### GameCube-specific risks

- Limited RAM can cause instability with SCI32 and FMV-heavy titles.
- Storage speed/fragmentation on SD media can affect streaming-heavy games.
- Larger save states and heavy scene transitions may expose memory pressure.

---

## Profile B — Experimental FMV/heavy build

### Engines

```text
sci,mohawk,pegasus,titanic,groovie
```

### Configure command

```bash
./configure \
  --host=gamecube \
  --disable-all-engines \
  --enable-engine=sci,mohawk,pegasus,titanic,groovie \
  --enable-static \
  --disable-debug \
  --enable-release \
  --disable-mt32emu \
  --disable-eventrecorder \
  --disable-updates \
  --disable-text-console
```

### Build commands

```bash
make -j"$(nproc)"
make wiidist
```

### Expected `.dol` output path

```text
wiidist/scummvm/scummvm.dol
```

### Suggested test order

1. The 7th Guest (Groovie baseline)
2. Myst (Mohawk)
3. Journeyman Project (Pegasus)
4. Titanic: Adventure Out of Time (Titanic)
5. Gabriel Knight 2 (SCI32)
6. Phantasmagoria 1 (SCI32)
7. Phantasmagoria 2 (SCI32)

### Expected compatibility (Profile B)

| Game group | Engine | Expectation on GameCube |
|---|---|---|
| The 7th Guest | groovie | Likely baseline |
| Myst | mohawk | Experimental |
| Journeyman Project | pegasus | Experimental |
| Titanic: Adventure Out of Time | titanic | Experimental |
| GK2 / Phantasmagoria 1/2 | sci (SCI32/FM V heavy) | High-risk experimental |

### GameCube-specific risks

- FMV decode + audio + IO may exceed practical performance limits.
- Higher memory footprint increases crash/lockup risk.
- Gameplay may be possible in parts but unstable across long sessions.

---

## Notes

- If detection works but launching fails, verify the exact profile build is installed.
- Keep your SD card FAT32 healthy (avoid extreme fragmentation).
- Start with Profile A for best chance of stable daily use.
