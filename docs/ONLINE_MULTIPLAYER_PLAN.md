# YOSHRUN — Online Multiplayer Technical Plan

## Non-negotiable architecture
Use a server-authoritative model for matchmaking, match timers, team assignment, objective state, damage, monster summons, rewards, and currency. The mobile client sends player inputs and renders replicated state; it must not decide trusted outcomes.

## Match modes
- MAZE CLASH: 10 players, two teams of five. Runners collect keys and escape; hunters stop them. Implement this mode first as the smallest online production target.
- MAZE ROYALE: target 50 concurrent players per match. This is a capacity goal, not a guaranteed capability. It requires dedicated-server profiling, replication budgets, load tests, and regional latency testing.

## Services required
- Account identity and secure session tokens.
- Matchmaking queues, party membership, region selection, and reconnect handling.
- Dedicated match servers with authoritative simulation.
- Persistent player profile, progression, inventory, and purchase ledger.
- Moderation/reporting, rate limits, telemetry, crash reporting, and operational monitoring.
- Voice communication provider or self-hosted voice infrastructure, with mute/report controls.

## Economy and fairness
- Premium cosmetics must not grant unavoidable competitive advantages.
- Summoned monsters need visible duration, cooldown, counterplay, and server-side validation.
- Gems and purchases must be recorded server-side; never trust a balance supplied by the client.
- Add parental/privacy and platform purchase compliance before launch.

## Delivery order
1. Offline gameplay loop and deterministic rules.
2. Two-client network prototype and server-authoritative movement/objectives.
3. Closed 5v5 tests, reconnect and abuse testing.
4. Performance and server cost profiling.
5. Only then prototype 50-player scale and decide whether the target is feasible at acceptable cost.
