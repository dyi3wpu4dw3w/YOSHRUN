# YOSHRUN — Technical Architecture
**Status:** Proposal only; validate through prototypes before production.

## Platform commitment
YOSHRUN is a **mobile-only game**. The planned release platforms are Android phones and iPhones (iOS). There is no PC/desktop release target. All gameplay UX, input, graphics budgets and testing priorities must be designed around phones.

## Engine direction
Unreal Engine 5 is the current candidate for a high-quality 3D game with animation, AI and multiplayer support. The exact engine release and mobile rendering path must be selected after a device-focused test project. Do not assume high-end desktop rendering features are suitable for phones.

## Phone compatibility strategy
The goal is broad compatibility, not an unverified promise that every phone can run the game.
- **Entry-level tier:** reduced resolution/render scale, simpler shadows, lower effects density, conservative texture and memory budgets, reduced view distance and carefully limited active AI.
- **Mid-range tier:** balanced resolution, effects, shadows and draw distance.
- **Flagship tier:** higher-quality materials, effects, shadows and resolution where thermals and frame pacing permit.
- Provide scalable graphics settings and automatic recommended defaults.
- Test real Android phones across GPU/RAM/OS ranges and real iPhone generations before publishing minimum requirements.
- Track sustained performance, heat, battery use, loading time, memory pressure and crashes—not just a short benchmark.
- Keep touch controls responsive across screen sizes, aspect ratios, refresh rates and safe areas.
- Exact minimum Android/iOS versions and supported device list remain **TBD until prototype testing**.

## Repository intent
This repository is the source-control home for design documents and, later, game source and project assets. GitHub is not the game engine and does not by itself build or run the game.

Proposed top-level layout:
```
YOSHRUN/
├── Config/                 # Engine configuration (when project is generated)
├── Content/                # Game assets (use Git LFS for large binary assets)
├── Source/                 # Gameplay source modules
├── docs/                   # Design and production documentation
├── Build/                  # Build scripts / CI definitions (later)
├── .gitignore
├── .gitattributes
└── README.md
```

## Prototype architecture
### Player
- Third-person camera by default, with first-person option if performance and design tests support it.
- Touch-first movement, camera look, interaction and action controls.
- Input abstraction for touch and optional controller testing.
- Contextual interaction interface.
- Health and basic damage handling.

### Maze
- Modular greybox pieces.
- Gate actor with explicit states: Locked, Unlocked, Opening, Open, Closing.
- Key / objective actor.
- Escape trigger and round completion event.
- Route changes must be server-authoritative in online modes and telegraphed to players.

### Creature AI
- Perception: sight and hearing.
- State machine: Patrol → Investigate → Chase → Attack → Search → Return.
- Navigation using the engine navigation systems.
- Configurable movement, detection and attack values.
- Debug visualization for perception and state transitions.

### Multiplayer (later milestone)
- Server-authoritative match state, objectives, damage and inventory.
- Replicated player state and relevant actor state.
- Dedicated-server evaluation before large player counts.
- Matchmaking, parties, reconnect handling, telemetry, moderation and anti-cheat review.
- Start with a small player count; 50-player scale is a performance goal requiring load tests.

## Mobile performance
- Profile on representative low-, mid- and high-tier Android phones and iPhones from the first greybox.
- Use scalable quality settings, LODs, instancing, occlusion and efficient materials.
- Limit dynamic lights, shadow cost, particle overdraw and simultaneous AI.
- Establish per-tier frame-rate, memory, thermal and battery budgets using real devices.
- Prefer predictable frame pacing and stable play over visual effects that cause overheating or crashes.

## Backend options
No backend provider is selected. Evaluate services for authentication, matchmaking, player data, telemetry and dedicated game servers based on pricing, regional latency, platform support, data protection and operational requirements.

## Asset and source control
- Use Git LFS for large binary assets such as textures, audio and source art.
- Do not commit generated build folders, caches, local settings, secrets or signing keys.
- Keep credentials in secure CI secrets or platform secret stores; never in the repository.
- Track third-party assets and licenses in an asset register before shipping.

## Security and live operations
- Validate all competitive outcomes on the server.
- Never trust client-reported currency, inventory, damage or match results.
- Plan abuse reporting, chat moderation, privacy controls and account recovery before public multiplayer launch.

## Immediate technical spike
1. Install a compatible engine version and mobile build toolchains.
2. Create a phone test project and validate Android builds first, then iOS builds.
3. Implement one touch-controlled third-person character in a small greybox maze.
4. Add one AI creature with patrol and pursuit states.
5. Add one key, one gate and one exit.
6. Profile CPU, GPU, memory, heat, battery and frame pacing on representative phones from all three device tiers.
