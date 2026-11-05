import Foundation
import AppIntents
import SwiftData

struct AddFoodToCartIntent: AppIntent {

    static var title: LocalizedStringResource = "Add Food to Cart"

    static var description = IntentDescription(
        "Add food to your BuzZapp cart."
    )

    @Parameter(title: "Food Name")
    var foodName: String

    @Parameter(title: "Quantity", default: 1)
    var quantity: Int

    func perform() async throws -> some IntentResult & ProvidesDialog {

        // Check quantity

        guard quantity > 0 else {
            return .result(
                dialog: "Please enter a valid quantity."
            )
        }

        // Fetch food items direct api

        let data = try await APIService.shared.fetchData()

     

        let searchText = foodName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard let food = data.foodItems.first(where: {
            $0.name.localizedCaseInsensitiveContains(searchText)
                && $0.isAvailable
        }) else {

            return .result(
                dialog: "\(foodName) is not available."
            )
        }

        // Addding o cart

        do {

            try await MainActor.run {

                let context = ModelContext(
                    CartPersistence.container
                )

                let cartItems = try context.fetch(
                    FetchDescriptor<CartItemModel>()
                )

                if let existingItem = cartItems.first(where: {
                    $0.foodID == food.id
                }) {

                    existingItem.quantity += quantity

                } else {

                    let newItem = CartItemModel(
                        foodID: food.id,
                        quantity: quantity
                    )

                    context.insert(newItem)
                }

                try context.save()
            }

            return .result(
                dialog: "\(quantity) \(food.name) added to your cart."
            )

        } catch {

            return .result(
                dialog: "Unable to add food to your cart."
            )
        }
    }
}
