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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Order History")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadOrders()
        }
    }

    // MARK: - Load Orders

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

    // MARK: - Order Card

    private func orderCard(_ order: Order) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            // Order Header

            HStack {

                Image(systemName: "bag.fill")
                    .foregroundStyle(.red)

                Text("Order #\(order.id)")
                    .font(.headline)
                    .foregroundStyle(.primary)

                Spacer()

                Text(order.status.capitalized)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.green)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.green.opacity(0.10))
                    .clipShape(Capsule())
            }

            Divider()

            // Restaurant Name

            if let restaurant = restaurants.first(
                where: { $0.id == order.restaurantID }
            ) {

                HStack(spacing: 8) {

                    Image(systemName: "storefront.fill")
                        .foregroundStyle(.secondary)

                    Text(restaurant.name)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)
                }
            }

            // Ordered Items

            VStack(alignment: .leading, spacing: 10) {

                ForEach(order.items.indices, id: \.self) { index in

                    let item = order.items[index]

                    if let food = foodItems.first(
                        where: { $0.id == item.foodID }
                    ) {

                        HStack {

                            Text("\(item.quantity)x")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .frame(width: 30, alignment: .leading)

                            Text(food.name)
                                .font(.subheadline)
                                .foregroundStyle(.primary)

                            Spacer()

                            Text("₹\(food.price * item.quantity)")
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }

            Divider()

            // Total Amount

            HStack {

                Text("Total")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()

                Text("₹\(order.total)")
                    .font(.headline)
                    .foregroundStyle(.primary)
            }

            // Order Date and Rating

            HStack {

                Label(
                    order.createdAt,
                    systemImage: "calendar"
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                Spacer()

                HStack(spacing: 4) {

                    Image(systemName: "star.fill")

                    Text("\(order.userRating)")
                }
                .font(.caption.weight(.medium))
                .foregroundStyle(.orange)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color(uiColor: .secondarySystemBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .shadow(
            color: .black.opacity(0.06),
            radius: 8,
            y: 4
        )
    }

    // MARK: - Empty View

    private var emptyView: some View {

        VStack(spacing: 12) {

            Image(systemName: "bag")
                .font(.system(size: 50))
                .foregroundStyle(.secondary)

            Text("No orders yet")
                .font(.title3.bold())
                .foregroundStyle(.primary)

            Text("Your past orders will appear here.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.top, 100)
    }
}

// MARK: - Preview

#Preview("Order History - Light Mode") {

    NavigationStack {
        OrderHistoryView()
    }
    .preferredColorScheme(.light)
}

#Preview("Order History - Dark Mode") {

    NavigationStack {
        OrderHistoryView()
    }
    .preferredColorScheme(.dark)
}
