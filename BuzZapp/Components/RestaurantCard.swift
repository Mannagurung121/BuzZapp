import SwiftUI

struct RestaurantCard: View {

    let restaurant: Restaurant

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            // MARK: - Restaurant Image

            Image(
                LocalImageService.restaurantImage(
                    for: restaurant
                )
            )
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 190)
            .clipped()
            .clipShape(
                RoundedRectangle(cornerRadius: 18)
            )

            // MARK: - Restaurant Details

            VStack(alignment: .leading, spacing: 8) {

                HStack(alignment: .center) {

                    Text(restaurant.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    Spacer(minLength: 8)

                    // Rating Badge

                    HStack(spacing: 4) {

                        Image(systemName: "star.fill")
                            .font(.caption2)

                        Text(
                            String(
                                format: "%.1f",
                                restaurant.rating
                            )
                        )
                        .font(.caption.bold())
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.green)
                    .clipShape(Capsule())
                }

                // Cuisine

                Text(
                    restaurant.cuisine.joined(separator: " • ")
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)

                // Delivery Information

                HStack(spacing: 8) {

                    Label(
                        "\(restaurant.deliveryTime) min",
                        systemImage: "clock"
                    )

                    Text("•")

                    Text(
                        "₹\(restaurant.priceForTwo) for two"
                    )
                    .lineLimit(1)

                    Spacer(minLength: 0)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .background(
            Color(uiColor: .secondarySystemBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .shadow(
            color: .black.opacity(0.06),
            radius: 8,
            y: 4
        )
        .padding(.horizontal)
    }
}

// MARK: - Preview

#Preview("Restaurant Card - Light Mode") {

    RestaurantCard(
        restaurant: Restaurant(
            id: "1",
            name: "BuzZapp Kitchen",
            imageName: "",
            cuisine: [
                "North Indian",
                "Chinese"
            ],
            rating: 4.5,
            reviewCount: 1200,
            distance: 2.4,
            deliveryTime: 30,
            priceForTwo: 400,
            isPureVeg: false,
            popularity: 90,
            latitude: 29.22,
            longitude: 79.52,
            festivalTags: ["baisakhi"],
            menuItemIDs: [],
            available: true
        )
    )
    .padding(.vertical)
    .background(Color(uiColor: .systemGroupedBackground))
    .preferredColorScheme(.light)
}

#Preview("Restaurant Card - Dark Mode") {

    RestaurantCard(
        restaurant: Restaurant(
            id: "1",
            name: "BuzZapp Kitchen",
            imageName: "",
            cuisine: [
                "North Indian",
                "Chinese"
            ],
            rating: 4.5,
            reviewCount: 1200,
            distance: 2.4,
            deliveryTime: 30,
            priceForTwo: 400,
            isPureVeg: false,
            popularity: 90,
            latitude: 29.22,
            longitude: 79.52,
            festivalTags: ["baisakhi"],
            menuItemIDs: [],
            available: true
        )
    )
    .padding(.vertical)
    .background(Color(uiColor: .systemGroupedBackground))
    .preferredColorScheme(.dark)
}
