import SwiftUI

struct CartView: View {
    @Environment(CartStore.self) private var cartStore
    @Environment(\.dismiss) private var dismiss
    @Binding var path: NavigationPath

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
                .accessibilityIdentifier("cart_back_button")

                Spacer()

                Text("My Cart")
                    .font(AppFont.headline)
                    .foregroundStyle(Color.brandTextPrimary)
                    .accessibilityIdentifier("cart_title_label")

                Spacer()

                Color.clear.frame(width: 36, height: 36)
            }
            .padding(.horizontal, AppMetrics.paddingStandard)
            .padding(.vertical, 12)

            if cartStore.items.isEmpty {
                Spacer()
                Text("Your cart is empty")
                    .font(AppFont.body)
                    .foregroundStyle(Color.brandTextSecondary)
                    .accessibilityIdentifier("cart_empty_state_label")
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 14) {
                        ForEach(cartStore.items) { item in
                            CartLineItemRow(item: item)
                        }
                    }
                    .padding(.horizontal, AppMetrics.paddingStandard)
                    .padding(.bottom, 16)
                }

                VStack(spacing: 10) {
                    HStack {
                        Text("Sub-total")
                            .foregroundStyle(Color.brandTextSecondary)
                        Spacer()
                        Text("$\(Int(cartStore.subtotal))")
                            .foregroundStyle(Color.brandTextPrimary)
                    }
                    .accessibilityIdentifier("cart_subtotal_label")

                    HStack {
                        Text("Delivery Fee")
                            .foregroundStyle(Color.brandTextSecondary)
                        Spacer()
                        Text("$\(Int(cartStore.deliveryFee))")
                            .foregroundStyle(Color.brandTextPrimary)
                    }
                    .accessibilityIdentifier("cart_delivery_fee_label")

                    HStack {
                        Text("Total Cost")
                            .font(AppFont.headline)
                            .foregroundStyle(Color.brandTextPrimary)
                        Spacer()
                        Text("$\(Int(cartStore.total))")
                            .font(AppFont.headline)
                            .foregroundStyle(Color.brandPink)
                    }
                    .accessibilityIdentifier("cart_total_cost_label")

                    Button("Proceed to Checkout") {
                        path.append(Route.checkout)
                    }
                    .buttonStyle(PrimaryPillButtonStyle())
                    .padding(.top, 6)
                    .accessibilityIdentifier("cart_checkout_button")
                }
                .font(AppFont.body)
                .padding(AppMetrics.paddingStandard)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: AppMetrics.cornerRadiusLarge, style: .continuous))
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: -2)
                .padding(.horizontal, AppMetrics.paddingStandard)
                .padding(.bottom, 8)
            }
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .accessibilityIdentifier("cart_screen")
    }
}
