import SwiftUI

struct FoodCard: View {

    let food: FoodItem
    let quantity: Int
    let onAdd: () -> Void
    let onRemove: () -> Void

    var body: some View {

        HStack(alignment: .top, spacing: 14) {

            // MARK: - Food Image

            Image(
                LocalImageService.foodImage(for: food)
            )
            .resizable()
            .scaledToFill()
            .frame(width: 110, height: 110)
            .clipped()
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )

            // MARK: - Food Details

            VStack(alignment: .leading, spacing: 7) {

                Text(food.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                Text(food.category)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("₹\(food.price)")
                    .font(.subheadline.bold())
                    .foregroundStyle(.primary)

                // MARK: - Rating

                HStack(spacing: 4) {

                    Image(systemName: "star.fill")
                        .font(.caption2)

                    Text(
                        String(
                            format: "%.1f",
                            food.rating
                        )
                    )
                    .font(.caption)
                }
                .foregroundStyle(.orange)

                // MARK: - Add / Remove Buttons

                if quantity == 0 {

                    Button {
                        onAdd()
                    } label: {

                        Text("ADD")
                            .font(.caption.bold())
                            .foregroundStyle(.red)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 7)
                            .background(.red.opacity(0.08))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 8)
                            )
                            .overlay {

                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        Color.red.opacity(0.7),
                                        lineWidth: 1
                                    )
                            }
                    }
                    .buttonStyle(.plain)

                } else {

                    HStack(spacing: 14) {

                        Button {
                            onRemove()
                        } label: {

                            Image(systemName: "minus")
                                .font(.subheadline.bold())
                                .frame(width: 30, height: 30)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Remove one item")

                        Text("\(quantity)")
                            .font(.subheadline.bold())
                            .foregroundStyle(.primary)
                            .frame(minWidth: 18)

                        Button {
                            onAdd()
                        } label: {

                            Image(systemName: "plus")
                                .font(.subheadline.bold())
                                .frame(width: 30, height: 30)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Add one item")
                    }
                    .foregroundStyle(.red)
                    .background(.red.opacity(0.08))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                }
            }

            Spacer(minLength: 0)
        }
        .padding(12)
        .background(
            Color(uiColor: .secondarySystemBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .shadow(
            color: .black.opacity(0.05),
            radius: 8,
            y: 4
        )
        .padding(.horizontal)
    }
}

// MARK: - Preview

#Preview("Food Card - Light Mode") {

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
    .padding(.vertical)
    .background(
        Color(uiColor: .systemGroupedBackground)
    )
    .preferredColorScheme(.light)
}

#Preview("Food Card - Dark Mode") {

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
    .padding(.vertical)
    .background(
        Color(uiColor: .systemGroupedBackground)
    )
    .preferredColorScheme(.dark)
}
