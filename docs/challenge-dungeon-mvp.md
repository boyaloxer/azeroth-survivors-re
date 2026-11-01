# Challenge dungeon MVP (design sketch)

**Goal:** Keep survivors-style **auto abilities + gearing**, add **timed dungeon runs** (M+-like) starting with **one** classic dungeon.

## Reuse from `crates/benilla-app/src/survivors/`

| Piece | Existing module | Notes |
|-------|-----------------|-------|
| Auto combat | `auto.rs`, `abilities.rs` | Hero targeting / spell cadence |
| Progression | `cards.rs`, loot hooks | Level-up picks, stat scaling |
| Spawns | wave / enemy systems | Retune for room pulls instead of open BG |
| Map | battleground pick today | Swap to dungeon WMO/instance load |

## MVP scope (v0)

1. **Menu entry:** "Challenge" → pick **Deadmines** (or whichever instance loads reliably first).
2. **Run rules:** 30-minute timer (tunable), defeat final boss to win, wipe = fail.
3. **Scaling:** +HP/+damage per "key level" integer (no affixes yet).
4. **Telemetry:** on-screen timer, enemy count, key level.

## Out of scope until MVP plays

- Keystone loot tables, rating, group play
- All vanilla dungeons
- Affix rotation

## Suggested code layout (future)

```
crates/benilla-app/src/
  survivors/          # unchanged public API where possible
  challenge_dungeon/  # mode plugin: timer, win/loss, dungeon pick, spawn tables
```

Boot path: either extend `run_survivors` with a env flag (`WOW_SURVIVORS_MODE=challenge`) or a second binary crate mirroring `warcraft-survivors`.

## Playtest checklist

- [ ] `make native` boots survivors on current BG
- [ ] Instance load for chosen dungeon without portal bugs
- [ ] Timer UI visible; run ends on boss kill
- [ ] Key level affects trash HP within one order of magnitude
