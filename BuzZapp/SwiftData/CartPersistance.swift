import Foundation
import SwiftData

enum CartPersistence {

    static let container: ModelContainer = {
        do {
            return try ModelContainer(
                for: CartItemModel.self
            )
        } catch {
            fatalError("Failed to create SwiftData container: \(error)")
        }
    }()
}
