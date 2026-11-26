# YOSHRUN — Character Art Direction & Roster
**Version:** 0.1 — Original YOSHA character concepts

## Visual target
Aim for the production polish and readability associated with leading mobile battle-royale character games: stylized semi-realistic 3D proportions, expressive faces, strong silhouettes, layered clothing, premium material response, distinctive hair and accessories, and readable animations on a phone screen.

This is a quality reference only. YOSHRUN must use original character identities and original designs. Do not reproduce Free Fire characters, costumes, faces, logos, signature accessories, promotional poses, or other protected designs.

## Character modelling standard
- Full-body 3D characters with consistent anatomy and a recognizable silhouette at gameplay camera distance.
- Detailed face, hair, hands, footwear, fabric folds, stitching, straps, protective panels and believable wear.
- PBR materials: fabric, leather, rubber, metal and emissive accents.
- Separate modular meshes for hair, headwear, torso, legs, footwear and optional accessories where practical.
- Rigged humanoid skeleton with locomotion, sprint, crouch, jump/vault, hit reaction, interaction, downed and victory animations.
- Facial identity should remain readable without excessive tiny details.
- Each character gets an original color palette, emblem and short backstory.
- Cosmetics change appearance only; competitive stats remain fair.

## Launch roster — concept stage
These are design briefs, not completed 3D assets.

### Runners
1. **RAYAN — Pathfinder**
   - Role fantasy: calm route-reader and experienced escape planner.
   - Look: charcoal utility jacket, muted teal panels, compact field pack, map tags and rugged boots.
   - Signature visual: a folded maze-map device on the forearm.
   - Ability concept: briefly highlights nearby route clues; no wall-hacks or permanent enemy tracking.

2. **LINA — Field Medic**
   - Role fantasy: resilient rescue specialist.
   - Look: sand-coloured tactical layers, red medical pouch accents, reinforced gloves and practical boots.
   - Signature visual: compact medical rig and distinctive shoulder patch.
   - Ability concept: faster revive or a limited small team heal with a clear cooldown.

3. **KADIR — Mechanic**
   - Role fantasy: opens mechanisms and improvises under pressure.
   - Look: dark workwear, copper hardware, tool belt, protective knee panels and a weathered hood.
   - Signature visual: mechanical wrist tool and utility harness.
   - Ability concept: interacts with selected switches or gates slightly faster; cannot bypass key objectives.

4. **NOUR — Echo**
   - Role fantasy: observant scout who reads sound and movement.
   - Look: lightweight slate-blue clothing, soft hood, acoustic headset and minimal equipment.
   - Signature visual: twin signal discs attached to the belt.
   - Ability concept: sends one short-range sound pulse that reveals recent environmental disturbance, not exact enemy positions.

### Hunters
5. **THE WARDEN — Maze Enforcer**
   - Role fantasy: disciplined human pursuer in the MAZE CLASH hunter role.
   - Look: imposing but human silhouette, layered dark armour, weathered mantle and a distinctive original mask shape.
   - Signature visual: a heavy gate-key insignia.
   - Ability concept: temporarily marks a recently used objective, with visible warning and counterplay.

6. **SABLE — Tracker**
   - Role fantasy: agile hunter who pressures routes rather than overpowering players.
   - Look: lean silhouette, asymmetrical leather-and-fabric layers, muted burgundy accents and light protective gear.
   - Signature visual: a set of route tokens worn at the waist.
   - Ability concept: deploys a short-lived trail sensor that runners can spot and disable.

## Character presentation
- Main menu: full-body idle pose, subtle breathing, cloth movement and a slow camera orbit.
- Character selection: rotating model, name, role, short biography and ability preview.
- In-match: clear team-colour accents and silhouette readability; avoid excessive glow or visual clutter.
- Unlocks: earnable progression and optional cosmetics. No paid ability advantage.

## Mobile performance tiers
- High tier: full material detail, higher-resolution textures, hair/cloth secondary motion and richer effects.
- Mid tier: reduced texture sizes, simpler hair/cloth simulation and fewer material layers.
- Entry tier: compact texture atlases, baked details, simpler shaders and reduced effects while preserving silhouette and readability.
- Use LODs, mesh reuse, texture atlases and animation compression. Establish budgets only after profiling real devices.

## Production pipeline
1. Approve 2D front / side / back concept sheets for each character.
2. Approve colour palette and silhouette at phone gameplay scale.
3. Create high-poly sculpt and clean low-poly game mesh.
4. Bake normal / AO details and author PBR textures.
5. Rig, skin and validate the shared humanoid animation set.
6. Import into Godot, configure LODs and mobile materials.
7. Profile on low-, mid- and high-tier Android phones.
8. Replace placeholder capsules only after the character passes visual and performance review.

## Asset status
No final character model, texture set, rig, animation pack or in-game character-selection screen is present yet. Names and concepts are provisional until concept art and gameplay review.
