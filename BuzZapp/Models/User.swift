import Foundation

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let location: String
    let favoriteCuisines: [String]
    let preferredPriceRange: PriceRange
    let orderHistoryIDs: [String]
}

struct PriceRange: Codable {
    let min: Int
    let max: Int
}
