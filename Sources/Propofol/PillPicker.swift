import SwiftUI

/// Layout constants at file scope — static stored properties aren't allowed in generic types.
private enum PillPickerLayout {
    static let highlightInset: CGFloat = 2
    static let dividerHeight: CGFloat = 12
}

/// A Safari-style capsule selector: equal-width segments inside a glass capsule, an accent pill
/// sliding behind the selection, and hairline dividers that fade out next to the selected
/// segment. For single-choice rows where a row of independent buttons over-states the options.
///
/// `onTint` is the foreground for the selected label sitting on the saturated accent pill — the
/// suite's accents stay light in both color schemes, so this is a fixed dark color per app rather
/// than `.primary`.
public struct PillPicker<Value: Hashable>: View {
    private let title: String
    private let options: [(value: Value, label: String)]
    @Binding private var selection: Value
    private let height: CGFloat
    private let font: Font
    private let tint: Color
    private let onTint: Color

    public init(
        title: String,
        options: [(value: Value, label: String)],
        selection: Binding<Value>,
        height: CGFloat = 30,
        font: Font = .callout,
        tint: Color = .accentColor,
        onTint: Color,
    ) {
        self.title = title
        self.options = options
        self._selection = selection
        self.height = height
        self.font = font
        self.tint = tint
        self.onTint = onTint
    }

    private typealias Layout = PillPickerLayout

    private var selectedIndex: Int {
        options.firstIndex { $0.value == selection } ?? 0
    }

    public var body: some View {
        GeometryReader { proxy in
            let dividers = CGFloat(options.count - 1)
            let segmentWidth = (proxy.size.width - dividers) / CGFloat(options.count)
            let stride = segmentWidth + 1

            ZStack(alignment: .leading) {
                highlightPill(segmentWidth: segmentWidth, stride: stride)
                segments(segmentWidth: segmentWidth)
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: selectedIndex)
        }
        .frame(height: height)
        .glassEffect(.regular, in: Capsule())
        .accessibilityRepresentation {
            Picker(title, selection: $selection) {
                ForEach(options, id: \.value) { option in
                    Text(option.label).tag(option.value)
                }
            }
            .pickerStyle(.menu)
        }
    }

    private func highlightPill(segmentWidth: CGFloat, stride: CGFloat) -> some View {
        let inset = Layout.highlightInset
        return Capsule()
            .fill(tint)
            .frame(width: segmentWidth - inset * 2, height: height - inset * 2)
            .offset(x: CGFloat(selectedIndex) * stride + inset)
    }

    private func segments(segmentWidth: CGFloat) -> some View {
        HStack(spacing: 0) {
            ForEach(options.enumerated(), id: \.element.value) { index, option in
                Button {
                    selection = option.value
                } label: {
                    Text(option.label)
                        .font(font.weight(index == selectedIndex ? .semibold : .regular))
                        .foregroundStyle(index == selectedIndex ? onTint : .primary)
                        .lineLimit(1)
                        .frame(width: segmentWidth, height: height)
                        .contentShape(.rect)
                }
                .buttonStyle(.plain)

                if index < options.count - 1 {
                    divider(at: index)
                }
            }
        }
    }

    private func divider(at index: Int) -> some View {
        let adjacentToSelected = index == selectedIndex || index + 1 == selectedIndex
        return Rectangle()
            .fill(Color.secondary.opacity(0.3))
            .frame(width: 1, height: Layout.dividerHeight)
            .opacity(adjacentToSelected ? 0 : 1)
    }
}
