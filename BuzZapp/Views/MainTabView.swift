import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var cartViewModel: CartViewModel
    
    @State private var selectedTab = 0
    @State private var restaurants: [Restaurant] = []
    @State private var foodItems: [FoodItem] = []
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            HomeView()
                .tabItem {
                    Label(
                        "Home",
                        systemImage: "house.fill"
                    )
                }
                .tag(0)
            
            SearchView(
                restaurants: restaurants,
                foodItems: foodItems
            )
            .tabItem {
                Label(
                    "Search",
                    systemImage: "magnifyingglass"
                )
            }
            .tag(1)
            
            CartView(
                cartViewModel: cartViewModel
            )
            .tabItem {
                Label(
                    "Cart",
                    systemImage: "cart.fill"
                )
            }
            .tag(2)
            
            ProfileView(user: nil)
                .tabItem {
                    Label(
                        "Profile",
                        systemImage: "person.fill"
                    )
                }
                .tag(3)
        }
        .tint(.red)
        .onReceive(
            NotificationCenter.default.publisher(
                for: .openCart
            )
        ) { _ in
            selectedTab = 2
        }
        .task {
            await loadData()
        }
    }
    
    private func loadData() async {
        do {
            let data = try await APIService.shared.fetchData()
            
            restaurants = data.restaurants
            foodItems = data.foodItems
            
            print("Restaurants: \(restaurants.count)")
            print("Food items: \(foodItems.count)")
            
        } catch {
            print("Main data error: \(error)")
        }
    }
}

extension Notification.Name {
    static let openCart = Notification.Name("openCart")
}

#Preview {
    MainTabView()
        .environmentObject(CartViewModel())
}
