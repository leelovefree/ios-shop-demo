import SwiftUI

extension Color {
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }

    static let brandPink = Color(hex: "#F72585")
    static let brandPinkTint = Color(hex: "#FCE4EC")
    static let brandTextPrimary = Color(hex: "#1A1A1A")
    static let brandTextSecondary = Color(hex: "#8E8E93")
    static let brandCardBackground = Color(hex: "#F8F8FA")
    static let brandBorder = Color(hex: "#E5E5EA")
}

enum AppFont {
    static let title = Font.system(size: 22, weight: .bold, design: .rounded)
    static let headline = Font.system(size: 17, weight: .semibold, design: .rounded)
    static let body = Font.system(size: 15, weight: .regular, design: .rounded)
    static let caption = Font.system(size: 13, weight: .regular, design: .rounded)
    static let price = Font.system(size: 18, weight: .bold, design: .rounded)
}

enum AppMetrics {
    static let cornerRadiusLarge: CGFloat = 20
    static let cornerRadiusMedium: CGFloat = 14
    static let paddingStandard: CGFloat = 16
    static let spacingStandard: CGFloat = 12
    static let pillButtonHeight: CGFloat = 56
}
