import SwiftUI

// MARK: - Popover header

/// The popover's first row: the app name in the rounded hero face, and the attribution link
/// pushed to the trailing edge.
public struct PopoverHeader: View {
    private let title: String

    public init(_ title: String) {
        self.title = title
    }

    public var body: some View {
        HStack(spacing: Theme.Space.sm) {
            Text(title).font(.heroTitle)
            Spacer()
            AttributionLink()
        }
    }
}

// MARK: - Attribution link

/// The "made by kageroumado" credit in the popover header. Reads as quiet secondary text but signals
/// it's a link with a trailing external-link arrow, and underlines on hover so the affordance is
/// unmistakable once the pointer lands on it.
public struct AttributionLink: View {
    @State private var hovering = false

    public init() {}

    public var body: some View {
        Link(destination: URL(string: "https://github.com/kageroumado")!) {
            HStack(spacing: 2) {
                Text("made by kageroumado")
                    .underline(hovering)
                Image(systemName: "arrow.up.right")
                    .font(.caption2)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .onHover { hovering = $0 }
    }
}
