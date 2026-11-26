# YOSHRUN — Technical Architecture
**Status:** Proposal only; validate through prototypes before production.

## Engine direction
Unreal Engine 5 is the current candidate for a high-quality 3D game with animation, AI and multiplayer support. The exact engine release and mobile rendering path must be selected after a device-focused test project.

## Repository intent
This repository is the source-control home for design documents and, later, game source and project assets. GitHub is not the game engine and does not by itself build or run the game.

Proposed top-level layout:
```
YOSHRUN/
├── Config/                 # Unreal configuration (when project is generated)
├── Content/                # Unreal assets (use Git LFS for large binary assets)
├── Source/                 # C++ gameplay modules
├── docs/                   # Design and production documentation
├── Build/                  # Build scripts / CI definitions (later)
├── .gitignore
├── .gitattributes
└── README.md
```

## Prototype architecture
### Player
- Character movement and camera control.
- Input abstraction for touch and controller / keyboard testing.
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
- Navigation using Unreal navigation systems.
- Configurable movement, detection and attack values.
- Debug visualization for perception and state transitions.

### Multiplayer (later milestone)
- Server-authoritative match state, objectives, damage and inventory.
- Replicated player state and relevant actor state.
- Dedicated-server evaluation before large player counts.
- Matchmaking, parties, reconnect handling, telemetry, moderation and anti-cheat review.
- Start with a small player count; 50-player scale is a performance goal requiring load tests.

## Mobile performance
- Profile on representative Android and iOS devices from the first greybox.
- Use scalable quality settings, LODs, instancing, occlusion and efficient materials.
- Limit dynamic lights, shadow cost, particle overdraw and simultaneous AI.
- Set frame-rate and memory budgets only after testing real devices.
- Avoid assuming Nanite / Lumen desktop settings are appropriate for every target phone.

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
1. Install a compatible Unreal Engine version on a capable development machine.
2. Create a mobile test project and validate Android / iOS toolchains.
3. Implement one third-person character in a small greybox maze.
4. Add one AI creature with patrol and pursuit states.
5. Add one key, one gate and one exit.
6. Profile CPU, GPU, memory and frame pacing on target devices.
