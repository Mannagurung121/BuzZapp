import Foundation
import Combine
@MainActor
final class RestaurantViewModel: ObservableObject {
    
    @Published var restaurant: Restaurant?
    @Published var foodItems: [FoodItem] = []
    @Published var searchText = ""
    
    var filteredFoodItems: [FoodItem] {
        
        if searchText.isEmpty {
            return foodItems
        }
        
        return foodItems.filter { item in
            item.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func loadRestaurant(
        restaurant: Restaurant,
        allFoodItems: [FoodItem]
    ) {
        self.restaurant = restaurant
        
        foodItems = allFoodItems.filter { item in
            item.restaurantID == restaurant.id &&
            item.isAvailable
        }
    }
}
