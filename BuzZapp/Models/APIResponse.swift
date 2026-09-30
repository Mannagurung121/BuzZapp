import Foundation

struct APIResponse: Codable {
    let restaurants: [Restaurant]
    let foodItems: [FoodItem]
    let orders: [Order]
    let festivals: [Festival]
    let categories: [Category]
    let users: [User]
}
