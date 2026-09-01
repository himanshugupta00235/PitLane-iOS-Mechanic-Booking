import SwiftUI

enum Theme {
    // MARK: - Colors (using adaptive colors for dark mode)
    static let background = Color("BackgroundColor")
    static let surface = Color("SurfaceColor")
    static let textPrimary = Color("TextPrimaryColor")
    static let textSecondary = Color("TextSecondaryColor")
    static let accent = Color("AccentColor")
    static let divider = Color("DividerColor")
    static let openColor = Color("OpenColor")
    static let closedColor = Color("ClosedColor")
    static let errorColor = Color("ErrorColor")
    
    // MARK: - Spacing
    enum Spacing {
        static let base: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let screen: CGFloat = 16
        static let large: CGFloat = 20
        static let section: CGFloat = 24
        static let xlarge: CGFloat = 32
    }
    
    // MARK: - Sizing
    enum Size {
        static let ctaHeight: CGFloat = 50
        static let buttonRadius: CGFloat = 8
        static let stampRadius: CGFloat = 4
        static let stampBorder: CGFloat = 1
        static let dividerHeight: CGFloat = 1
        static let iconSmall: CGFloat = 14
        static let iconMedium: CGFloat = 20
        static let iconLarge: CGFloat = 48
    }
    
    // MARK: - Typography
    static let screenTitle = Font.system(size: 28, weight: .bold, design: .default)
    static let garageName = Font.system(size: 17, weight: .semibold, design: .default)
    static let body = Font.system(size: 15, weight: .regular, design: .default)
    static let metadata = Font.system(size: 13, weight: .regular, design: .monospaced)
    static let stamp = Font.system(size: 11, weight: .bold, design: .default)
    static let caption = Font.system(size: 12, weight: .regular, design: .default)
    static let sectionLabel = Font.system(size: 13, weight: .semibold, design: .default)
}
