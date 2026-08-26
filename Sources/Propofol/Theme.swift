import SwiftUI

/// The suite's shared design tokens: one radius/spacing ladder, one popover width, Liquid Glass
/// surfaces, rounded hero typography. Each app extends `Theme` with its own palette — the accent
/// color does the app's "active" talking (amber in Adrafinil, violet in Rocuronium, lilac in
/// Dantrolene); everything geometric lives here so the popovers stay siblings.
public enum Theme {
    // MARK: - Geometry

    public enum Radius {
        /// Outer cards / panels.
        public static let card: CGFloat = 14
        /// Rows and grouped controls inside a card.
        public static let inner: CGFloat = 10
        /// Small controls, chips, hover fills.
        public static let control: CGFloat = 8
    }

    public enum Space {
        public static let xs: CGFloat = 4
        public static let sm: CGFloat = 8
        public static let md: CGFloat = 12
        public static let lg: CGFloat = 16
        public static let xl: CGFloat = 20
    }

    /// Fixed width of the menu-bar popover (matches the platform norm); height hugs content.
    public static let popoverWidth: CGFloat = 320

    // MARK: - Shapes

    public static var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: Radius.card, style: .continuous)
    }
    public static var innerShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: Radius.inner, style: .continuous)
    }
    public static var controlShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: Radius.control, style: .continuous)
    }
}

extension Font {
    /// Rounded title used for hero lines and headers — friendlier than the default for a utility app.
    public static let heroTitle = Font.system(.headline, design: .rounded).weight(.semibold)
    /// Rounded medium-weight body for emphasized names inside cards (agents, tools, devices).
    public static let toolName = Font.system(.body, design: .rounded).weight(.medium)
}
