import Foundation

struct Order: Codable, Identifiable {
    let id: String
    let restaurantID: String
    let createdAt: String
    let items: [OrderItem]
    let total: Int
    let userRating: Int
    let status: String
}

struct OrderItem: Codable {
    let foodID: String
    let quantity: Int
}
