# Crossfire — NUI Crosshair for FiveM

A lightweight, polished crosshair with a modern NUI. Works standalone and with ESX/QBCore. Open the UI with `/cross`.

## Features

- Three visibility modes: Always, Armed, Aiming
- Vector styles: Classic, T, Dot, Circle, X
- PNG presets (1–7) with scale and opacity
- Live preview with instant updates
- Enemy highlight (reticle turns to enemy color when aiming at a ped)
- Hides GTA V default reticle
- Clean purple “glass” UI with subtle animations and a small rMod badge
- Settings saved per player via KVP

## Installation

1. Copy the `crossfire` folder into your server's `resources` (e.g. `resources/[rmod]/crossfire`).
2. Ensure the resource in your server.cfg:

```
ensure crossfire
```

3. Start the server and use `/cross` in-game.

## Usage

- Open panel: `/cross` (default keybind also mapped to HOME)
- Mode: `Always`, `Armed`, `Aiming`
- Type: `Vector` or `PNG`
- Vector options: Style, Color, Size, Thickness, Gap, Outline, Dot in center
- PNG options: Preset (1–7), Scale, Opacity

The overlay is hidden while the panel is open.

## Configuration (`config.lua`)

- `DefaultMode`: `always` | `armed` | `aiming`
- `HideDefaultReticle`: boolean
- `DefaultSettings`: initial values (type/style/color/size/thickness/gap/outline/dotInCenter/pngPreset/pngScale/pngOpacity)
- `EnemyAimHighlight`: turn on enemy highlight
- `EnemyColor`: color applied when aiming at enemies
- `HighlightOnlyWhenAiming`: only highlight while aiming
- `HighlightPlayers`: also highlight when aiming at players

## Notes

- This resource is fully client-side for functionality; no server scripts required.
- If you add or rename PNGs under `html/cross/`, update references accordingly.
- The UI is in English.

## Troubleshooting

- Double reticle: make sure `HideDefaultReticle = true` and disable other reticle scripts.
- NUI not opening: verify `fxmanifest.lua` `ui_page` and `files` list include all HTML/CSS/JS assets.
- PNG not tinting as expected: PNG tint is an approximation via CSS filters and may vary slightly per image.