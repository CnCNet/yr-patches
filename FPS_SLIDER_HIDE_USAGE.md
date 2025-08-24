# FPS Slider Hide Patch Usage Example

## Overview
The FPS Slider Hide patch allows game hosts to control whether the FPS/gamespeed slider is visible in the in-game pause menu. This is useful for tournament play or preventing players from adjusting game speed during matches.

## Configuration

Add the following setting to your `spawn.ini` file under the `[Settings]` section:

```ini
[Settings]
# Hide the FPS/gamespeed slider from the in-game menu
HideFPSSlider=yes

# Or to show the slider (default behavior)
HideFPSSlider=no
```

## Example spawn.ini

```ini
[Settings]
HideFPSSlider=yes    # This line hides the FPS slider
```

## Behavior

- When `HideFPSSlider=yes`: The FPS/gamespeed slider will not appear in the in-game pause menu
- When `HideFPSSlider=no` or not specified: The slider will appear normally (default behavior)

## Technical Details

This patch is a local UI modification that:
- Does not affect networking or multiplayer synchronization
- Only controls the visibility of the slider in the pause menu
- Is loaded from spawn.ini during game initialization
- Works independently of other game settings

## Note

This setting is read from the spawn.ini file when the game is launched. The setting only affects the visibility of the slider in the in-game menu during gameplay, not the actual FPS cap or performance settings.
