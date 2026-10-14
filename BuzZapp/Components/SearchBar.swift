import SwiftUI

struct SearchBar: View {

    @State private var searchText = ""

    var body: some View {

        HStack(spacing: 12) {

            // MARK: - Search Icon

            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            // MARK: - Search Input

            TextField(
                "Search for food or restaurants",
                text: $searchText
            )
            .foregroundStyle(.primary)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .submitLabel(.search)

            // MARK: - Clear Button

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

            // MARK: - Divider

            Divider()
                .frame(height: 24)

            // MARK: - Microphone Icon

            Image(systemName: "mic.fill")
                .foregroundStyle(.red)
                .accessibilityLabel("Voice search")
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
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
}

// MARK: - Preview

#Preview("Search Bar - Light Mode") {

    SearchBar()
        .padding(.vertical)
        .background(Color(uiColor: .systemGroupedBackground))
        .preferredColorScheme(.light)
}

#Preview("Search Bar - Dark Mode") {

    SearchBar()
        .padding(.vertical)
        .background(Color(uiColor: .systemGroupedBackground))
        .preferredColorScheme(.dark)
}
