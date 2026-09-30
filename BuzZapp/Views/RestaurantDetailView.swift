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
                    .padding(.horizontal)
                
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
            .padding(.vertical)
        }
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
    
    private var restaurantHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Image(LocalImageService.restaurantImage(for: restaurant))
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .clipShape(
                    RoundedRectangle(cornerRadius: 22)
                )
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(restaurant.name)
                    .font(.title.bold())
                
                Text(restaurant.cuisine.joined(separator: " • "))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 12) {
                    Label(
                        String(format: "%.1f", restaurant.rating),
                        systemImage: "star.fill"
                    )
                    
                    Text("•")
                    
                    Text("\(restaurant.deliveryTime) min")
                    
                    Text("•")
                    
                    Text(
                        "\(restaurant.distance, specifier: "%.1f") km"
                    )
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
        }
    }
    
    private var cartButton: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("\(cartViewModel.totalItems) items")
                    .font(.caption)
                
                Text("₹\(cartViewModel.totalAmount)")
                    .font(.headline)
            }
            
            Spacer()
            
            NavigationLink {
                CartView(cartViewModel: cartViewModel)
            } label: {
                Text("View Cart")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(.red)
                    .clipShape(Capsule())
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
}

#Preview {
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
