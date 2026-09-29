import SwiftUI

struct CartLineItemRow: View {
    @Environment(CartStore.self) private var cartStore
    let item: CartItem

    private var quantityBinding: Binding<Int> {
        Binding(
            get: { item.quantity },
            set: { cartStore.updateQuantity(itemId: item.id, to: $0) }
        )
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: AppMetrics.cornerRadiusMedium, style: .continuous)
                    .fill(Color.brandPinkTint)
                Image(systemName: item.product.imageSystemName)
                    .font(.system(size: 26))
                    .foregroundStyle(Color.brandPink)
            }
            .frame(width: 64, height: 64)
            .accessibilityIdentifier("cart_item_thumbnail_\(item.id)")

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.product.name)
                            .font(AppFont.body.weight(.semibold))
                            .foregroundStyle(Color.brandTextPrimary)
                            .accessibilityIdentifier("cart_item_name_label_\(item.id)")
                        Text(item.product.category)
                            .font(AppFont.caption)
                            .foregroundStyle(Color.brandTextSecondary)
                            .accessibilityIdentifier("cart_item_category_label_\(item.id)")
                    }
                    Spacer()
                    Button {
                        cartStore.remove(itemId: item.id)
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.orange)
                    }
                    .accessibilityIdentifier("cart_item_remove_button_\(item.id)")
                }

                HStack {
                    Text("$\(Int(item.product.price))")
                        .font(AppFont.price)
                        .foregroundStyle(Color.brandTextPrimary)
                        .accessibilityIdentifier("cart_item_price_label_\(item.id)")
                    Spacer()
                    QuantityStepperView(
                        decrementId: "cart_item_qty_decrement_button_\(item.id)",
                        valueId: "cart_item_qty_value_label_\(item.id)",
                        incrementId: "cart_item_qty_increment_button_\(item.id)",
                        quantity: quantityBinding,
                        minimum: 1
                    )
                }
            }
        }
        .cardStyle()
        .accessibilityIdentifier("cart_item_row_\(item.id)")
    }
}
