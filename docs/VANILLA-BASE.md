# Which codebase to use

**Primary modding repo:** [github.com/boyaloxer/benilla](https://github.com/boyaloxer/benilla) — upstream benilla only (no survivors). See `docs/MODDING-START.md` there.

## Recommendation: **benilla** (1.12.1) for a normal client

The strangeness at startup is **Azeroth Survivors mode** (`warcraft-survivors` → `run_survivors()`): custom pick screen, auto-combat, no login. That is not what a stock WoW session looks like.

For **normal vanilla** — login, character select, stock FrameXML, connecting to a 1.12.1 server — use the **`benilla`** binary in this same workspace:

```powershell
.\scripts\dev-vanilla.ps1
```

That runs `benilla_app::run()`, the full client described upstream at [samwhosung/benilla](https://github.com/samwhosung/benilla).

| Project | Version | Completeness (open client) | Notes |
|--------|---------|----------------------------|--------|
| **[benilla](https://github.com/samwhosung/benilla)** | 1.12.1 (5875) | **Highest** — playable end-to-end: UI, addons, BGs, AH, raids, etc. | Needs your MPQs + a **vmangos** / cMaNGOS-style server (Warden off). RE docs: [benilla-re](https://github.com/samwhosung/benilla-re). |
| **This repo (OutThisLife fork)** | Same engine + survivors | Full benilla **plus** `crates/benilla-app/src/survivors/` for AS-like mode | Use `-p benilla` for vanilla; `-p warcraft-survivors` only when borrowing/testing roguelike code. |
| **[benilla-wotlk](https://github.com/Onixaz/benilla-wotlk)** | 3.3.5a (12340) | **In progress** — auth/world/UI work; README warns some layers still 1.12-shaped | AzerothCore + WotLK `Data`. |
| **WowRust / idewave-cli / tentacli** | 3.3.5a | Partial (CLI/bots or private) | Not a full replacement client for your goal. |
| **SatyPardus wowdecomp** | — | Discontinued (C&D) | Do not treat as a primary base. |

**Wrath vs vanilla:** Nothing open matches benilla’s 1.12 completeness through Wrath yet. If you care about **M+ dungeons and WotLK content**, benilla-wotlk is the long-term bet but expect rough edges today. If you care about **faithful vanilla + custom modes**, stay on **1.12.1 benilla** and port ideas from survivors code as reference.

## Borrowing Azeroth Survivors features

Do not run the commercial AS exe as your edit base. Treat these as **reference only**:

- **Roguelike / auto-combat / cards:** `crates/benilla-app/src/survivors/` (this repo or upstream benilla if merged).
- **Commercial AS:** closed source; behavior only via [wow.aethus.pl](https://wow.aethus.pl/) or this community build.

Implement challenge dungeons or gearing as **new plugins** on `run()` / world load, not by defaulting to `run_survivors()`.

## Server for vanilla playtest

benilla does not ship a server. Local dev typically uses **[vmangos](https://github.com/vmangos/core)** (vanilla 1.12). Set the client Realmlist to `127.0.0.1` (or your LAN IP) after the realm is running.

## Tracking upstream

For day-to-day vanilla client work, you can clone **[samwhosung/benilla](https://github.com/samwhosung/benilla)** directly and treat this fork as a **side branch** that keeps survivors + your docs. Merge or cherry-pick from upstream benilla regularly; keep `upstream` remote on OutThisLife only if you still want their survivors packaging.
