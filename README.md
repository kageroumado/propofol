# Propofol

Shared SwiftUI design language for kagerou menu-bar apps: Liquid Glass popovers with one
radius/spacing ladder, one popover width, and the same header, chips, and badges everywhere.

## What's in it

- **`Theme`** — geometric tokens: `Radius`, `Space`, `popoverWidth`, and the `cardShape` /
  `innerShape` / `controlShape` continuous rounded rectangles. Plus `Font.heroTitle` and
  `Font.toolName`.
- **`.glassCard(cornerRadius:tint:)`** — Liquid Glass card at the standard radius; tint with
  the app accent for the active hero.
- **`PopoverHeader("AppName")`** — hero-face app name + `AttributionLink` (links to
  kagerou.glass).
- **`PillPicker`** — Safari-style capsule selector with an accent pill sliding behind the
  selection.
- **`SectionLabel`**, **`FooterChip`** — small-caps section heading; glass capsule action for
  the bottom bar.
- **`StateChip`**, **`StatusDot`** — capsule badge and state dot.
- **`.popoverItem`** (`PopoverMenuItemStyle`) — full-width hover-fill action row.

## Using it

Add as an SPM dependency pointing at the GitHub repo:

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/kageroumado/propofol.git", from: "0.1.0"),
]
```

Or in Xcode: File → Add Package Dependencies → `https://github.com/kageroumado/propofol.git`.

Then `import Propofol`. The package holds only geometry and components; each app defines its
palette as an extension so `Theme.<color>` reads naturally:

```swift
import Propofol

extension Theme {
    static let awake = Color.accentColor
}
```

## Style rules

- The popover is a `MenuBarExtra` with `.menuBarExtraStyle(.window)`; the panel background is
  the system material, untouched. Cards inside it are `.glassCard()` inside a
  `GlassEffectContainer`.
- Small controls and badges are capsules; use a fixed-radius rounded rectangle only when the
  control animates between widths, because a `Capsule`'s radius morphs during the resize.
- Corners nest concentrically: a shape inset inside a card uses the card's radius minus the
  padding between them, never an arbitrary smaller radius.
- Content sits at least `Theme.Space.md` from a card's edge, and cards sit `Theme.Space.md`
  apart; the popover's outer padding is `Theme.Space.lg`.
- Extract any element bigger than a few lines into its own view; magic numbers go through
  `Theme`, not inline.
