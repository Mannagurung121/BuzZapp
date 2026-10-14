import SwiftUI

struct SavedAddressesView: View {

    var body: some View {

        List {

            Section {

                addressCard(
                    title: "Home",
                    address: "Haldwani, Uttarakhand",
                    icon: "house.fill"
                )

                addressCard(
                    title: "Work",
                    address: "Add your work address",
                    icon: "building.2.fill"
                )
            } header: {

                Text("Your Addresses")
            }
        }
        .scrollContentBackground(.automatic)
        .navigationTitle("Saved Addresses")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Address Card

    private func addressCard(
        title: String,
        address: String,
        icon: String
    ) -> some View {

        HStack(spacing: 14) {

            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.red)
                .frame(width: 42, height: 42)
                .background(.red.opacity(0.10))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 5) {

                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(address)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )
            }

            Spacer(minLength: 8)

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .listRowBackground(
            Color(uiColor: .secondarySystemGroupedBackground)
        )
    }
}

// MARK: - Preview

#Preview("Saved Addresses - Light Mode") {

    NavigationStack {
        SavedAddressesView()
    }
    .preferredColorScheme(.light)
}

#Preview("Saved Addresses - Dark Mode") {

    NavigationStack {
        SavedAddressesView()
    }
    .preferredColorScheme(.dark)
}
