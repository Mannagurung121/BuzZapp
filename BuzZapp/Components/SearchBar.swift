import SwiftUI

struct SearchBar: View {
    
    @State private var searchText = ""
    
    var body: some View {
        HStack(spacing: 12) {
            
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField(
                "Search for food or restaurants",
                text: $searchText
            )
            
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
            
            Divider()
                .frame(height: 24)
            
            Image(systemName: "mic.fill")
                .foregroundStyle(.red)
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(
            color: .black.opacity(0.08),
            radius: 8,
            y: 4
        )
        .padding(.horizontal)
    }
}

#Preview {
    SearchBar()
}
