import SwiftUI

struct RestaurantDetailView: View {

    let restaurant: Restaurant
    let foodItems: [FoodItem]

    @ObservedObject var cartViewModel: CartViewModel
    @StateObject private var viewModel = RestaurantViewModel()

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 18) {

                restaurantHeader

                SearchBar()

                Text("Menu")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                    .padding(.horizontal)

                if viewModel.filteredFoodItems.isEmpty {

                    emptyMenuView

                } else {

                    ForEach(viewModel.filteredFoodItems) { food in

                        FoodCard(
                            food: food,
                            quantity: cartViewModel.quantity(for: food),
                            onAdd: {
                                cartViewModel.addItem(food)
                            },
                            onRemove: {
                                cartViewModel.removeItem(food)
                            }
                        )
                    }
                }
            }
            .padding(.vertical)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle(restaurant.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {

            viewModel.loadRestaurant(
                restaurant: restaurant,
                allFoodItems: foodItems
            )
        }
        .safeAreaInset(edge: .bottom) {

            if cartViewModel.totalItems > 0 {
                cartButton
            }
        }
    }

    // MARK: - Restaurant Header

    private var restaurantHeader: some View {

        VStack(alignment: .leading, spacing: 12) {

            Image(
                LocalImageService.restaurantImage(
                    for: restaurant
                )
            )
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .clipped()
            .clipShape(
                RoundedRectangle(cornerRadius: 22)
            )
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {

                Text(restaurant.name)
                    .font(.title.bold())
                    .foregroundStyle(.primary)

                Text(
                    restaurant.cuisine.joined(separator: " • ")
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)

                HStack(spacing: 12) {

                    Label(
                        String(
                            format: "%.1f",
                            restaurant.rating
                        ),
                        systemImage: "star.fill"
                    )
                    .foregroundStyle(.orange)

                    Text("•")
                        .foregroundStyle(.secondary)

                    Text("\(restaurant.deliveryTime) min")
                        .foregroundStyle(.secondary)

                    Text("•")
                        .foregroundStyle(.secondary)

                    Text(
                        "\(restaurant.distance, specifier: "%.1f") km"
                    )
                    .foregroundStyle(.secondary)
                }
                .font(.subheadline)
            }
            .padding(.horizontal)
        }
    }

    // MARK: - Empty Menu

    private var emptyMenuView: some View {

        VStack(spacing: 10) {

            Image(systemName: "fork.knife")
                .font(.system(size: 35))
                .foregroundStyle(.secondary)

            Text("No menu items found")
                .font(.headline)
                .foregroundStyle(.primary)

            Text("Try searching for another food item.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }

    // MARK: - Cart Button

    private var cartButton: some View {

        HStack {

            VStack(alignment: .leading, spacing: 3) {

                Text("\(cartViewModel.totalItems) items")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("₹\(cartViewModel.totalAmount)")
                    .font(.headline)
                    .foregroundStyle(.primary)
            }

            Spacer()

            NavigationLink {

                CartView(
                    cartViewModel: cartViewModel
                )

            } label: {

                HStack(spacing: 8) {

                    Text("View Cart")

                    Image(systemName: "arrow.right")
                }
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.red)
                .clipShape(Capsule())
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            Color(uiColor: .secondarySystemBackground)
        )
        .overlay(alignment: .top) {

            Rectangle()
                .fill(
                    Color(uiColor: .separator).opacity(0.25)
                )
                .frame(height: 0.5)
        }
        .shadow(
            color: .black.opacity(0.08),
            radius: 10,
            y: -4
        )
    }
}

// MARK: - Preview

#Preview("Restaurant Detail - Light Mode") {

    NavigationStack {

        RestaurantDetailView(
            restaurant: Restaurant(
                id: "1",
                name: "BuzZapp Kitchen",
                imageName: "",
                cuisine: [
                    "North Indian",
                    "Chinese"
                ],
                rating: 4.5,
                reviewCount: 1200,
                distance: 2.4,
                deliveryTime: 30,
                priceForTwo: 400,
                isPureVeg: false,
                popularity: 90,
                latitude: 29.22,
                longitude: 79.52,
                festivalTags: ["baisakhi"],
                menuItemIDs: [],
                available: true
            ),
            foodItems: [],
            cartViewModel: CartViewModel()
        )
    }
    .preferredColorScheme(.light)
}

#Preview("Restaurant Detail - Dark Mode") {

    NavigationStack {

        RestaurantDetailView(
            restaurant: Restaurant(
                id: "1",
                name: "BuzZapp Kitchen",
                imageName: "",
                cuisine: [
                    "North Indian",
                    "Chinese"
                ],
                rating: 4.5,
                reviewCount: 1200,
                distance: 2.4,
                deliveryTime: 30,
                priceForTwo: 400,
                isPureVeg: false,
                popularity: 90,
                latitude: 29.22,
                longitude: 79.52,
                festivalTags: ["baisakhi"],
                menuItemIDs: [],
                available: true
            ),
            foodItems: [],
            cartViewModel: CartViewModel()
        )
    }
    .preferredColorScheme(.dark)
}
