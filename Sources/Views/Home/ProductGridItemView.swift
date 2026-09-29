import SwiftUI

struct ProductGridItemView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: AppMetrics.cornerRadiusMedium, style: .continuous)
                    .fill(Color.brandPinkTint)
                Image(systemName: product.imageSystemName)
                    .font(.system(size: 36))
                    .foregroundStyle(Color.brandPink)
            }
            .frame(height: 120)

            Text(product.name)
                .font(AppFont.body.weight(.semibold))
                .foregroundStyle(Color.brandTextPrimary)
                .lineLimit(1)
                .accessibilityIdentifier("home_product_name_label_\(product.id)")

            Text(product.category)
                .font(AppFont.caption)
                .foregroundStyle(Color.brandTextSecondary)

            Text("$\(Int(product.price))")
                .font(AppFont.price)
                .foregroundStyle(Color.brandPink)
                .accessibilityIdentifier("home_product_price_label_\(product.id)")
        }
        .padding(10)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: AppMetrics.cornerRadiusLarge, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
        .accessibilityIdentifier("home_product_item_\(product.id)")
    }
}
