import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var cartViewModel: CartViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Order Summary")
                .font(.title2.bold())
            
            Text("\(cartViewModel.totalItems) items")
                .foregroundStyle(.secondary)
            
            Text("Total: ₹\(cartViewModel.totalAmount)")
                .font(.title3.bold())
            
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
            
            Spacer()
        }
        .padding()
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CheckoutView(
        cartViewModel: CartViewModel()
    )
}
