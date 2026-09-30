import Foundation

struct Festival: Codable, Identifiable {
    let id: String
    let name: String
    let region: String
    let title: String
    let subtitle: String
    let foodTags: [String]
    let active: Bool
}
