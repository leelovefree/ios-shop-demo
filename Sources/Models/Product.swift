import Foundation

struct ProductColorOption: Identifiable, Hashable {
    var id: String { name }
    let name: String
    let hex: String
}

struct Product: Identifiable, Hashable {
    let id: String
    let name: String
    let category: String
    let price: Double
    let imageSystemName: String
    let description: String
    let sizes: [String]
    let colors: [ProductColorOption]

    var accessibilitySlug: String { id }
}
