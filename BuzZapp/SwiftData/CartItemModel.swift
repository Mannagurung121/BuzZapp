import Foundation
import SwiftData

@Model
final class CartItemModel {
    
    var foodID: String
    var quantity: Int
    
    init(
        foodID: String,
        quantity: Int
    ) {
        self.foodID = foodID
        self.quantity = quantity
    }
}
