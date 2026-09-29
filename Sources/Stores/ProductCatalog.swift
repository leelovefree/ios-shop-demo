import Foundation

enum ProductCatalog {
    static let categories: [String] = [
        "Women Fashion", "Men Fashion", "Kids Fashion", "Boys World", "Accessories",
    ]

    static let all: [Product] = [
        Product(
            id: "defile-lux-blazer",
            name: "Defile Lux Blazer",
            category: "Women Fashion",
            price: 300,
            imageSystemName: "tshirt.fill",
            description: "Elevate your style with the Defile Lux Blazer, crafted from premium fabrics for a sleek, tailored fit. Perfect for both formal and casual looks, this blazer combines timeless elegance with modern comfort.",
            sizes: ["S", "M", "L", "XL"],
            colors: [
                ProductColorOption(name: "Beige", hex: "#D8B48C"),
                ProductColorOption(name: "Red", hex: "#B5192A"),
                ProductColorOption(name: "Pink", hex: "#F5A9C4"),
            ]
        ),
        Product(
            id: "neck-short-sleeves",
            name: "Neck Short Sleeves",
            category: "Women Fashion",
            price: 120,
            imageSystemName: "tshirt.fill",
            description: "A breathable, soft-knit top with a flattering neckline, designed for everyday wear. Pairs easily with skirts, jeans, or tailored trousers.",
            sizes: ["S", "M", "L", "XL"],
            colors: [
                ProductColorOption(name: "Blue", hex: "#3D5A80"),
                ProductColorOption(name: "Black", hex: "#1A1A1A"),
                ProductColorOption(name: "White", hex: "#F2F2F2"),
            ]
        ),
        Product(
            id: "magnolia-pink-dress",
            name: "Magnolia Pink Dress",
            category: "Women Fashion",
            price: 150,
            imageSystemName: "tshirt.fill",
            description: "A flowing magnolia-pink dress with a flattering silhouette, ideal for garden parties and warm-weather occasions.",
            sizes: ["S", "M", "L"],
            colors: [
                ProductColorOption(name: "Pink", hex: "#F72585"),
                ProductColorOption(name: "Beige", hex: "#D8B48C"),
                ProductColorOption(name: "Red", hex: "#B5192A"),
            ]
        ),
        Product(
            id: "knit-bow-back-top",
            name: "Knit Bow Back Top",
            category: "Kids Fashion",
            price: 70,
            imageSystemName: "tshirt",
            description: "A cozy knit top with a playful bow detail on the back, made from soft, kid-friendly fabric that's easy to care for.",
            sizes: ["XS", "S", "M"],
            colors: [
                ProductColorOption(name: "Navy", hex: "#1D3557"),
                ProductColorOption(name: "Pink", hex: "#F5A9C4"),
                ProductColorOption(name: "White", hex: "#F2F2F2"),
            ]
        ),
        Product(
            id: "training-shoes",
            name: "Training Shoes",
            category: "Boys World",
            price: 300,
            imageSystemName: "shoeprints.fill",
            description: "Durable, high-grip training shoes built for active play, with cushioned soles for all-day comfort.",
            sizes: ["38", "39", "40", "41", "42"],
            colors: [
                ProductColorOption(name: "Teal", hex: "#2A9D8F"),
                ProductColorOption(name: "Black", hex: "#1A1A1A"),
                ProductColorOption(name: "Red", hex: "#B5192A"),
            ]
        ),
        Product(
            id: "classic-denim-jacket",
            name: "Classic Denim Jacket",
            category: "Men Fashion",
            price: 180,
            imageSystemName: "tshirt.fill",
            description: "A timeless denim jacket with a relaxed fit and reinforced stitching, built to layer over any outfit.",
            sizes: ["S", "M", "L", "XL"],
            colors: [
                ProductColorOption(name: "Denim Blue", hex: "#3D5A80"),
                ProductColorOption(name: "Black", hex: "#1A1A1A"),
                ProductColorOption(name: "Beige", hex: "#D8B48C"),
            ]
        ),
        Product(
            id: "leather-sneakers",
            name: "Leather Sneakers",
            category: "Men Fashion",
            price: 220,
            imageSystemName: "shoeprints.fill",
            description: "Premium leather sneakers with a minimalist design, engineered for comfort and everyday versatility.",
            sizes: ["40", "41", "42", "43"],
            colors: [
                ProductColorOption(name: "White", hex: "#F2F2F2"),
                ProductColorOption(name: "Black", hex: "#1A1A1A"),
                ProductColorOption(name: "Beige", hex: "#D8B48C"),
            ]
        ),
        Product(
            id: "sunset-sunglasses",
            name: "Sunset Sunglasses",
            category: "Accessories",
            price: 45,
            imageSystemName: "eyeglasses",
            description: "Retro-inspired sunglasses with UV-protected lenses and a lightweight frame for all-day wear.",
            sizes: ["One Size"],
            colors: [
                ProductColorOption(name: "Pink", hex: "#F72585"),
                ProductColorOption(name: "Black", hex: "#1A1A1A"),
                ProductColorOption(name: "Beige", hex: "#D8B48C"),
            ]
        ),
    ]

    static func product(withId id: String) -> Product? {
        all.first { $0.id == id }
    }
}
