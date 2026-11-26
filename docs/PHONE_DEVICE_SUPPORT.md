# YOSHRUN — Phone Device Support Policy

YOSHRUN is designed exclusively for Android phones and iPhones. A PC release is not part of the product plan.

## Compatibility objective
Support a broad range of phones through scalable quality settings. "All phones" is the aspiration, not a compatibility claim: hardware, operating-system and driver differences mean each tier must be tested.

## Device tiers
- Entry-level: low render scale, simple materials, limited shadow distance, reduced effects and strict memory budgets.
- Mid-range: balanced render scale, shadows, effects and view distance.
- Flagship: higher visual quality subject to sustained thermal and battery testing.

## Required test matrix
For each representative device, record:
- Exact model, chipset/GPU, RAM and OS version.
- Average and 1% low frame rate during a 20-minute session.
- Peak memory, crash rate, loading duration and network stability.
- Device temperature, throttling and battery drain.
- Touch latency, UI scaling, safe-area behavior and aspect ratio.

## Release gates
Do not publish minimum specifications until tests establish them. Block release for devices with repeatable crashes, severe overheating, unusable touch input or sustained performance below the agreed tier target.

## Platform order
1. Android development and closed testing.
2. iOS port/build validation and closed testing.
3. Parallel Android/iOS release readiness.
