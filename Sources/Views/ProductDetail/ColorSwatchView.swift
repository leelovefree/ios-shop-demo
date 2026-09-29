import SwiftUI

struct ColorSwatchView: View {
    let color: ProductColorOption
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .fill(Color(hex: color.hex))
                .frame(width: 32, height: 32)
                .overlay(
                    Circle()
                        .stroke(isSelected ? Color.brandPink : Color.clear, lineWidth: 2)
                        .padding(-4)
                )
        }
        .accessibilityIdentifier("product_detail_color_option_\(color.name.lowercased())")
        .accessibilityLabel(color.name)
    }
}
