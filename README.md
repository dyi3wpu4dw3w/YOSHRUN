# YOSHRUN
### ESCAPE OR BE HUNTED
**A YOSHA original multiplayer maze-survival game.**

YOSHRUN is a third-person / first-person 3D survival-action game set in a vast, shifting stone labyrinth surrounded by hostile wilderness. Players explore, scavenge, solve environmental objectives, evade intelligent creatures, and compete or cooperate to escape.

> **Project status:** Pre-production. This repository currently contains the game's design foundation and technical planning. It is not yet a playable Unreal Engine project.

## Product vision
Build a distinctive mobile-first survival experience with the ambition of premium multiplayer games, while keeping the core identity focused on the living maze, asymmetric pursuit, and meaningful escape objectives.

## Target platforms
- Android
- iOS

## Planned play options
- Online multiplayer
- Offline solo / story experiences where supported by the final design

## Core game modes
| Mode | Planned format | Core objective |
|---|---:|---|
| MAZE ROYALE | Up to 50 players (target) | Survive the maze, face AI creatures and rival players, and reach an extraction route. |
| MAZE CLASH | 5 Hunters vs 5 Runners | Runners find keys and escape; Hunters track, block and capture them. |
| WORLD COLLAPSE | Story / expedition | Explore the dangerous world beyond the maze. |
| FINAL DESTINY | Story finale | Uncover who built the maze and resolve the central mystery. |

Player-summoned creatures are a planned ability/economy feature. Players summon a creature companion; they do not transform into one. Competitive balance, counterplay and fair monetization are mandatory design constraints.

## Repository map
- `docs/GAME_DESIGN_DOCUMENT.md` — high-level game vision and pillars
- `docs/GAME_MODES.md` — mode rules and match flow
- `docs/STORY_AND_WORLDBUILDING.md` — original setting, narrative and chapters
- `docs/TECHNICAL_ARCHITECTURE.md` — proposed systems and technology direction
- `docs/ROADMAP.md` — staged production plan and milestones
- `Config/.gitkeep`, `Source/.gitkeep`, `Content/.gitkeep` — reserved Unreal project layout; no engine project has been generated yet

## Proposed technology
Unreal Engine 5 is the current candidate because of its 3D rendering, animation and multiplayer capabilities. The exact engine version, rendering path and minimum device specifications must be validated with a working prototype before committing to production.

## Development principles
1. Prototype the core movement, maze navigation and creature pursuit before expanding scope.
2. Target mobile performance from the beginning.
3. Keep multiplayer authoritative and server-validated.
4. Avoid pay-to-win purchases; paid or earned summons must have clear counters and balanced limits.
5. Build original characters, creatures, maps, names and story elements. The project may use broad maze-survival genre inspiration, but must not copy protected film/game expression or branding.

## Current first milestone
A small playable greybox: one controllable character, one maze test map, one pursuing AI creature, basic health/detection and a simple escape objective.

See [the production roadmap](docs/ROADMAP.md) for the next steps.
