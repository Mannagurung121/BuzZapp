import SwiftUI

struct OrderHistoryView: View {
    
    @State private var orders: [Order] = []
    @State private var restaurants: [Restaurant] = []
    @State private var foodItems: [FoodItem] = []
    @State private var isLoading = false
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView()
                    .padding(.top, 40)
            } else if orders.isEmpty {
                emptyView
            } else {
                LazyVStack(spacing: 14) {
                    ForEach(orders) { order in
                        orderCard(order)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Order History")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadOrders()
        }
    }
    
    private func loadOrders() async {
        isLoading = true
        
        do {
            let data = try await APIService.shared.fetchData()
            
            orders = data.orders
            restaurants = data.restaurants
            foodItems = data.foodItems
            
            print("Orders loaded: \(orders.count)")
        } catch {
            print("Order history error: \(error)")
        }
        
        isLoading = false
    }
    
    private func orderCard(_ order: Order) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Image(systemName: "bag.fill")
                    .foregroundStyle(.red)
                
                Text("Order #\(order.id)")
                    .font(.headline)
                
                Spacer()
                
                Text(order.status.capitalized)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.green)
            }
            
            Divider()
            
            if let restaurant = restaurants.first(
                where: { $0.id == order.restaurantID }
            ) {
                Text(restaurant.name)
                    .font(.subheadline.weight(.semibold))
            }
            
            VStack(alignment: .leading, spacing: 6) {
                ForEach(order.items.indices, id: \.self) { index in
                    let item = order.items[index]
                    
                    if let food = foodItems.first(
                        where: { $0.id == item.foodID }
                    ) {
                        HStack {
                            Text("\(item.quantity)x")
                                .foregroundStyle(.secondary)
                            
                            Text(food.name)
                            
                            Spacer()
                            
                            Text("₹\(food.price * item.quantity)")
                                .font(.subheadline.weight(.medium))
                        }
                    }
                }
            }
            
            Divider()
            
            HStack {
                Text("Total")
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text("₹\(order.total)")
                    .font(.headline)
            }
            
            HStack {
                Text(order.createdAt)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                    Text("\(order.userRating)")
                }
                .font(.caption)
                .foregroundStyle(.orange)
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(
            color: .black.opacity(0.06),
            radius: 8,
            y: 4
        )
    }
    
    private var emptyView: some View {
        VStack(spacing: 12) {
            Image(systemName: "bag")
                .font(.system(size: 50))
                .foregroundStyle(.secondary)
            
            Text("No orders yet")
                .font(.title3.bold())
            
            Text("Your past orders will appear here.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 100)
    }
}

#Preview {
    NavigationStack {
        OrderHistoryView()
    }
}
