# Playtesting on Windows (fork workflow)

**Two binaries, same engine:**

| Command | What you get |
|---------|----------------|
| `.\scripts\dev-vanilla.ps1` | **Normal 1.12.1 client** (login, Realmlist, stock UI) — use this as your edit base. |
| `.\scripts\dev-native.ps1` | **Azeroth Survivors** roguelike (custom menu, auto combat, offline BG) — reference only unless you are hacking survivors. |

See [VANILLA-BASE.md](./VANILLA-BASE.md) for benilla vs Wrath forks and upstream links.

The commercial **Azeroth Survivors** install under `C:\Games\AzerothSurvivors\` uses different patch MPQs only — you still need a full **WoW 1.12.1 (5875)** `Data` folder with at least `terrain.MPQ` and `patch.MPQ`.

## One-time setup

1. **Rust:** [rustup](https://rustup.rs/) (or `winget install Rustlang.Rustup`), then restart the shell so `cargo` is on PATH.
2. **Git Bash:** run all `make` targets from Git Bash, not PowerShell ([README](../README.md)).
3. **Game data:** from Git Bash at repo root:
   ```bash
   ./scripts/fetch-data.sh
   ```
   Data lands in `wow-data/Data/`. Override location with `WOW_DATA_DIR=/path/to/parent`.

   If the download finished but extraction failed (`unzip: command not found`), run in PowerShell:
   ```powershell
   .\scripts\extract-wow-data.ps1
   ```
   Optional: delete `wow-data/1.12.1-5875_enUS.zip` afterward to free ~5 GB.

## Daily loop (native desktop — fastest for iteration)

PowerShell at repo root:

```powershell
.\scripts\dev-native.ps1
```

Or Git Bash:

```bash
make native
```

Browser build (slower first time — wasm toolchain):

```bash
make build && make start
# http://127.0.0.1:8090/
```

## Fork remotes

- **upstream:** `OutThisLife/azeroth-survivors-re`
- **your fork:** push feature branches here, open PRs upstream when ready.

```bash
git remote add upstream https://github.com/OutThisLife/azeroth-survivors-re.git   # if missing
git remote set-url origin https://github.com/boyaloxer/azeroth-survivors-re.git
git fetch upstream
```

## Challenge dungeon mode (planned)

See [challenge-dungeon-mvp.md](./challenge-dungeon-mvp.md). MVP goal: one vanilla dungeon interior, timer + scaling, reuse survivors auto-combat and gear — before affixes or a full dungeon roster.
