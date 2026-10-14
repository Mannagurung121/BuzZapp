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
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
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
                .foregroundStyle(.primary)

            Text(user?.location ?? "India")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
        .padding(.bottom, 8)
    }

    // MARK: - Account

    private var accountSection: some View {

        VStack(alignment: .leading, spacing: 0) {

            Text("Account")
                .font(.headline)
                .foregroundStyle(.primary)
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

            Divider()

            NavigationLink {
                OrderHistoryView()
            } label: {
                profileRow(
                    icon: "clock.arrow.circlepath",
                    title: "Order History"
                )
            }
            .buttonStyle(.plain)

            Divider()

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
        .background(
            Color(uiColor: .secondarySystemGroupedBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
    }

    // MARK: - Preferences

    private var preferencesSection: some View {

        VStack(alignment: .leading, spacing: 0) {

            Text("Preferences")
                .font(.headline)
                .foregroundStyle(.primary)
                .padding(.bottom, 8)

            if let user = user {

                HStack {

                    Image(systemName: "fork.knife")
                        .foregroundStyle(.red)
                        .frame(width: 30)

                    Text("Favourite Cuisines")
                        .foregroundStyle(.primary)

                    Spacer()
                }
                .padding(.vertical, 12)

                Text(
                    user.favoriteCuisines.joined(separator: ", ")
                )
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.leading, 42)
                .padding(.bottom, 12)
            }

            Divider()

            profileRow(
                icon: "bell",
                title: "Notifications"
            )
        }
        .padding()
        .background(
            Color(uiColor: .secondarySystemGroupedBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
    }

    // MARK: - Profile Row

    private func profileRow(
        icon: String,
        title: String
    ) -> some View {

        HStack(spacing: 12) {

            Image(systemName: icon)
                .foregroundStyle(.red)
                .frame(width: 30)

            Text(title)
                .foregroundStyle(.primary)

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
                .clipShape(
                    RoundedRectangle(cornerRadius: 14)
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview("Profile - Light Mode") {

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
    .preferredColorScheme(.light)
}

#Preview("Profile - Dark Mode") {

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
    .preferredColorScheme(.dark)
}
