import Foundation
import Combine
@MainActor
final class CartViewModel: ObservableObject {
    
    @Published var items: [FoodItem] = []
    @Published var quantities: [String: Int] = [:]
    
    var totalAmount: Int {
        var total = 0
        
        for item in items {
            let quantity = quantities[item.id] ?? 0
            total += item.price * quantity
        }
        
        return total
    }
    
    var totalItems: Int {
        quantities.values.reduce(0, +)
    }
    
    func addItem(_ item: FoodItem) {
        
        if quantities[item.id] == nil {
            items.append(item)
            quantities[item.id] = 1
        } else {
            quantities[item.id, default: 0] += 1
        }
    }
    
    func removeItem(_ item: FoodItem) {
        
        guard let quantity = quantities[item.id] else {
            return
        }
        
        if quantity > 1 {
            quantities[item.id] = quantity - 1
        } else {
            quantities[item.id] = nil
            items.removeAll { $0.id == item.id }
        }
    }
    
    func quantity(for item: FoodItem) -> Int {
        quantities[item.id] ?? 0
    }
    
    func clearCart() {
        items.removeAll()
        quantities.removeAll()
    }
}
