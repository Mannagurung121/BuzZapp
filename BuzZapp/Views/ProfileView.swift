import SwiftUI

struct ProfileView: View {
    
    let user: User?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    profileHeader
                    
                    accountSection
                    
                    preferencesSection
                    
                    logoutButton
                }
                .padding()
            }
            .navigationTitle("Profile")
        }
    }
    
    // MARK: - Profile Header
    
    private var profileHeader: some View {
        VStack(spacing: 10) {
            
            Image(systemName: "person.circle.fill")
                .font(.system(size: 85))
                .foregroundStyle(.red)
            
            Text(user?.name ?? "BuzZapp User")
                .font(.title2.bold())
            
            Text(user?.location ?? "India")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 20)
    }
    
    // MARK: - Account
    
    private var accountSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Account")
                .font(.headline)
                .padding(.bottom, 8)
            
            NavigationLink {
                PersonalDetailsView(user: user)
            } label: {
                profileRow(
                    icon: "person",
                    title: "Personal Details"
                )
            }
            .buttonStyle(.plain)
            
            NavigationLink {
                OrderHistoryView()
            } label: {
                profileRow(
                    icon: "clock.arrow.circlepath",
                    title: "Order History"
                )
            }
            .buttonStyle(.plain)
            
            NavigationLink {
                SavedAddressesView()
            } label: {
                profileRow(
                    icon: "location",
                    title: "Saved Addresses"
                )
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
    
    // MARK: - Preferences
    
    private var preferencesSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Preferences")
                .font(.headline)
                .padding(.bottom, 8)
            
            if let user = user {
                HStack {
                    Image(systemName: "fork.knife")
                        .foregroundStyle(.red)
                        .frame(width: 30)
                    
                    Text("Favourite Cuisines")
                    
                    Spacer()
                }
                .padding(.vertical, 12)
                
                Text(user.favoriteCuisines.joined(separator: ", "))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.leading, 42)
            }
            
            profileRow(
                icon: "bell",
                title: "Notifications"
            )
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
    
    // MARK: - Profile Row
    
    private func profileRow(
        icon: String,
        title: String
    ) -> some View {
        HStack {
            
            Image(systemName: icon)
                .foregroundStyle(.red)
                .frame(width: 30)
            
            Text(title)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 14)
        .contentShape(Rectangle())
    }
    
    // MARK: - Logout
    
    private var logoutButton: some View {
        Button {
            print("Logout tapped")
        } label: {
            Text("Logout")
                .font(.headline)
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.red.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

#Preview {
    ProfileView(
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
