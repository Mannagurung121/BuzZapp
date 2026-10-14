import SwiftUI

struct CheckoutView: View {

    @ObservedObject var cartViewModel: CartViewModel

    var body: some View {
        VStack(spacing: 20) {

            Text("Order Summary")
                .font(.title2.bold())
                .foregroundStyle(.primary)

            Text("\(cartViewModel.totalItems) items")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text("Total: ₹\(cartViewModel.totalAmount)")
                .font(.title3.bold())
                .foregroundStyle(.primary)

            Button {
                // Place order later
            } label: {
                Text("Place Order")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(.red)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 15)
                    )
            }
            .disabled(cartViewModel.items.isEmpty)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemBackground))
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("Light Mode") {
    NavigationStack {
        CheckoutView(
            cartViewModel: CartViewModel()
        )
    }
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    NavigationStack {
        CheckoutView(
            cartViewModel: CartViewModel()
        )
    }
    .preferredColorScheme(.dark)
}
