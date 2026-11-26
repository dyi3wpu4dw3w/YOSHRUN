# YOSHRUN
### ESCAPE OR BE HUNTED
**A YOSHA original mobile multiplayer maze-survival game.**

YOSHRUN is a third-person / first-person 3D survival-action game set in a vast, shifting stone labyrinth surrounded by hostile wilderness. Players explore, scavenge, solve environmental objectives, evade intelligent creatures, and compete or cooperate to escape.

> **Project status:** Early implementation. A Godot 4 project foundation and a first procedural gameplay scene are now in the repository. The scene and scripts have not yet been validated in an actual Android build; this is not the completed game.

## Product vision
Build a distinctive phone-first survival experience with the ambition of premium multiplayer games, while keeping the core identity focused on the living maze, asymmetric pursuit, and meaningful escape objectives.

## Target platforms
- **Mobile phones only:** Android first, then iPhone (iOS).
- **No PC or desktop release is planned.**
- Landscape gameplay and touch-first controls.
- Broad compatibility across entry-level, mid-range and flagship devices is a goal; supported models and minimum OS versions require real-device testing.

## Core game modes
| Mode | Planned format | Core objective |
|---|---:|---|
| MAZE ROYALE | Up to 50 players (target) | Survive the maze, face AI creatures and rival players, and reach an extraction route. |
| MAZE CLASH | 5 Hunters vs 5 Runners | Runners find keys and escape; Hunters track, block and capture them. |
| WORLD COLLAPSE | Story / expedition | Explore the dangerous world beyond the maze. |
| FINAL DESTINY | Story finale | Uncover who built the maze and resolve the central mystery. |

Player-summoned creatures are a planned ability/economy feature. Players summon a creature companion; they do not transform into one. Competitive balance, counterplay and fair monetization are mandatory design constraints.

## Current project files
- `project.godot` — Godot 4 project configuration, landscape phone orientation and mobile-compatible renderer.
- `scenes/main.tscn` — cinematic mobile lobby entry scene.
- `scripts/lobby.gd` — runtime-built 3D lobby stage, original placeholder squad, mode selection and touch-friendly navigation.
- `scripts/game_world.gd` — procedural greybox maze, key/gate/exit objective and HUD.
- `scripts/player_controller.gd` — third-person character and basic touch movement/look.
- `scripts/maze_hunter.gd` — first-pass pursuing creature.
- `docs/` — design, story, architecture, device support and production roadmap.

## Technology
Godot 4 with the Compatibility renderer is the current implementation choice for a phone-first project. Android is the first build target; iOS follows after the core experience is validated. Rendering quality and minimum device requirements must be established through real phone tests.

## Development principles
1. Build and test on phones from the beginning.
2. Design scalable quality settings for low-, mid- and high-tier devices.
3. Keep multiplayer authoritative and server-validated.
4. Avoid pay-to-win purchases; paid or earned summons must have clear counters and balanced limits.
5. Build original characters, creatures, maps, names and story elements.

## Current lobby milestone
A first interactive lobby foundation is now in the project: a 3D portal stage, four original placeholder hero silhouettes, profile/currency bar, navigation panels, MAZE ROYALE / MAZE CLASH selectors and a Play action. The heroes are procedural placeholders, not final production character models; the lobby has not yet been runtime-validated on Android.

## Next engineering milestones
1. Validate the current project in Godot and produce an Android development build.
2. Complete player health, damage, creature attack, animations, audio and proper maze navigation.
3. Build the full single-player story and progression systems.
4. Implement online sessions, authoritative servers, matchmaking and the two multiplayer modes.
5. Add the full world, characters, creature roster, cosmetics, economy, accessibility, localization and release QA.

A complete commercial game requires substantial implementation, assets, online infrastructure and device testing. The repository status will be reported accurately as those pieces are delivered.
