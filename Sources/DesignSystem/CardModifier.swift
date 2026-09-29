import SwiftUI

private struct CardStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(AppMetrics.paddingStandard)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: AppMetrics.cornerRadiusLarge, style: .continuous))
            .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyleModifier())
    }
}
