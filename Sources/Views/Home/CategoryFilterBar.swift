import SwiftUI

struct CategoryFilterBar: View {
    let categories: [String]
    @Binding var selectedCategory: String?

    private func slug(_ category: String) -> String {
        category.lowercased().replacingOccurrences(of: " ", with: "_")
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                Button("All") {
                    selectedCategory = nil
                }
                .buttonStyle(SelectablePillButtonStyle(isSelected: selectedCategory == nil))
                .accessibilityIdentifier("home_category_chip_all")

                ForEach(categories, id: \.self) { category in
                    Button(category) {
                        selectedCategory = category
                    }
                    .buttonStyle(SelectablePillButtonStyle(isSelected: selectedCategory == category))
                    .accessibilityIdentifier("home_category_chip_\(slug(category))")
                }
            }
            .padding(.horizontal, AppMetrics.paddingStandard)
        }
    }
}
