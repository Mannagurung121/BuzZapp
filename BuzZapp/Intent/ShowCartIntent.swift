import Foundation
import AppIntents
import SwiftData

struct ShowCartIntent: AppIntent {

    static var title: LocalizedStringResource = "Show My Cart"

    static var description = IntentDescription(
        "Tells you the items and total in your BuzZapp cart."
    )

    static let supportedModes: IntentModes = [
        .background
    ]

    func perform() async throws -> some IntentResult & ProvidesDialog {

        let context = await ModelContext(
            CartPersistence.container
        )

        let cartItems = try context.fetch(
            FetchDescriptor<CartItemModel>()
        )

        if cartItems.isEmpty {
            return .result(
                dialog: "Your cart is empty."
            )
        }

        let data = try await APIService.shared.fetchData()

        let foodByID = Dictionary(
            uniqueKeysWithValues: data.foodItems.map {
                ($0.id, $0)
            }
        )

        var itemsText: [String] = []
        var totalAmount = 0
        var totalItemCount = 0

        for cartItem in cartItems {

            guard let food = foodByID[cartItem.foodID] else {
                continue
            }

            itemsText.append(
                "\(cartItem.quantity) \(food.name)"
            )

            totalAmount += food.price * cartItem.quantity
            totalItemCount += cartItem.quantity
        }

        if itemsText.isEmpty {
            return .result(
                dialog: "I couldn't find the food details for your cart."
            )
        }

        let cartText = itemsText.joined(
            separator: " and "
        )

        return .result(
            dialog: "You have \(totalItemCount) items in your cart: \(cartText). Your total is \(totalAmount) rupees."
        )
    }
}
