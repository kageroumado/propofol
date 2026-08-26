import SwiftUI

// MARK: - Glass surfaces

extension View {
    /// Wraps the view in a Liquid Glass card with the suite's standard radius. Pass `tint` to give
    /// the glass a cast (the app accent for the active hero, amber/orange for warnings).
    public func glassCard(cornerRadius: CGFloat = Theme.Radius.card, tint: Color? = nil) -> some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        let glass: Glass = tint.map { .regular.tint($0) } ?? .regular
        return glassEffect(glass, in: shape)
    }
}
