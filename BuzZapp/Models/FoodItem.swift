import Foundation

struct FoodItem: Codable, Identifiable {
    let id: String
    let restaurantID: String
    let name: String
    let imageName: String
    let price: Int
    let rating: Double
    let reviewCount: Int
    let isVeg: Bool
    let category: String
    let foodTags: [String]
    let festivalTags: [String]
    let isAvailable: Bool
}
