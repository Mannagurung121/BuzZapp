import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var cartViewModel: CartViewModel
    
    @State private var selectedCategory = "All"
    @State private var showAddedCart = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                ScrollView {
                    LazyVStack(
                        alignment: .leading,
                        spacing: 24,
                        pinnedViews: [.sectionHeaders]
                    ) {
                        
                        locationHeader
                        
                        SearchBar()
                        
                        // Festival banner only when there is a festival today
                        if let festival = viewModel.festival {
                            festivalBanner(festival)
                        }
                        
                        categoriesSection
                        
                        Section {
                            chatpataFoodCards
                        } header: {
                            chatpataHeader
                        }
                        
                        if selectedCategory != "All" {
                            categoryFoodSection
                        }
                        
                        // Festival recommendations or normal recommendations
                        if let festival = viewModel.festival {
                            festivalPicksSection(festival)
                        } else {
                            topPicksSection
                        }
                        
                        hotMealsSection
                        
                        cheesySection
                        
                        midnightMoodSection
                        
                        mostLovedSection
                    }
                    .padding(.vertical)
                    .padding(.bottom, 70)
                }
                
                if showAddedCart && cartViewModel.totalItems > 0 {
                    addedCartView
                        .transition(
                            .move(edge: .bottom)
                            .combined(with: .opacity)
                        )
                }
            }
            .background(Color(.systemGroupedBackground))
            .task {
                if viewModel.restaurants.isEmpty {
                    await viewModel.loadHomeData()
                }
            }
        }
    }
    
    // MARK: - Location
    
    private var locationHeader: some View {
        HStack(spacing: 10) {
            
            Image(systemName: "location.fill")
                .foregroundStyle(.red)
            
            VStack(alignment: .leading, spacing: 2) {
                
                Text("Delivering to")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("Haldwani")
                    .font(.headline)
            }
            
            Spacer()
            
            Image(systemName: "chevron.down")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }
    
    // MARK: - Festival
    
    private func festivalBanner(_ festival: Festival) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Image(
                LocalImageService.festivalImage(
                    for: festival
                )
            )
            .resizable()
            .scaledToFill()
            .frame(height: 170)
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
            
            HStack {
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(festival.title)
                        .font(.title3.bold())
                    
                    Text(festival.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "sparkles")
                    .font(.title2)
                    .foregroundStyle(.orange)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.orange.opacity(0.10))
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .padding(.horizontal)
    }
    
    // MARK: - Categories
    
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("What are you craving?")
                .font(.title3.bold())
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 12) {
                    
                    ForEach(viewModel.categories) { category in
                        
                        CategoryView(
                            category: category,
                            isSelected: selectedCategory == category.name
                        ) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedCategory = category.name
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    // MARK: - Chatpata
    
    private var chatpataHeader: some View {
        VStack(alignment: .leading, spacing: 3) {
            
            Text("Chatpata Brunch for chatpati ladki 🌶️")
                .font(.headline)
            
            Text("Thoda spicy, thoda naughty.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemGroupedBackground))
    }
    
    private var chatpataFoodCards: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 14) {
                
                ForEach(chatpataFoods.prefix(10)) { food in
                    foodCarouselCard(food)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var chatpataFoods: [FoodItem] {
        
        viewModel.foodItems.filter { food in
            
            let tags = food.foodTags.map {
                $0.lowercased()
            }
            
            return tags.contains("street_food") ||
                   tags.contains("kebab") ||
                   tags.contains("tandoori") ||
                   food.category.lowercased().contains("street")
        }
    }
    
    // MARK: - Category Food
    
    private var categoryFoodSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(selectedCategory)
                .font(.title3.bold())
                .padding(.horizontal)
            
            LazyVStack(spacing: 14) {
                
                ForEach(filteredCategoryFoods.prefix(8)) { food in
                    
                    FoodCard(
                        food: food,
                        quantity: cartViewModel.quantity(for: food),
                        onAdd: {
                            cartViewModel.addItem(food)
                        },
                        onRemove: {
                            cartViewModel.removeItem(food)
                        }
                    )
                }
            }
        }
    }
    
    private var filteredCategoryFoods: [FoodItem] {
        
        guard selectedCategory != "All" else {
            return []
        }
        
        return viewModel.foodItems.filter {
            $0.category.localizedCaseInsensitiveCompare(
                selectedCategory
            ) == .orderedSame
        }
    }
    
    // MARK: - Festival Picks
    
    private func festivalPicksSection(
        _ festival: Festival
    ) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            sectionTitle(
                title: "\(festival.name) Special 🪔",
                subtitle: "Specially recommended for \(festival.name)."
            )
            
            if viewModel.recommendedRestaurants.isEmpty {
                
                ProgressView()
                    .frame(maxWidth: .infinity)
                
            } else {
                
                LazyVStack(spacing: 14) {
                    
                    ForEach(
                        viewModel.recommendedRestaurants
                    ) { restaurant in
                        
                        NavigationLink {
                            
                            RestaurantDetailView(
                                restaurant: restaurant,
                                foodItems: viewModel.foodItems,
                                cartViewModel: cartViewModel
                            )
                            
                        } label: {
                            
                            RestaurantCard(
                                restaurant: restaurant
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
    
    // MARK: - Top Picks
    
    private var topPicksSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            sectionTitle(
                title: "Top Picks for You",
                subtitle: "Recommended based on rating, popularity and distance."
            )
            
            if viewModel.recommendedRestaurants.isEmpty {
                
                ProgressView()
                    .frame(maxWidth: .infinity)
                
            } else {
                
                LazyVStack(spacing: 14) {
                    
                    ForEach(
                        viewModel.recommendedRestaurants
                    ) { restaurant in
                        
                        NavigationLink {
                            
                            RestaurantDetailView(
                                restaurant: restaurant,
                                foodItems: viewModel.foodItems,
                                cartViewModel: cartViewModel
                            )
                            
                        } label: {
                            
                            RestaurantCard(
                                restaurant: restaurant
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
    
    // MARK: - Hot Meals
    
    private var hotMealsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            sectionTitle(
                title: "Hot Meals 🔥",
                subtitle: "Fresh picks that are worth ordering right now."
            )
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 14) {
                    
                    ForEach(hotMeals.prefix(10)) { food in
                        foodCarouselCard(food)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var hotMeals: [FoodItem] {
        
        viewModel.foodItems
            .filter {
                $0.isAvailable
            }
            .sorted {
                
                if $0.rating == $1.rating {
                    return $0.reviewCount > $1.reviewCount
                }
                
                return $0.rating > $1.rating
            }
    }
    
    // MARK: - Cheesy
    
    private var cheesySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            sectionTitle(
                title: "I know you're hot, but this is too cheesy 🧀",
                subtitle: "Cheese pull dekh ke diet khud resign kar de."
            )
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 14) {
                    
                    ForEach(cheesyFoods.prefix(10)) { food in
                        foodCarouselCard(food)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var cheesyFoods: [FoodItem] {
        
        viewModel.foodItems.filter { food in
            
            let tags = food.foodTags.map {
                $0.lowercased()
            }
            
            return tags.contains("pizza") ||
                   food.category.lowercased().contains("pizza")
        }
    }
    
    // MARK: - Midnight
    
    private var midnightMoodSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            sectionTitle(
                title: "Midnight mood, munchies understood 🌙",
                subtitle: "Neend baad mein. Pehle kuch tasty."
            )
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 14) {
                    
                    ForEach(midnightFoods.prefix(10)) { food in
                        foodCarouselCard(food)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var midnightFoods: [FoodItem] {
        
        viewModel.foodItems.filter { food in
            
            let tags = food.foodTags.map {
                $0.lowercased()
            }
            
            return tags.contains("fast_food") ||
                   tags.contains("street_food") ||
                   tags.contains("burger") ||
                   tags.contains("fries") ||
                   tags.contains("cafe")
        }
    }
    
    // MARK: - Most Loved
    
    private var mostLovedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            sectionTitle(
                title: "Most Loved by Foodies ❤️",
                subtitle: "Logon ne order kiya, tum bhi try karo."
            )
            
            LazyVStack(spacing: 12) {
                
                ForEach(mostLovedFoods.prefix(6)) { food in
                    mostLovedCard(food)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var mostLovedFoods: [FoodItem] {
        
        viewModel.foodItems
            .filter {
                $0.isAvailable
            }
            .sorted {
                
                if $0.reviewCount == $1.reviewCount {
                    return $0.rating > $1.rating
                }
                
                return $0.reviewCount > $1.reviewCount
            }
    }
    
    // MARK: - Food Card
    
    private func foodCarouselCard(
        _ food: FoodItem
    ) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Image(
                LocalImageService.foodImage(
                    for: food
                )
            )
            .resizable()
            .scaledToFill()
            .frame(
                width: 170,
                height: 125
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 14)
            )
            
            Text(food.name)
                .font(.subheadline.weight(.semibold))
                .lineLimit(1)
            
            HStack {
                
                Text("₹\(food.price)")
                    .font(.caption.weight(.semibold))
                
                Spacer()
                
                HStack(spacing: 3) {
                    
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
            }
            
            Button {
                addToCart(food)
            } label: {
                
                Text(
                    cartViewModel.quantity(for: food) == 0
                    ? "ADD TO CART"
                    : "\(cartViewModel.quantity(for: food)) ADDED"
                )
                .font(.caption.weight(.semibold))
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity)
                .frame(height: 34)
                .background(.red.opacity(0.08))
                .clipShape(
                    RoundedRectangle(cornerRadius: 9)
                )
            }
            .buttonStyle(.plain)
        }
        .padding(10)
        .frame(width: 190)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
        .shadow(
            color: .black.opacity(0.06),
            radius: 8,
            y: 4
        )
    }
    
    // MARK: - Most Loved Card
    
    private func mostLovedCard(
        _ food: FoodItem
    ) -> some View {
        
        HStack(spacing: 12) {
            
            Image(
                LocalImageService.foodImage(
                    for: food
                )
            )
            .resizable()
            .scaledToFill()
            .frame(
                width: 58,
                height: 58
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(food.name)
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)
                
                Text(food.category)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 4) {
                    
                    Image(systemName: "star.fill")
                        .font(.caption2)
                    
                    Text(
                        String(
                            format: "%.1f",
                            food.rating
                        )
                    )
                    
                    Text("•")
                    
                    Text("\(food.reviewCount) reviews")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(
                alignment: .trailing,
                spacing: 8
            ) {
                
                Text("₹\(food.price)")
                    .font(.subheadline.weight(.semibold))
                
                Button {
                    addToCart(food)
                } label: {
                    
                    Text(
                        cartViewModel.quantity(for: food) == 0
                        ? "ADD"
                        : "\(cartViewModel.quantity(for: food))"
                    )
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .frame(
                        width: 40,
                        height: 30
                    )
                    .background(.red)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(10)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 14)
        )
        .shadow(
            color: .black.opacity(0.05),
            radius: 7,
            y: 3
        )
    }
    
    // MARK: - Section Title
    
    private func sectionTitle(
        title: String,
        subtitle: String
    ) -> some View {
        
        VStack(
            alignment: .leading,
            spacing: 3
        ) {
            
            Text(title)
                .font(.title3.bold())
            
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }
    
    // MARK: - Cart
    
    private func addToCart(
        _ food: FoodItem
    ) {
        
        cartViewModel.addItem(food)
        
        withAnimation(
            .spring(
                response: 0.3,
                dampingFraction: 0.8
            )
        ) {
            showAddedCart = true
        }
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 1.5
        ) {
            
            withAnimation(
                .easeOut(duration: 0.2)
            ) {
                showAddedCart = false
            }
        }
    }
    
    private var addedCartView: some View {
        
        NavigationLink {
            
            CartView(
                cartViewModel: cartViewModel
            )
            
        } label: {
            
            HStack(spacing: 8) {
                
                Image(systemName: "cart.fill")
                    .font(.caption.weight(.semibold))
                
                Text("Added")
                    .font(.caption.weight(.semibold))
                
                Text("•")
                    .foregroundStyle(.secondary)
                
                Text("\(cartViewModel.totalItems)")
                    .font(.caption.weight(.semibold))
                
                Text("View Cart")
                    .font(.caption.weight(.semibold))
            }
            .foregroundStyle(.primary)
            .padding(.horizontal, 13)
            .frame(height: 38)
            .background(.background)
            .clipShape(
                RoundedRectangle(cornerRadius: 11)
            )
            .overlay {
                
                RoundedRectangle(cornerRadius: 11)
                    .stroke(
                        .gray.opacity(0.15),
                        lineWidth: 1
                    )
            }
            .shadow(
                color: .black.opacity(0.15),
                radius: 10,
                y: 4
            )
        }
        .buttonStyle(.plain)
        .padding(.bottom, 12)
    }
}

#Preview {
    HomeView()
        .environmentObject(CartViewModel())
}
