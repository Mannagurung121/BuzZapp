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

                // MARK: - Category Icon

                Text(category.icon)
                    .font(.system(size: 34))
                    .frame(width: 64, height: 64)
                    .background(
                        isSelected
                        ? Color.red.opacity(0.18)
                        : Color(uiColor: .secondarySystemBackground)
                    )
                    .clipShape(Circle())
                    .overlay {

                        Circle()
                            .stroke(
                                isSelected
                                ? Color.red
                                : Color(uiColor: .separator).opacity(0.25),
                                lineWidth: isSelected ? 2 : 1
                            )
                    }

                // MARK: - Category Name

                Text(category.name)
                    .font(.caption)
                    .fontWeight(
                        isSelected ? .semibold : .medium
                    )
                    .lineLimit(1)
                    .foregroundStyle(
                        isSelected ? Color.red : Color.primary
                    )
            }
            .frame(width: 75)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(category.name)
        .accessibilityAddTraits(
            isSelected ? .isSelected : []
        )
    }
}

// MARK: - Preview

#Preview("Category - Light Mode") {

    CategoryView(
        category: Category(
            id: "1",
            name: "Pizza",
            icon: "🍕"
        ),
        isSelected: true,
        onTap: {}
    )
    .preferredColorScheme(.light)
}

#Preview("Category - Dark Mode") {

    CategoryView(
        category: Category(
            id: "1",
            name: "Pizza",
            icon: "🍕"
        ),
        isSelected: false,
        onTap: {}
    )
    .preferredColorScheme(.dark)
}
