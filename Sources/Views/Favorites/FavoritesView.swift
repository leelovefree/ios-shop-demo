import SwiftUI

struct FavoritesView: View {
    @Environment(FavoritesStore.self) private var favoritesStore
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
                .accessibilityIdentifier("favorites_back_button")

                Spacer()

                Text("Favorites")
                    .font(AppFont.headline)
                    .foregroundStyle(Color.brandTextPrimary)
                    .accessibilityIdentifier("favorites_title_label")

                Spacer()

                Color.clear.frame(width: 36, height: 36)
            }
            .padding(.horizontal, AppMetrics.paddingStandard)
            .padding(.vertical, 12)

            if favoritesStore.products.isEmpty {
                Spacer()
                Text("No favorites yet")
                    .font(AppFont.body)
                    .foregroundStyle(Color.brandTextSecondary)
                    .accessibilityIdentifier("favorites_empty_state_label")
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(favoritesStore.products) { product in
                            HStack(spacing: 12) {
                                Button {
                                    path.append(Route.productDetail(product))
                                } label: {
                                    HStack(spacing: 12) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: AppMetrics.cornerRadiusMedium, style: .continuous)
                                                .fill(Color.brandPinkTint)
                                            Image(systemName: product.imageSystemName)
                                                .font(.system(size: 24))
                                                .foregroundStyle(Color.brandPink)
                                        }
                                        .frame(width: 64, height: 64)

                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(product.name)
                                                .font(AppFont.body.weight(.semibold))
                                                .foregroundStyle(Color.brandTextPrimary)
                                            Text("$\(Int(product.price))")
                                                .font(AppFont.price)
                                                .foregroundStyle(Color.brandPink)
                                        }
                                        Spacer()
                                    }
                                }
                                .buttonStyle(.plain)
                                .accessibilityIdentifier("favorites_item_\(product.id)")

                                Button {
                                    favoritesStore.toggle(product)
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(.red)
                                        .frame(width: 36, height: 36)
                                        .background(Color.brandCardBackground)
                                        .clipShape(Circle())
                                }
                                .accessibilityIdentifier("favorites_remove_button_\(product.id)")
                            }
                            .cardStyle()
                        }
                    }
                    .padding(.horizontal, AppMetrics.paddingStandard)
                    .padding(.bottom, 24)
                }
            }
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("favorites_screen")
    }
}
