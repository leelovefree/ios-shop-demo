import SwiftUI

struct OrderConfirmedView: View {
    let orderId: String
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: AppMetrics.spacingStandard) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color.brandPinkTint)
                    .frame(width: 120, height: 120)
                Image(systemName: "checkmark")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(Color.brandPink)
            }
            .accessibilityIdentifier("order_confirmed_checkmark_icon")

            Text("Order Confirmed!")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(Color.brandTextPrimary)
                .accessibilityIdentifier("order_confirmed_title_label")

            Text("Order ID: \(orderId)")
                .font(AppFont.headline)
                .foregroundStyle(Color.brandPink)
                .accessibilityIdentifier("order_confirmed_order_id_label")

            Text("Thank you for your purchase. Your order has been placed and will be on its way shortly.")
                .font(AppFont.body)
                .foregroundStyle(Color.brandTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .accessibilityIdentifier("order_confirmed_message_label")

            Spacer()

            Button("Back to Home") {
                path.removeLast(path.count)
            }
            .buttonStyle(PrimaryPillButtonStyle())
            .padding(.horizontal, AppMetrics.paddingStandard)
            .padding(.bottom, 24)
            .accessibilityIdentifier("order_confirmed_back_to_home_button")
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .accessibilityIdentifier("order_confirmed_screen")
    }
}
