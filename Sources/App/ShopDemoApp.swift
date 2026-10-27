import SwiftUI

@main
struct ShopDemoApp: App {
    @State private var authStore = AuthStore()
    @State private var cartStore = CartStore()
    @State private var favoritesStore = FavoritesStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(authStore)
                .environment(cartStore)
                .environment(favoritesStore)
        }
    }
}
