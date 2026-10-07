

import Foundation
import AppIntents

struct OpenBuzZappIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Open BuzZapp"
    static var openAppWhenRun: Bool = true
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
