import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var restaurants: [Restaurant] = []
    @Published var recommendedRestaurants: [Restaurant] = []
    @Published var foodItems: [FoodItem] = []
    @Published var categories: [Category] = []
    
    @Published var festival: Festival?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService = APIService.shared
    private let festivalService = FestivalService()
    private let recommendationService = RecommendationService()
    
    func loadHomeData() async {
        
        isLoading = true
        errorMessage = nil
        
        do {
            let data = try await apiService.fetchData()
            
            restaurants = data.restaurants
            foodItems = data.foodItems
            categories = data.categories
            
            print("Restaurants loaded: \(restaurants.count)")
            
            let festivalName = try await festivalService.getTodayFestival()
            
            festival = nil
            
            if let festivalName = festivalName {
                
                festival = data.festivals.first {
                    $0.name.localizedCaseInsensitiveCompare(
                        festivalName
                    ) == .orderedSame
                }
                
                if let festival = festival {
                    print("Festival found: \(festival.name)")
                } else {
                    print("Festival not found in BuzZapp data")
                }
            }
            
            getRecommendations()
            
            print("Recommended restaurants: \(recommendedRestaurants.count)")
            
        } catch {
            print("Home error: \(error)")
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func getRecommendations() {
        
        let availableRestaurants = restaurants.filter {
            $0.available
        }
        
        var filteredRestaurants = availableRestaurants
        
        if let festival = festival {
            
            filteredRestaurants = availableRestaurants.filter { restaurant in
                
                restaurant.festivalTags.contains { tag in
                    tag.localizedCaseInsensitiveCompare(
                        festival.name
                    ) == .orderedSame
                }
            }
            
            print(
                "\(festival.name) restaurants: \(filteredRestaurants.count)"
            )
        }
        
        let sortedRestaurants = filteredRestaurants.sorted {
            
            let firstScore = recommendationService.calculateScore(
                restaurant: $0,
                festival: festival
            )
            
            let secondScore = recommendationService.calculateScore(
                restaurant: $1,
                festival: festival
            )
            
            return firstScore > secondScore
        }
        
        recommendedRestaurants = Array(
            sortedRestaurants.prefix(5)
        )
    }
}
