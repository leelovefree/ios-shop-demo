import SwiftUI

struct CheckoutView: View {
    @Environment(CartStore.self) private var cartStore
    @Environment(\.dismiss) private var dismiss
    @Binding var path: NavigationPath
    @State private var isPlacingOrder = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.brandTextPrimary)
                        .frame(width: 36, height: 36)
                        .background(Color.brandCardBackground)
                        .clipShape(Circle())
                }
                .accessibilityIdentifier("checkout_back_button")

                Spacer()

                Text("Checkout")
                    .font(AppFont.headline)
                    .foregroundStyle(Color.brandTextPrimary)
                    .accessibilityIdentifier("checkout_title_label")

                Spacer()

                Color.clear.frame(width: 36, height: 36)
            }
            .padding(.horizontal, AppMetrics.paddingStandard)
            .padding(.vertical, 12)

            ScrollView {
                VStack(alignment: .leading, spacing: AppMetrics.spacingStandard) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Order Items")
                            .font(AppFont.headline)
                            .foregroundStyle(Color.brandTextPrimary)
                        ForEach(cartStore.items) { item in
                            HStack {
                                Text("\(item.product.name) x\(item.quantity)")
                                    .font(AppFont.body)
                                    .foregroundStyle(Color.brandTextPrimary)
                                Spacer()
                                Text("$\(Int(item.lineTotal))")
                                    .font(AppFont.body)
                                    .foregroundStyle(Color.brandTextSecondary)
                            }
                            .accessibilityIdentifier("checkout_item_row_\(item.id)")
                        }
                    }
                    .cardStyle()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Shipping Address")
                            .font(AppFont.headline)
                            .foregroundStyle(Color.brandTextPrimary)
                        Text("123 Demo Street, Ho Chi Minh City, Vietnam")
                            .font(AppFont.body)
                            .foregroundStyle(Color.brandTextSecondary)
                            .accessibilityIdentifier("checkout_shipping_address_value_label")
                    }
                    .cardStyle()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Payment Method")
                            .font(AppFont.headline)
                            .foregroundStyle(Color.brandTextPrimary)
                        Text("Visa •••• 4242")
                            .font(AppFont.body)
                            .foregroundStyle(Color.brandTextSecondary)
                            .accessibilityIdentifier("checkout_payment_method_value_label")
                    }
                    .cardStyle()

                    VStack(spacing: 10) {
                        HStack {
                            Text("Sub-total")
                                .foregroundStyle(Color.brandTextSecondary)
                            Spacer()
                            Text("$\(Int(cartStore.subtotal))")
                                .foregroundStyle(Color.brandTextPrimary)
                        }
                        .accessibilityIdentifier("checkout_subtotal_label")

                        HStack {
                            Text("Delivery Fee")
                                .foregroundStyle(Color.brandTextSecondary)
                            Spacer()
                            Text("$\(Int(cartStore.deliveryFee))")
                                .foregroundStyle(Color.brandTextPrimary)
                        }
                        .accessibilityIdentifier("checkout_delivery_fee_label")

                        HStack {
                            Text("Total Cost")
                                .font(AppFont.headline)
                                .foregroundStyle(Color.brandTextPrimary)
                            Spacer()
                            Text("$\(Int(cartStore.total))")
                                .font(AppFont.headline)
                                .foregroundStyle(Color.brandPink)
                        }
                        .accessibilityIdentifier("checkout_total_cost_label")
                    }
                    .font(AppFont.body)
                    .cardStyle()
                }
                .padding(.horizontal, AppMetrics.paddingStandard)
                .padding(.bottom, 16)
            }

            VStack(spacing: 10) {
                if isPlacingOrder {
                    ProgressView()
                        .accessibilityIdentifier("checkout_placing_order_indicator")
                }
                Button(isPlacingOrder ? "Placing Order..." : "Place Order") {
                    placeOrder()
                }
                .buttonStyle(PrimaryPillButtonStyle(isEnabled: !isPlacingOrder))
                .disabled(isPlacingOrder)
                .accessibilityIdentifier("checkout_place_order_button")
            }
            .padding(.horizontal, AppMetrics.paddingStandard)
            .padding(.bottom, 8)
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .accessibilityIdentifier("checkout_screen")
    }

    private func placeOrder() {
        isPlacingOrder = true
        Task {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            let orderId = "ORD-\(Int.random(in: 100_000...999_999))"
            cartStore.clear()
            isPlacingOrder = false
            path.append(Route.orderConfirmed(orderId: orderId))
        }
    }
}
