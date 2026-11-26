# YOSHRUN — Game Design Document
**Version:** 0.1 (Pre-production foundation)  
**Studio / publisher identity:** YOSHA  
**Tagline:** ESCAPE OR BE HUNTED

## 1. High concept
YOSHRUN is a 3D maze-survival action game for mobile devices. Players enter a colossal ancient labyrinth whose gates, corridors and threats change over time. Survival depends on navigation, teamwork, resource decisions, stealth, combat and escape.

The game's signature is the tension between **the maze as an active environment** and **the hunters / creatures that control its routes**.

## 2. Product goals
- Deliver readable, responsive third-person controls, with first-person as an optional camera.
- Make navigation and escape objectives as important as combat.
- Support short competitive sessions and longer narrative exploration.
- Create a recognizable visual identity built around monumental stone architecture, overgrown wilderness, shifting mechanisms and dangerous creatures.
- Scale visual quality to real Android and iOS hardware rather than assuming high-end PCs.

## Character visual direction\nUse original stylized semi-realistic 3D heroes with expressive faces, layered tactical / survival clothing, premium material definition and strong readable silhouettes. The desired polish is comparable to leading mobile action games, but all YOSHRUN character designs, costumes, faces, logos and animations must be original. See [CHARACTER_ART_DIRECTION.md](CHARACTER_ART_DIRECTION.md) for the provisional roster and production pipeline.\n\n## 3. Design pillars
1. **The maze is alive:** gates, route states, hazards and environmental events reshape player decisions.
2. **Escape is earned:** players gather clues, keys and resources to open routes; the exit is an objective, not a free reward.
3. **Threats are readable:** creatures telegraph intent and provide learnable counterplay.
4. **Team roles matter:** runners and hunters have different goals, tools and information.
5. **Fair progression:** cosmetics and sidegrades are preferred over purchases that guarantee victory.
6. **Mobile-first usability:** clear touch controls, scalable UI, accessible settings and performance budgets.

## 4. Audience and platforms
- Primary target: mobile action / survival players.
- Platforms: Android and iOS.
- Online modes require network connectivity. Offline story / practice content is planned, subject to scope and technical validation.

## 5. Camera and controls
- Default camera: third-person.
- Optional first-person camera where level geometry and animation support it.
- Touch layout: left movement stick; right camera look; contextual interaction; primary action; dodge / sprint; equipment slots.
- Accessibility: sensitivity sliders, aim assistance options where appropriate, button resizing and left-handed layout.

## 6. Core gameplay loop
1. Enter a maze zone or match.
2. Read the environment and identify a route / objective.
3. Explore, collect resources, clues, keys or tools.
4. Avoid or confront threats using limited resources.
5. Coordinate with teammates or outplay opponents.
6. Unlock an exit / complete the round objective.
7. Earn progression rewards and return to the hub.

## 7. Player systems
- Character movement: walk, sprint, crouch, jump / vault where level design supports it.
- Interaction: doors, switches, keys, loot, rescue points and extraction mechanisms.
- Survival: health and a limited set of status effects; avoid excessive simulation until the prototype proves it useful.
- Equipment: a small, readable set of tools and weapons with distinct roles.
- Customization: characters, outfits, emotes and cosmetic effects.
- Progression: account level, mastery and seasonal objectives; competitive power should not be purchasable.

## 8. Creature systems
- AI creatures patrol, investigate sound / sight, pursue, attack and return to a search state.
- Each creature needs a readable silhouette, audio signature, threat range, attack tell, weakness and counterplay.
- Summoned creatures are temporary assists with a cooldown, duration and clear counterplay. A player summons a creature; the player never transforms into it.
- In competitive modes, summon strength and availability must be tuned so purchases do not decide the match.

## 9. World and level design
- The central maze is built from modular stone corridors, courtyards, vertical landmarks, sealed gates and overgrown pockets.
- Navigation must be legible: landmark silhouettes, lighting, signage / symbols and map tools.
- Dynamic route changes must be communicated clearly and must never trap players through unavoidable or invisible state changes.
- Build one compact greybox arena before designing a large world.

## 10. Modes
See [GAME_MODES.md](GAME_MODES.md) for detailed rules:
- MAZE ROYALE — target scale up to 50 players.
- MAZE CLASH — asymmetric 5v5.
- WORLD COLLAPSE — narrative expedition beyond the maze.
- FINAL DESTINY — final story confrontation.

## 11. Economy and monetization
Potential currencies and rewards require later economy testing. The current concept includes gems for creature summons, but monetization must follow these rules:
- No paid item should guarantee a win.
- Competitive summons must have fixed limits, cooldowns and clear counters.
- Prefer cosmetics, battle-pass-style progression and optional convenience that does not compromise fairness.
- Publish prices and reward probabilities clearly wherever required.
- No real-money economy should be implemented before legal, platform and fraud reviews.

## 12. Audio and atmosphere
Use spatial audio to communicate creature proximity, gate movement, footsteps and environmental events. Music should support tension without masking gameplay cues. All sounds and compositions must be original or properly licensed.

## 13. Quality targets
- Stable frame pacing is more important than maximum effects.
- Provide scalable graphics presets and device profiling.
- Network play must remain understandable under realistic mobile latency.
- Test on low-, mid- and high-tier devices before setting minimum specifications.

## 14. Scope discipline
The first prototype is deliberately narrow: one character, one greybox maze, one AI pursuer, one key / gate interaction and one exit. Multiplayer, 50-player scale, monetization and cinematic story production come after the core loop is fun and technically stable.

## 15. Open decisions
- Exact Unreal Engine version and mobile rendering configuration.
- Minimum supported Android / iOS hardware.
- Final match duration, player counts and revive rules.
- Whether first-person is available in all modes.
- Online backend, hosting regions, anti-cheat and moderation plan.
- Economy design and summon acquisition model.
