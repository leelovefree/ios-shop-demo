import SwiftUI

enum ProductSortOption: String, CaseIterable, Identifiable {
    case standard = "default"
    case priceAscending = "price-asc"
    case priceDescending = "price-desc"
    case nameAscending = "name-asc"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .standard: "Default"
        case .priceAscending: "Price: Low to High"
        case .priceDescending: "Price: High to Low"
        case .nameAscending: "Name: A-Z"
        }
    }
}

struct HomeView: View {
    @Environment(CartStore.self) private var cartStore
    @Environment(AuthStore.self) private var authStore
    @Binding var path: NavigationPath
    @State private var selectedCategory: String?
    @State private var searchText = ""
    @State private var sortOption: ProductSortOption = .standard

    private let columns = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    private var filteredProducts: [Product] {
        var products = ProductCatalog.all
        if let selectedCategory {
            products = products.filter { $0.category == selectedCategory }
        }
        let query = searchText.trimmingCharacters(in: .whitespaces)
        if !query.isEmpty {
            products = products.filter { $0.name.localizedCaseInsensitiveContains(query) }
        }
        switch sortOption {
        case .standard: break
        case .priceAscending: products.sort { $0.price < $1.price }
        case .priceDescending: products.sort { $0.price > $1.price }
        case .nameAscending: products.sort { $0.name < $1.name }
        }
        return products
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

                HStack(spacing: 10) {
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.brandTextSecondary)
                        TextField("Search products", text: $searchText)
                            .font(AppFont.body)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .accessibilityIdentifier("home_search_field")
                    }
                    .padding(.horizontal, 12)
                    .frame(height: 40)
                    .background(Color.brandCardBackground)
                    .clipShape(Capsule())

                    Menu {
                        ForEach(ProductSortOption.allCases) { option in
                            Button {
                                sortOption = option
                            } label: {
                                if option == sortOption {
                                    Label(option.title, systemImage: "checkmark")
                                } else {
                                    Text(option.title)
                                }
                            }
                            .accessibilityIdentifier("home_sort_option_\(option.rawValue)")
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundStyle(Color.brandTextPrimary)
                            .frame(width: 40, height: 40)
                            .background(Color.brandCardBackground)
                            .clipShape(Circle())
                    }
                    .accessibilityIdentifier("home_sort_button")
                }
                .padding(.horizontal, AppMetrics.paddingStandard)

                CategoryFilterBar(categories: ProductCatalog.categories, selectedCategory: $selectedCategory)

                if filteredProducts.isEmpty {
                    Text("No products found")
                        .font(AppFont.body)
                        .foregroundStyle(Color.brandTextSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 40)
                        .accessibilityIdentifier("home_empty_state_label")
                }

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
