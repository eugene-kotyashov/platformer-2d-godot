# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added
- Dedicated input actions `move_left`, `move_right`, and `jump`, keeping the built-in `ui_*` actions free for menus. `jump` is bound to Space, Z, and Up.
- Coyote time, jump buffering, and variable jump height (release early to jump lower).
- Invulnerability frames and knockback after taking a hit (`PhysicsComponent`).
- Unit tests for `HealthComponent`, `StateMachine`, and `PhysicsComponent` under `tests/test_components.gd`.
- A "YOU WIN!" screen shown when the player reaches the level-exit flag, with Restart and Quit buttons.

### Changed
- Enemy air movement now uses the enemy's own `move_direction` instead of the player's keyboard input.
- Jump applies its impulse once on state entry instead of adding to velocity every frame.
- Gravity is now applied consistently in the idle, walk, and jump states.
- Raised the player's jump height (roughly 112 px to 174 px) and gravity (100 to 450, set through `PlayerController`) for a higher, snappier jump; softened the variable-jump cut from 0.4 to 0.5.
- Unified the win and game-over screens on a shared `EndScreen` (`ui_end_screen.tscn` / `ui_end_screen.gd`). Both now show a dimmed overlay, a heading, and Restart + Quit buttons and freeze the game; the game-over screen keeps its 1 s delay so the death animation finishes first.
- Player death pauses the game after the death animation finishes; the game-over and status layers use `PROCESS_MODE_ALWAYS` so the Restart button still works while paused.
- Defeated enemies disable their hurtbox and attack, then are removed from the scene after their death animation.
- Removed debug `print` calls from hot code paths.

### Fixed
- Fixed swapped player attack state names (`attack1_state` / `attack2_state`).
- Fixed the enemy `Hurtbox` collision layer (now the "enemy hurt" layer instead of the default).
- Hardened the hurtbox damage handler to resolve the attacker safely instead of walking three parents up.
- Guarded `State.on_exit()` and `StateMachine._ready()` against null animation and attack references.
- Enemy `Jump` state no longer references a missing animation clip.
- Cleared editor warnings for unused parameters.
- Enemies now turn around when they reach the level's left or right wall instead of walking into it (`AIComponent`).