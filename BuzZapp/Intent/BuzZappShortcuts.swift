import SwiftUI
import Foundation
import AppIntents

struct BuzZappShortcuts: AppShortcutsProvider {
    
    static var appShortcuts: [AppShortcut] {
        
        AppShortcut(
            intent: OpenBuzZappIntent(),
            phrases: [
                "Open \(.applicationName)"
            ],
            shortTitle: "Open BuzZapp",
            systemImageName: "fork.knife"
        )
        
        AppShortcut(
            intent: ShowCartIntent(),
            phrases: [
                "Show my cart in \(.applicationName)",
                "What's in my cart in \(.applicationName)"
            ],
            shortTitle: "Show My Cart",
            systemImageName: "cart"
        )
    }
}
