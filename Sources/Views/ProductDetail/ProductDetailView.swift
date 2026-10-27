import SwiftUI

struct ProductDetailView: View {
    @Environment(CartStore.self) private var cartStore
    @Environment(FavoritesStore.self) private var favoritesStore
    @Environment(\.dismiss) private var dismiss
    let product: Product
    @Binding var path: NavigationPath

    @State private var selectedSize: String
    @State private var selectedColor: ProductColorOption
    @State private var quantity: Int = 1
    @State private var showAddedConfirmation = false

    init(product: Product, path: Binding<NavigationPath>) {
        self.product = product
        self._path = path
        self._selectedSize = State(initialValue: product.sizes.first ?? "")
        self._selectedColor = State(initialValue: product.colors.first ?? ProductColorOption(name: "Default", hex: "#000000"))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppMetrics.spacingStandard) {
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
                    .accessibilityIdentifier("product_detail_back_button")

                    Spacer()

                    Text("Detail Product")
                        .font(AppFont.headline)
                        .foregroundStyle(Color.brandTextPrimary)

                    Spacer()

                    Button {
                        favoritesStore.toggle(product)
                    } label: {
                        Image(systemName: favoritesStore.isFavorite(product) ? "heart.fill" : "heart")
                            .foregroundStyle(.red)
                            .frame(width: 36, height: 36)
                            .background(Color.brandCardBackground)
                            .clipShape(Circle())
                    }
                    .accessibilityIdentifier("product_detail_favorite_button")
                }
                .padding(.horizontal, AppMetrics.paddingStandard)

                HStack(alignment: .top, spacing: 10) {
                    ZStack {
                        RoundedRectangle(cornerRadius: AppMetrics.cornerRadiusLarge, style: .continuous)
                            .fill(Color.brandPinkTint)
                        Image(systemName: product.imageSystemName)
                            .font(.system(size: 90))
                            .foregroundStyle(Color.brandPink)
                    }
                    .frame(height: 320)
                    .frame(maxWidth: .infinity)
                    .accessibilityIdentifier("product_detail_hero_image")

                    VStack(spacing: 8) {
                        ForEach(0..<4) { index in
                            RoundedRectangle(cornerRadius: AppMetrics.cornerRadiusMedium, style: .continuous)
                                .fill(Color.brandPinkTint)
                                .frame(width: 60, height: 68)
                                .overlay(
                                    Image(systemName: product.imageSystemName)
                                        .font(.system(size: 22))
                                        .foregroundStyle(Color.brandPink.opacity(0.7))
                                )
                                .accessibilityIdentifier("product_detail_thumbnail_\(index)")
                        }
                    }
                }
                .padding(.horizontal, AppMetrics.paddingStandard)

                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(product.name)
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.brandTextPrimary)
                                .accessibilityIdentifier("product_detail_name_label")
                            Text(product.category)
                                .font(AppFont.caption)
                                .foregroundStyle(Color.brandTextSecondary)
                                .accessibilityIdentifier("product_detail_category_label")
                        }
                        Spacer()
                        Text("$\(Int(product.price))")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.brandTextPrimary)
                            .accessibilityIdentifier("product_detail_price_label")
                    }
                }
                .padding(.horizontal, AppMetrics.paddingStandard)
                .padding(.top, 8)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Select Size")
                        .font(AppFont.headline)
                        .foregroundStyle(Color.brandTextPrimary)
                    HStack(spacing: 10) {
                        ForEach(product.sizes, id: \.self) { size in
                            Button(size) {
                                selectedSize = size
                            }
                            .buttonStyle(SelectablePillButtonStyle(isSelected: selectedSize == size))
                            .accessibilityIdentifier("product_detail_size_option_\(size.lowercased())")
                        }
                    }
                }
                .padding(.horizontal, AppMetrics.paddingStandard)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Colors")
                        .font(AppFont.headline)
                        .foregroundStyle(Color.brandTextPrimary)
                    HStack(spacing: 12) {
                        ForEach(product.colors) { color in
                            ColorSwatchView(color: color, isSelected: selectedColor.name == color.name) {
                                selectedColor = color
                            }
                        }
                    }
                }
                .padding(.horizontal, AppMetrics.paddingStandard)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Description")
                        .font(AppFont.headline)
                        .foregroundStyle(Color.brandTextPrimary)
                    Text(product.description)
                        .font(AppFont.body)
                        .foregroundStyle(Color.brandTextSecondary)
                        .accessibilityIdentifier("product_detail_description_label")
                    Button("Learn More") {}
                        .font(AppFont.body.weight(.semibold))
                        .foregroundStyle(Color.brandPink)
                        .accessibilityIdentifier("product_detail_learn_more_button")
                }
                .padding(.horizontal, AppMetrics.paddingStandard)

                if showAddedConfirmation {
                    Text("Added to cart")
                        .font(AppFont.caption)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.brandPink)
                        .clipShape(Capsule())
                        .padding(.horizontal, AppMetrics.paddingStandard)
                        .accessibilityIdentifier("product_detail_add_to_cart_confirmation_label")
                }

                HStack(spacing: 14) {
                    QuantityStepperView(
                        decrementId: "product_detail_quantity_decrement_button",
                        valueId: "product_detail_quantity_value_label",
                        incrementId: "product_detail_quantity_increment_button",
                        quantity: $quantity
                    )

                    Button("Buy Now") {
                        cartStore.add(product: product, size: selectedSize, color: selectedColor, quantity: quantity)
                        showAddedConfirmation = true
                        path.append(Route.cart)
                    }
                    .buttonStyle(PrimaryPillButtonStyle())
                    .accessibilityIdentifier("product_detail_buy_now_button")
                }
                .padding(.horizontal, AppMetrics.paddingStandard)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .accessibilityIdentifier("product_detail_screen")
    }
}
