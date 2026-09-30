import SwiftUI

struct CategoryView: View {
    
    let category: Category
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            VStack(spacing: 8) {
                
                Text(category.icon)
                    .font(.system(size: 34))
                    .frame(width: 64, height: 64)
                    .background(
                        isSelected
                        ? .red.opacity(0.15)
                        : .red.opacity(0.08)
                    )
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(
                                isSelected ? .red : .clear,
                                lineWidth: 2
                            )
                    }
                
                Text(category.name)
                    .font(.caption)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .foregroundStyle(.primary)
            }
            .frame(width: 75)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CategoryView(
        category: Category(
            id: "1",
            name: "Pizza",
            icon: "🍕"
        ),
        isSelected: true,
        onTap: {}
    )
}
