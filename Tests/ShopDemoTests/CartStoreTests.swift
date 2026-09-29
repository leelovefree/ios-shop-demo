import Testing
@testable import ShopDemo

struct CartStoreTests {
    @Test func addingSameVariantMergesQuantity() {
        let store = CartStore()
        let product = ProductCatalog.all[0]
        let color = product.colors[0]

        store.add(product: product, size: product.sizes[0], color: color, quantity: 1)
        store.add(product: product, size: product.sizes[0], color: color, quantity: 2)

        #expect(store.items.count == 1)
        #expect(store.items[0].quantity == 3)
    }

    @Test func totalsIncludeDeliveryFeeOnlyWhenNotEmpty() {
        let store = CartStore()
        #expect(store.total == 0)

        let product = ProductCatalog.all[0]
        store.add(product: product, size: product.sizes[0], color: product.colors[0], quantity: 1)

        #expect(store.subtotal == product.price)
        #expect(store.total == product.price + store.deliveryFee)
    }

    @Test func removingAnItemDropsItFromCart() {
        let store = CartStore()
        let product = ProductCatalog.all[0]
        store.add(product: product, size: product.sizes[0], color: product.colors[0], quantity: 1)
        let itemId = store.items[0].id

        store.remove(itemId: itemId)

        #expect(store.items.isEmpty)
    }
}
