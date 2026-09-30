import SwiftUI

struct SearchView: View {
    
    let restaurants: [Restaurant]
    let foodItems: [FoodItem]
    
    @State private var searchText = ""
    
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
            .navigationTitle("Search")
        }
    }
    
    private var searchField: some View {
        HStack(spacing: 12) {
            
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField(
                "Search food or restaurants",
                text: $searchText
            )
            .textInputAutocapitalization(.never)
            
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 8,
            y: 4
        )
        .padding(.horizontal)
    }
    
    private var restaurantResults: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            if !filteredRestaurants.isEmpty {
                Text("Restaurants")
                    .font(.title3.bold())
                    .padding(.horizontal)
                
                ForEach(filteredRestaurants) { restaurant in
                    RestaurantCard(
                        restaurant: restaurant
                    )
                }
            }
        }
    }
    
    private var foodResults: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            if !filteredFoodItems.isEmpty {
                Text("Food")
                    .font(.title3.bold())
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
    
    private var emptyState: some View {
        VStack(spacing: 12) {
            
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 55))
                .foregroundStyle(.red)
            
            Text("Find something delicious 🍕")
                .font(.title3.bold())
            
            Text("Search for restaurants or your favourite food")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 100)
        .padding(.horizontal)
    }
    
    private var noResults: some View {
        VStack(spacing: 12) {
            
            Image(systemName: "magnifyingglass")
                .font(.system(size: 45))
                .foregroundStyle(.secondary)
            
            Text("No results found")
                .font(.title3.bold())
            
            Text("Try searching for another food or restaurant.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 80)
        .padding(.horizontal)
    }
}

#Preview {
    SearchView(
        restaurants: [],
        foodItems: []
    )
}
