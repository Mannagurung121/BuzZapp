import Foundation
import AppIntents
import SwiftData

struct ShowCartIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Show My Cart"
    
    static var description = IntentDescription(
        "Shows the items currently in your BuzZapp cart."
    )
    
    static var openAppWhenRun: Bool = true
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        
        let container = try ModelContainer(
            for: CartItemModel.self
        )
        
        let context = ModelContext(container)
        
        let cartItems = try context.fetch(
            FetchDescriptor<CartItemModel>()
        )
        
        if cartItems.isEmpty {
            
            await NotificationCenter.default.post(
                name: .openCart,
                object: nil
            )
            
            return .result(
                dialog: "Your cart is empty."
            )
        }
        
        // Get food details from API
        let data = try await APIService.shared.fetchData()
        
        var itemsText: [String] = []
        var totalAmount = 0
        
        for cartItem in cartItems {
            
            if let food = data.foodItems.first(where: {
                $0.id == cartItem.foodID
            }) {
                
                itemsText.append(
                    "\(cartItem.quantity) \(food.name)"
                )
                
                totalAmount += (
                    food.price * cartItem.quantity
                )
            }
        }
        
        await NotificationCenter.default.post(
            name: .openCart,
            object: nil
        )
        
        let totalItemCount = cartItems.reduce(0) {
            $0 + $1.quantity
        }

        let cartText = itemsText.joined(
            separator: " and "
        )

        return .result(
            dialog: "You have \(totalItemCount) items in your cart: \(cartText). Your total is \(totalAmount) rupees."
        )
    }
}
