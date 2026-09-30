import SwiftUI

struct FoodCard: View {
    
    let food: FoodItem
    let quantity: Int
    let onAdd: () -> Void
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 14) {
            
            Image(LocalImageService.foodImage(for: food))
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack(alignment: .leading, spacing: 7) {
                
                Text(food.name)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(food.category)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("₹\(food.price)")
                    .font(.subheadline.bold())
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                    
                    Text(String(format: "%.1f", food.rating))
                        .font(.caption)
                }
                .foregroundStyle(.orange)
                
                Spacer()
                
                if quantity == 0 {
                    Button("ADD") {
                        onAdd()
                    }
                    .font(.caption.bold())
                    .foregroundStyle(.red)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 6)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.red, lineWidth: 1)
                    }
                } else {
                    HStack(spacing: 14) {
                        Button {
                            onRemove()
                        } label: {
                            Image(systemName: "minus")
                        }
                        
                        Text("\(quantity)")
                            .font(.subheadline.bold())
                        
                        Button {
                            onAdd()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .foregroundStyle(.red)
                }
            }
            
            Spacer()
        }
        .padding(12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(
            color: .black.opacity(0.06),
            radius: 8,
            y: 4
        )
        .padding(.horizontal)
    }
}

#Preview {
    FoodCard(
        food: FoodItem(
            id: "1",
            restaurantID: "1",
            name: "Butter Chicken",
            imageName: "",
            price: 299,
            rating: 4.6,
            reviewCount: 450,
            isVeg: false,
            category: "Main Course",
            foodTags: ["chicken", "north-indian"],
            festivalTags: [],
            isAvailable: true
        ),
        quantity: 1,
        onAdd: {},
        onRemove: {}
    )
}
