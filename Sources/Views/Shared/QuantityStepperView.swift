import SwiftUI

struct QuantityStepperView: View {
    let decrementId: String
    let valueId: String
    let incrementId: String
    @Binding var quantity: Int
    var minimum: Int = 1

    var body: some View {
        HStack(spacing: 14) {
            Button {
                if quantity > minimum { quantity -= 1 }
            } label: {
                Image(systemName: "minus")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.brandTextPrimary)
                    .frame(width: 30, height: 30)
                    .background(Color.brandCardBackground)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.brandBorder, lineWidth: 1))
            }
            .accessibilityIdentifier(decrementId)

            Text(String(format: "%02d", quantity))
                .font(AppFont.headline)
                .foregroundStyle(Color.brandTextPrimary)
                .frame(minWidth: 24)
                .accessibilityIdentifier(valueId)

            Button {
                quantity += 1
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
                    .background(Color.brandPink)
                    .clipShape(Circle())
            }
            .accessibilityIdentifier(incrementId)
        }
    }
}
