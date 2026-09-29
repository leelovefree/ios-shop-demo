import Foundation

enum Route: Hashable {
    case productDetail(Product)
    case cart
    case checkout
    case orderConfirmed(orderId: String)
}
