import Foundation

struct CartItem: Identifiable, Hashable {
    let id: String
    let product: Product
    let size: String
    let color: ProductColorOption
    var quantity: Int

    var lineTotal: Double { product.price * Double(quantity) }

    static func makeId(productId: String, size: String, colorName: String) -> String {
        "\(productId)-\(size)-\(colorName)".lowercased().replacingOccurrences(of: " ", with: "-")
    }
}
