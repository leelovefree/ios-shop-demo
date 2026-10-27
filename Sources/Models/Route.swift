import Foundation

enum Route: Hashable {
    case productDetail(Product)
    case cart
    case favorites
    case checkout
    case orderConfirmed(orderId: String)
}
