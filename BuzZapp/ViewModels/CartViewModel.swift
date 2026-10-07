import Foundation
import Combine
import SwiftData

@MainActor
final class CartViewModel: ObservableObject {
    
    @Published var items: [FoodItem] = []
    @Published var quantities: [String: Int] = [:]
    
    private var context: ModelContext?
    
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
    
    // MARK: - Setup
    
    func setup(context: ModelContext) {
        self.context = context
        print("SwiftData context setup")
    }
    
    // MARK: - Load Cart
    
    func loadCart(foodItems: [FoodItem]) {
        
        guard let context else {
            print("No SwiftData context")
            return
        }
        
        do {
            let savedItems = try context.fetch(
                FetchDescriptor<CartItemModel>()
            )
            
            items.removeAll()
            quantities.removeAll()
            
            for savedItem in savedItems {
                
                if let food = foodItems.first(where: {
                    $0.id == savedItem.foodID
                }) {
                    items.append(food)
                    quantities[food.id] = savedItem.quantity
                }
            }
            
            print("Cart loaded: \(savedItems.count)")
            
        } catch {
            print("Cart load error:", error)
        }
    }
    
    // MARK: - Add Item
    
    func addItem(_ item: FoodItem) {
        
        print("Adding item: \(item.name)")
        
        guard let context else {
            print("No SwiftData context")
            return
        }
        
        if quantities[item.id] == nil {
            
            items.append(item)
            quantities[item.id] = 1
            
            let cartItem = CartItemModel(
                foodID: item.id,
                quantity: 1
            )
            
            context.insert(cartItem)
            
            print("Inserted:", item.name)
            
        } else {
            
            quantities[item.id, default: 0] += 1
            
            updateSavedQuantity(
                foodID: item.id,
                quantity: quantities[item.id] ?? 0
            )
        }
        
        saveContext()
    }
    
    // MARK: - Remove Item
    
    func removeItem(_ item: FoodItem) {
        
        guard let quantity = quantities[item.id] else {
            return
        }
        
        if quantity > 1 {
            
            quantities[item.id] = quantity - 1
            
            updateSavedQuantity(
                foodID: item.id,
                quantity: quantity - 1
            )
            
        } else {
            
            quantities[item.id] = nil
            
            items.removeAll {
                $0.id == item.id
            }
            
            deleteSavedItem(
                foodID: item.id
            )
        }
        
        saveContext()
    }
    
    // MARK: - Quantity
    
    func quantity(for item: FoodItem) -> Int {
        quantities[item.id] ?? 0
    }
    
    // MARK: - Clear Cart
    
    func clearCart() {
        
        items.removeAll()
        quantities.removeAll()
        
        guard let context else {
            return
        }
        
        do {
            let savedItems = try context.fetch(
                FetchDescriptor<CartItemModel>()
            )
            
            for item in savedItems {
                context.delete(item)
            }
            
            try context.save()
            
            print("Cart cleared")
            
        } catch {
            print("Clear cart error:", error)
        }
    }
    
    // MARK: - Update Quantity
    
    private func updateSavedQuantity(
        foodID: String,
        quantity: Int
    ) {
        
        guard let context else {
            return
        }
        
        do {
            let savedItems = try context.fetch(
                FetchDescriptor<CartItemModel>()
            )
            
            if let savedItem = savedItems.first(where: {
                $0.foodID == foodID
            }) {
                savedItem.quantity = quantity
            }
            
        } catch {
            print("Cart update error:", error)
        }
    }
    
    // MARK: - Delete Item
    
    private func deleteSavedItem(
        foodID: String
    ) {
        
        guard let context else {
            return
        }
        
        do {
            let savedItems = try context.fetch(
                FetchDescriptor<CartItemModel>()
            )
            
            if let savedItem = savedItems.first(where: {
                $0.foodID == foodID
            }) {
                context.delete(savedItem)
            }
            
        } catch {
            print("Cart delete error:", error)
        }
    }
    
    // MARK: - Save
    
    private func saveContext() {
        
        guard let context else {
            print("No SwiftData context")
            return
        }
        
        do {
            try context.save()
            
            let savedItems = try context.fetch(
                FetchDescriptor<CartItemModel>()
            )
            
            print("Cart saved:", savedItems.count)
            
        } catch {
            print("Cart save error:", error)
        }
    }
}
