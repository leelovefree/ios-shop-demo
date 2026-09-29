import SwiftUI

struct RootView: View {
    @Environment(AuthStore.self) private var authStore
    @State private var path = NavigationPath()

    var body: some View {
        if authStore.isLoggedIn {
            NavigationStack(path: $path) {
                HomeView(path: $path)
                    .navigationDestination(for: Route.self) { route in
                        destination(for: route)
                    }
            }
        } else {
            LoginView()
        }
    }

    @ViewBuilder
    private func destination(for route: Route) -> some View {
        switch route {
        case .productDetail(let product):
            ProductDetailView(product: product, path: $path)
        case .cart:
            CartView(path: $path)
        case .checkout:
            CheckoutView(path: $path)
        case .orderConfirmed(let orderId):
            OrderConfirmedView(orderId: orderId, path: $path)
        }
    }
}
