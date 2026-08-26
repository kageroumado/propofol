import SwiftUI

// MARK: - Status dot

/// A small filled state indicator. `glow` adds a soft halo for the active state.
public struct StatusDot: View {
    private let color: Color
    private let glow: Bool
    private let diameter: CGFloat

    public init(color: Color, glow: Bool = false, diameter: CGFloat = 8) {
        self.color = color
        self.glow = glow
        self.diameter = diameter
    }

    public var body: some View {
        Circle()
            .fill(color)
            .frame(width: diameter, height: diameter)
            .shadow(color: glow ? color.opacity(0.7) : .clear, radius: glow ? 4 : 0)
    }
}

// MARK: - State chip

/// A compact pill for state, detection, and tier badges.
public struct StateChip: View {
    private let text: String
    private let systemImage: String?
    private let tint: Color

    public init(text: String, systemImage: String? = nil, tint: Color = .secondary) {
        self.text = text
        self.systemImage = systemImage
        self.tint = tint
    }

    public var body: some View {
        HStack(spacing: 4) {
            if let systemImage { Image(systemName: systemImage) }
            Text(text)
        }
        .font(.caption2.weight(.medium))
        .foregroundStyle(tint)
        .padding(.horizontal, Theme.Space.sm)
        .padding(.vertical, 3)
        .background(Capsule().fill(tint.opacity(0.15)))
    }
}

// MARK: - Section label

/// The small-caps section heading above a group of controls ("SETTINGS", "RECENT GAMES").
public struct SectionLabel: View {
    private let text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
            .font(.system(size: 10.5, weight: .semibold))
            .kerning(0.7)
            .textCase(.uppercase)
            .foregroundStyle(.tertiary)
            .padding(.horizontal, Theme.Space.xs)
    }
}

// MARK: - Footer chip

/// A small glass capsule for the popover's bottom bar — an icon-and-text action that reads as
/// quiet secondary UI.
public struct FooterChip: View {
    private let text: String
    private let systemImage: String
    private let action: () -> Void

    public init(text: String, systemImage: String, action: @escaping () -> Void) {
        self.text = text
        self.systemImage = systemImage
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Label {
                Text(text)
                    .lineLimit(1)
            } icon: {
                Image(systemName: systemImage)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .buttonStyle(.glass)
        .controlSize(.small)
    }
}

// MARK: - Popover menu item style

/// A full-width, left-aligned button with a subtle hover fill — the popover's primary action row
/// style. Use inside the popover's footer/menu.
public struct PopoverMenuItemStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        ItemBody(configuration: configuration)
    }

    private struct ItemBody: View {
        let configuration: ButtonStyleConfiguration
        @State private var hovering = false

        var body: some View {
            configuration.label
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Theme.Space.md)
                .padding(.vertical, Theme.Space.sm)
                .background(Theme.controlShape.fill(Color.primary.opacity(hovering ? 0.08 : 0)))
                .contentShape(Theme.controlShape)
                .opacity(configuration.isPressed ? 0.55 : 1)
                .onHover { hovering = $0 }
        }
    }
}

extension ButtonStyle where Self == PopoverMenuItemStyle {
    public static var popoverItem: PopoverMenuItemStyle {
        PopoverMenuItemStyle()
    }
}
