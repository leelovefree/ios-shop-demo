import SwiftUI

struct HomeView: View {
    @Environment(CartStore.self) private var cartStore
    @Environment(AuthStore.self) private var authStore
    @Binding var path: NavigationPath
    @State private var selectedCategory: String?

    private let columns = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    private var filteredProducts: [Product] {
        guard let selectedCategory else { return ProductCatalog.all }
        return ProductCatalog.all.filter { $0.category == selectedCategory }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppMetrics.spacingStandard) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Fashion Shop")
                            .font(AppFont.title)
                            .foregroundStyle(Color.brandTextPrimary)
                        Text("Discover the new collection")
                            .font(AppFont.caption)
                            .foregroundStyle(Color.brandTextSecondary)
                    }
                    Spacer()
                    Button {
                        authStore.logout()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundStyle(Color.brandTextPrimary)
                            .frame(width: 40, height: 40)
                            .background(Color.brandCardBackground)
                            .clipShape(Circle())
                    }
                    .accessibilityIdentifier("home_logout_button")

                    Button {
                        path.append(Route.cart)
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "bag.fill")
                                .foregroundStyle(Color.brandTextPrimary)
                                .frame(width: 40, height: 40)
                                .background(Color.brandCardBackground)
                                .clipShape(Circle())

                            if cartStore.totalItemCount > 0 {
                                Text("\(cartStore.totalItemCount)")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(.white)
                                    .frame(width: 16, height: 16)
                                    .background(Color.brandPink)
                                    .clipShape(Circle())
                                    .offset(x: 4, y: -4)
                                    .accessibilityIdentifier("home_cart_badge_label")
                            }
                        }
                    }
                    .accessibilityIdentifier("home_cart_button")
                }
                .padding(.horizontal, AppMetrics.paddingStandard)

                CategoryFilterBar(categories: ProductCatalog.categories, selectedCategory: $selectedCategory)

                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(filteredProducts) { product in
                        Button {
                            path.append(Route.productDetail(product))
                        } label: {
                            ProductGridItemView(product: product)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, AppMetrics.paddingStandard)
                .padding(.bottom, 24)
            }
            .padding(.top, 8)
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .accessibilityIdentifier("home_screen")
    }
}
