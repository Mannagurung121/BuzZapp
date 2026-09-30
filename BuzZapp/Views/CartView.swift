import SwiftUI

struct CartView: View {
    
    @ObservedObject var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if cartViewModel.items.isEmpty {
                    emptyCart
                } else {
                    cartItems
                }
            }
            .navigationTitle("Your Cart")
            .safeAreaInset(edge: .bottom) {
                if !cartViewModel.items.isEmpty {
                    checkoutSection
                }
            }
        }
    }
    
    // MARK: - Cart Items
    
    private var cartItems: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                
                ForEach(cartViewModel.items) { item in
                    cartItem(item)
                }
            }
            .padding(.vertical)
        }
    }
    
    private func cartItem(_ item: FoodItem) -> some View {
        HStack(spacing: 12) {
            
            // MARK: - Local Image
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(item.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text("₹\(item.price)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 14) {
                    
                    Button {
                        cartViewModel.removeItem(item)
                    } label: {
                        Image(systemName: "minus")
                    }
                    
                    Text(
                        "\(cartViewModel.quantity(for: item))"
                    )
                    .font(.subheadline.bold())
                    
                    Button {
                        cartViewModel.addItem(item)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .foregroundStyle(.red)
            }
            
            Spacer()
            
            Text(
                "₹\(item.price * cartViewModel.quantity(for: item))"
            )
            .font(.headline)
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .shadow(
            color: .black.opacity(0.06),
            radius: 8,
            y: 4
        )
        .padding(.horizontal)
    }
    
    // MARK: - Checkout
    
    private var checkoutSection: some View {
        VStack(spacing: 12) {
            
            HStack {
                Text("Total")
                    .font(.headline)
                
                Spacer()
                
                Text("₹\(cartViewModel.totalAmount)")
                    .font(.title3.bold())
            }
            
            NavigationLink {
                CheckoutView(
                    cartViewModel: cartViewModel
                )
            } label: {
                Text("Proceed to Checkout")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(.red)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 15)
                    )
            }
        }
        .padding()
        .background(.white)
        .shadow(
            color: .black.opacity(0.12),
            radius: 10,
            y: -4
        )
    }
    
    // MARK: - Empty Cart
    
    private var emptyCart: some View {
        VStack(spacing: 14) {
            
            Image(systemName: "cart")
                .font(.system(size: 60))
                .foregroundStyle(.red)
            
            Text("Your cart is empty")
                .font(.title2.bold())
            
            Text("Add something delicious to get started 🍕")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .padding()
    }
}

#Preview {
    CartView(
        cartViewModel: CartViewModel()
    )
}
