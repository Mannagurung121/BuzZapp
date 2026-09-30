import SwiftUI

struct RestaurantCard: View {
    
    let restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Image(LocalImageService.restaurantImage(for: restaurant))
                .resizable()
                .scaledToFill()
                .frame(height: 190)
                .clipShape(
                    RoundedRectangle(cornerRadius: 18)
                )
            
            VStack(alignment: .leading, spacing: 6) {
                
                HStack {
                    Text(restaurant.name)
                        .font(.headline)
                    
                    Spacer()
                    
                    HStack(spacing: 3) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                        
                        Text(String(format: "%.1f", restaurant.rating))
                            .font(.caption.bold())
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(.green)
                    .clipShape(Capsule())
                }
                
                Text(
                    restaurant.cuisine.joined(separator: " • ")
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                HStack(spacing: 12) {
                    Label(
                        "\(restaurant.deliveryTime) min",
                        systemImage: "clock"
                    )
                    
                    Text("•")
                    
                    Text("₹\(restaurant.priceForTwo) for two")
                    
                    Spacer()
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 10,
            y: 5
        )
        .padding(.horizontal)
    }
}

#Preview {
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
}
