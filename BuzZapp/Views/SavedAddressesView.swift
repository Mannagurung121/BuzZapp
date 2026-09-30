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
            }
        }
        .navigationTitle("Saved Addresses")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func addressCard(
        title: String,
        address: String,
        icon: String
    ) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .foregroundStyle(.red)
                .frame(width: 35, height: 35)
                .background(.red.opacity(0.08))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                
                Text(address)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    NavigationStack {
        SavedAddressesView()
    }
}
