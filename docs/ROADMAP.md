# YOSHRUN — Production Roadmap
**Status:** Pre-production. Milestones are gated by working phone builds and playtests, not calendar promises.

## Platform rule
- [x] Mobile phones are the only planned platforms.
- [x] Android is the first development and test target.
- [ ] iOS follows after the mobile prototype and core controls are validated.
- [x] No PC/desktop release is planned.
- [ ] Validate compatibility across entry-level, mid-range and flagship phones; do not claim universal support before device testing.

## Phase 0 — Foundation
- [x] Create the YOSHRUN repository.
- [x] Establish initial game vision, modes, story, architecture and roadmap documents.
- [ ] Confirm engine version and available development hardware.
- [ ] Establish art direction references and asset licensing register.
- [ ] Define minimum Android and iOS device tiers through prototype tests.

**Exit criteria:** approved scope and a reproducible mobile development environment.

## Phase 1 — Core playable phone prototype
- [ ] Create the engine project and source-control settings.
- [ ] Implement a controllable third-person character.
- [ ] Add responsive camera and touch controls.
- [ ] Build a small greybox maze with clear landmarks.
- [ ] Implement one AI creature: patrol, investigate, chase and attack.
- [ ] Add one key, one locked gate and one escape trigger.
- [ ] Build and test on representative Android phones, including a lower-tier device.

**Exit criteria:** a player can enter the maze, navigate using touch, evade the creature, unlock a gate and escape in a repeatable Android build.

## Phase 2 — Core game feel
- [ ] Refine movement, animation, camera and interaction feedback.
- [ ] Add sound cues and creature telegraphs.
- [ ] Add basic equipment and resource pickup.
- [ ] Test maze readability and replayability with external players.
- [ ] Profile heat, battery, memory and sustained performance on phones.

## Phase 3 — Vertical slice
- [ ] Produce one polished representative area.
- [ ] Add one original creature with final-quality behavior and audio.
- [ ] Add character customization foundation.
- [ ] Implement a complete short story mission.
- [ ] Validate performance and memory across low-, mid- and high-tier Android devices.
- [ ] Validate iOS build pipeline and representative iPhone performance.

**Exit criteria:** a polished, representative mobile slice that demonstrates the intended quality and performance.

## Phase 4 — Multiplayer foundations
- [ ] Select backend and hosting approach.
- [ ] Implement server-authoritative sessions and player state.
- [ ] Test small matches, reconnects and latency handling.
- [ ] Implement moderation, reporting and basic anti-cheat protections.
- [ ] Run security and load tests.

## Phase 5 — MAZE CLASH
- [ ] Build the 5v5 asymmetric ruleset.
- [ ] Implement runner objectives and hunter tracking tools.
- [ ] Add round timers, side switching and match results.
- [ ] Tune maps and abilities through repeated playtests.

## Phase 6 — MAZE ROYALE
- [ ] Build the survival and extraction loop.
- [ ] Tune AI creature population and environmental events.
- [ ] Scale player count in stages through load testing.
- [ ] Treat 50 concurrent players as a target to validate, not an assumption.

## Phase 7 — Story expansion
- [ ] Complete Chapter I — THE MAZE.
- [ ] Build Chapter II — WORLD COLLAPSE.
- [ ] Build Chapter III — FINAL DESTINY.
- [ ] Add localization, accessibility and narrative QA.

## Phase 8 — Release readiness
- [ ] Phone compatibility matrix and performance certification.
- [ ] Privacy policy, terms, age rating and store compliance for Google Play and Apple App Store.
- [ ] Economy, payment and fraud review if monetization is enabled.
- [ ] Closed test, fixes, launch candidate and live-operations plan.

## Current next action
Create and validate the first Android phone prototype, then extend the tested mobile experience to iOS. These documents alone are not a playable game.
