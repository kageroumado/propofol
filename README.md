# Propofol

The shared SwiftUI design language for kagerou menu-bar apps: Liquid Glass popovers with one
radius/spacing ladder, one popover width, and the same header, chips, and badges everywhere.

## What's in it

- **`Theme`** — the geometric tokens: `Radius` (card 14 / inner 10 / control 8), `Space`
  (4 / 8 / 12 / 16 / 20), `popoverWidth` (320), and the `cardShape` / `innerShape` /
  `controlShape` continuous rounded rectangles. Plus `Font.heroTitle` and `Font.toolName`.
- **`.glassCard(cornerRadius:tint:)`** — wraps a view in a Liquid Glass card at the standard
  radius; tint it with the app accent for the active hero.
- **`PopoverHeader("AppName")`** — the popover's first row: hero-face app name + `AttributionLink` (links to kagerou.glass).
- **`PillPicker`** — Safari-style capsule selector: glass capsule, accent pill sliding behind the
  selection; pass the app's `onTint` for the label on the accent.
- **`SectionLabel`**, **`FooterChip`** — small-caps section heading; small glass capsule action
  for the bottom bar.
- **`StateChip`**, **`StatusDot`** — capsule badge and state dot.
- **`.popoverItem`** (`PopoverMenuItemStyle`) — full-width hover-fill action row.

## Using it

Add as a local package dependency (Xcode → Add Local Package → `~/Developer/propofol`), then
`import Propofol`. The package holds only geometry and components; each app defines its palette
as an extension so `Theme.<color>` reads naturally at call sites:

```swift
import Propofol

extension Theme {
    /// The amber accent — "awake". Backed by the AccentColor asset.
    static let awake = Color.accentColor
}
```

## Style rules

- The popover is a `MenuBarExtra` with `.menuBarExtraStyle(.window)`; the panel background is the
  system material, untouched. Cards inside it are `.glassCard()` inside a `GlassEffectContainer`.
- Small controls and badges are capsules; use a fixed-radius rounded rectangle instead only when
  the control animates between widths, because a `Capsule`'s radius morphs during the resize.
- Corners nest concentrically: a shape inset inside a card uses the card's radius minus the
  padding between them (14 − 8 = 6), never an arbitrary smaller radius.
- Content sits at least `Theme.Space.md` from a card's edge, and cards sit `Theme.Space.md`
  apart; the popover's outer padding is `Theme.Space.lg`.
- Extract any element bigger than a few lines into its own view; magic numbers go through
  `Theme`, not inline.
