import SwiftUI

struct PersonalDetailsView: View {

    let user: User?

    var body: some View {

        Form {

            // MARK: - Personal Information

            Section("Personal Information") {

                HStack {

                    Text("Name")
                        .foregroundStyle(.primary)

                    Spacer()

                    Text(user?.name ?? "BuzZapp User")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }

                HStack {

                    Text("Location")
                        .foregroundStyle(.primary)

                    Spacer()

                    Text(user?.location ?? "India")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
            }

            // MARK: - Preferences

            Section("Preferences") {

                HStack(alignment: .top) {

                    Text("Favourite Cuisines")
                        .foregroundStyle(.primary)

                    Spacer()

                    Text(
                        user?.favoriteCuisines.joined(separator: ", ")
                        ?? "Not set"
                    )
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
                }

                HStack {

                    Text("Price Range")
                        .foregroundStyle(.primary)

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
        .scrollContentBackground(.automatic)
        .navigationTitle("Personal Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

#Preview("Personal Details - Light Mode") {

    NavigationStack {

        PersonalDetailsView(
            user: User(
                id: "1",
                name: "Manan",
                location: "Haldwani",
                favoriteCuisines: [
                    "North Indian",
                    "Chinese",
                    "Pizza"
                ],
                preferredPriceRange: PriceRange(
                    min: 150,
                    max: 450
                ),
                orderHistoryIDs: []
            )
        )
    }
    .preferredColorScheme(.light)
}

#Preview("Personal Details - Dark Mode") {

    NavigationStack {

        PersonalDetailsView(
            user: User(
                id: "1",
                name: "Manan",
                location: "Haldwani",
                favoriteCuisines: [
                    "North Indian",
                    "Chinese",
                    "Pizza"
                ],
                preferredPriceRange: PriceRange(
                    min: 150,
                    max: 450
                ),
                orderHistoryIDs: []
            )
        )
    }
    .preferredColorScheme(.dark)
}
