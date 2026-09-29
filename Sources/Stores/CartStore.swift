import Foundation
import Observation

@Observable
final class CartStore {
    private(set) var items: [CartItem] = []

    let deliveryFee: Double = 5.00

    var subtotal: Double {
        items.reduce(0) { $0 + $1.lineTotal }
    }

    var total: Double {
        items.isEmpty ? 0 : subtotal + deliveryFee
    }

    var totalItemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    func add(product: Product, size: String, color: ProductColorOption, quantity: Int) {
        let id = CartItem.makeId(productId: product.id, size: size, colorName: color.name)
        if let index = items.firstIndex(where: { $0.id == id }) {
            items[index].quantity += quantity
        } else {
            items.append(CartItem(id: id, product: product, size: size, color: color, quantity: quantity))
        }
    }

    func updateQuantity(itemId: String, to quantity: Int) {
        guard let index = items.firstIndex(where: { $0.id == itemId }) else { return }
        if quantity <= 0 {
            items.remove(at: index)
        } else {
            items[index].quantity = quantity
        }
    }

    func remove(itemId: String) {
        items.removeAll { $0.id == itemId }
    }

    func clear() {
        items.removeAll()
    }
}
