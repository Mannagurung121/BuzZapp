import SwiftUI
import Foundation
import AppIntents

struct BuzZappShortcuts: AppShortcutsProvider {

    static var appShortcuts: [AppShortcut] {

        // Open BuzZapp
        AppShortcut(
            intent: OpenBuzZappIntent(),
            phrases: [
                "Open \(.applicationName)"
            ],
            shortTitle: "Open BuzZapp",
            systemImageName: "fork.knife"
        )

        // Show Cart
        AppShortcut(
            intent: ShowCartIntent(),
            phrases: [
                "Show my cart in \(.applicationName)",
                "What's in my cart in \(.applicationName)"
            ],
            shortTitle: "Show My Cart",
            systemImageName: "cart"
        )

        // Open Cart
        AppShortcut(
            intent: OpenCartIntent(),
            phrases: [
                "Open my cart in \(.applicationName)"
            ],
            shortTitle: "Open My Cart",
            systemImageName: "cart.fill"
        )

        // Add Food to Cart
        AppShortcut(
            intent: AddFoodToCartIntent(),
            phrases: [
                "Add food to my cart in \(.applicationName)"
            ],
            shortTitle: "Add Food to Cart",
            systemImageName: "cart.badge.plus"
        )
    }
}
