import SwiftUI

struct SearchView: View {

    let restaurants: [Restaurant]
    let foodItems: [FoodItem]

    @State private var searchText = ""

    // MARK: - Filter Restaurants

    private var filteredRestaurants: [Restaurant] {

        guard !searchText.isEmpty else {
            return []
        }

        return restaurants.filter { restaurant in

            restaurant.name.localizedCaseInsensitiveContains(searchText) ||
            restaurant.cuisine.contains {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    // MARK: - Filter Food Items

    private var filteredFoodItems: [FoodItem] {

        guard !searchText.isEmpty else {
            return []
        }

        return foodItems.filter { food in

            food.name.localizedCaseInsensitiveContains(searchText) ||
            food.category.localizedCaseInsensitiveContains(searchText) ||
            food.foodTags.contains {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    // MARK: - Body

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 20) {

                    searchField

                    if searchText.isEmpty {

                        emptyState

                    } else if filteredRestaurants.isEmpty &&
                                filteredFoodItems.isEmpty {

                        noResults

                    } else {

                        restaurantResults

                        foodResults
                    }
                }
                .padding(.vertical)
            }
            .background(
                Color(uiColor: .systemGroupedBackground)
            )
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    // MARK: - Search Field

    private var searchField: some View {

        HStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField(
                "Search food or restaurants",
                text: $searchText
            )
            .foregroundStyle(.primary)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()

            if !searchText.isEmpty {

                Button {

                    searchText = ""

                } label: {

                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Clear search")
            }
        }
        .padding()
        .background(
            Color(uiColor: .secondarySystemBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
        .overlay {

            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    Color(uiColor: .separator).opacity(0.2),
                    lineWidth: 1
                )
        }
        .shadow(
            color: .black.opacity(0.05),
            radius: 8,
            y: 4
        )
        .padding(.horizontal)
    }

    // MARK: - Restaurant Results

    private var restaurantResults: some View {

        VStack(alignment: .leading, spacing: 12) {

            if !filteredRestaurants.isEmpty {

                Text("Restaurants")
                    .font(.title3.bold())
                    .foregroundStyle(.primary)
                    .padding(.horizontal)

                ForEach(filteredRestaurants) { restaurant in

                    RestaurantCard(
                        restaurant: restaurant
                    )
                }
            }
        }
    }

    // MARK: - Food Results

    private var foodResults: some View {

        VStack(alignment: .leading, spacing: 12) {

            if !filteredFoodItems.isEmpty {

                Text("Food")
                    .font(.title3.bold())
                    .foregroundStyle(.primary)
                    .padding(.horizontal)

                ForEach(filteredFoodItems) { food in

                    FoodCard(
                        food: food,
                        quantity: 0,
                        onAdd: {},
                        onRemove: {}
                    )
                }
            }
        }
    }

    // MARK: - Empty State

    private var emptyState: some View {

        VStack(spacing: 12) {

            Image(systemName: "fork.knife.circle")
                .font(.system(size: 55))
                .foregroundStyle(.red)

            Text("Find something delicious 🍕")
                .font(.title3.bold())
                .foregroundStyle(.primary)

            Text(
                "Search for restaurants or your favourite food"
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 100)
        .padding(.horizontal)
    }

    // MARK: - No Results

    private var noResults: some View {

        VStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .font(.system(size: 45))
                .foregroundStyle(.secondary)

            Text("No results found")
                .font(.title3.bold())
                .foregroundStyle(.primary)

            Text(
                "Try searching for another food or restaurant."
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 80)
        .padding(.horizontal)
    }
}

// MARK: - Preview

#Preview("Search - Light Mode") {

    SearchView(
        restaurants: [],
        foodItems: []
    )
    .preferredColorScheme(.light)
}

#Preview("Search - Dark Mode") {

    SearchView(
        restaurants: [],
        foodItems: []
    )
    .preferredColorScheme(.dark)
}
