import Foundation

struct Restaurant: Codable, Identifiable {
    let id: String
    let name: String
    let imageName: String
    let cuisine: [String]
    let rating: Double
    let reviewCount: Int
    let distance: Double
    let deliveryTime: Int
    let priceForTwo: Int
    let isPureVeg: Bool
    let popularity: Int
    let latitude: Double
    let longitude: Double
    let festivalTags: [String]
    let menuItemIDs: [String]
    let available: Bool
}
