import Foundation
import Observation

@Observable
final class FavoritesStore {
    private(set) var productIds: Set<String> = []

    var products: [Product] {
        ProductCatalog.all.filter { productIds.contains($0.id) }
    }

    func isFavorite(_ product: Product) -> Bool {
        productIds.contains(product.id)
    }

    func toggle(_ product: Product) {
        if productIds.contains(product.id) {
            productIds.remove(product.id)
        } else {
            productIds.insert(product.id)
        }
    }
}
