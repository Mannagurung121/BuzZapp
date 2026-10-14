import Foundation
import AppIntents

struct OpenCartIntent: AppIntent {

    static var title: LocalizedStringResource = "Open My Cart"

    static var description = IntentDescription(
        "Opens BuzZapp and shows your cart."
    )

    static let supportedModes: IntentModes = [
        .foreground(.immediate)
    ]

    func perform() async throws -> some IntentResult & ProvidesDialog {

        await MainActor.run {
            NotificationCenter.default.post(
                name: .openCart,
                object: nil
            )
        }

        return .result(
            dialog: "Opening your BuzZapp cart."
        )
    }
}
