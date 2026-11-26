# YOSHRUN — Game Modes
**Version:** 0.1 (Proposed rules; subject to playtesting)

## MAZE ROYALE
**Target format:** up to 50 players in a shared maze instance.

### Objective
Survive the shifting labyrinth, gather useful resources, deal with AI creatures and rival players, discover an escape route, and reach extraction.

### Match flow
1. Players enter at separated spawn points.
2. The maze opens in stages; players explore and gather.
3. Environmental events alter selected routes with clear warnings.
4. AI creatures patrol and react to sound, sight and player activity.
5. Players may cooperate temporarily or compete for scarce resources.
6. An extraction route becomes available; players who reach it complete the escape objective.

### Design safeguards
- 50 players is a target, not a proven capacity. Begin with small server tests and scale only after profiling.
- Avoid unavoidable spawn deaths and unreadable route closures.
- Tune AI density and loot around server performance and match length.

## MAZE CLASH
**Format:** 5 Runners vs 5 Hunters.

### Runner team
- Locate keys, clues or objective items.
- Coordinate to unlock gates and activate the escape route.
- Rescue / assist teammates if the final rules allow it.
- Reach the exit before the round ends.

### Hunter team
- Track runner movement using fair, limited information.
- Control chokepoints and use traps / route denial.
- Prevent the runners from completing the escape.
- Capture or eliminate runners according to the selected round rules.

### Round structure
- Best-of series with alternating sides is the proposed competitive format.
- Each round has a fixed timer.
- Runners win by meeting the escape condition before time expires.
- Hunters win by preventing escape until time expires or meeting the capture condition.
- Exact timer, capture count, respawns and side-switch rules require playtesting.

### Fairness
- Both teams need distinct but balanced information.
- Hunters should not have permanent wall visibility.
- Runners need counterplay: hiding, decoys, route choices, temporary disables and teamwork.
- Maps need multiple viable routes to prevent spawn camping.

## WORLD COLLAPSE
**Type:** story / expedition mode.

Players explore the dangerous wilderness beyond the maze. The mode introduces new settlements, hostile factions, environmental hazards and creatures, while continuing the central mystery. It should reuse the core movement, interaction and AI systems where possible.

## FINAL DESTINY
**Type:** final story chapter / climactic encounter.

The player discovers the origin and purpose of the maze and confronts the force behind it. The finale should resolve the main narrative while leaving room for future stories only if the ending earns it.

## Offline play
Offline content is planned for story missions, training and selected solo challenges. Competitive multiplayer modes require online services. Do not advertise a mode as offline until it works without a network connection in a release build.
