import SwiftUI

struct MainTabView: View {

    @EnvironmentObject var cartViewModel: CartViewModel

    @State private var selectedTab = 0
    @State private var restaurants: [Restaurant] = []
    @State private var foodItems: [FoodItem] = []

    var body: some View {

        TabView(selection: $selectedTab) {

            // MARK: - Home

            HomeView()
                .tabItem {
                    Label(
                        "Home",
                        systemImage: "house.fill"
                    )
                }
                .tag(0)

            // MARK: - Search

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

            // MARK: - Cart

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

            // MARK: - Profile

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

            withAnimation {
                selectedTab = 2
            }
        }
        .task {
            await loadData()
        }
    }

    // MARK: - Load Data

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

// MARK: - Notifications

extension Notification.Name {

    static let openCart = Notification.Name("openCart")
}

// MARK: - Preview

#Preview("Light Mode") {

    MainTabView()
        .environmentObject(CartViewModel())
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {

    MainTabView()
        .environmentObject(CartViewModel())
        .preferredColorScheme(.dark)
}
