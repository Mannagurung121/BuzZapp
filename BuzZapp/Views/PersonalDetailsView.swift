import SwiftUI

struct PersonalDetailsView: View {
    
    let user: User?
    
    var body: some View {
        Form {
            Section("Personal Information") {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(user?.name ?? "BuzZapp User")
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("Location")
                    Spacer()
                    Text(user?.location ?? "India")
                        .foregroundStyle(.secondary)
                }
            }
            
            Section("Preferences") {
                HStack {
                    Text("Favourite Cuisines")
                    Spacer()
                    Text(user?.favoriteCuisines.joined(separator: ", ") ?? "Not set")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Price Range")
                    Spacer()
                    
                    if let priceRange = user?.preferredPriceRange {
                        Text("₹\(priceRange.min) - ₹\(priceRange.max)")
                            .foregroundStyle(.secondary)
                    } else {
                        Text("Not set")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Personal Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PersonalDetailsView(
            user: User(
                id: "1",
                name: "Manan",
                location: "Haldwani",
                favoriteCuisines: ["North Indian", "Chinese", "Pizza"],
                preferredPriceRange: PriceRange(
                    min: 150,
                    max: 450
                ),
                orderHistoryIDs: []
            )
        )
    }
}
