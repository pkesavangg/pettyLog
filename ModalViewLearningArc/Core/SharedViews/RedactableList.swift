//
//  RedactableList.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 19/04/25.
//
//  A reusable List wrapper that shows placeholder rows while loading.
//  Use this in screens where data is being fetched asynchronously
//  and you want to show a consistent skeleton-style redacted UI.
//
//  ✅ Usage Example:
//
//  RedactableList(isLoading: viewModel.isLoading, placeholderCount: 5) {
//      ForEach(viewModel.items) { item in
//          YourRowView(item: item)
//      }
//  }
//

import SwiftUI

// MARK: - RedactableList

/// A reusable list wrapper that shows placeholder rows while loading.
/// Ideal for skeleton loading UI while data is fetched.
struct RedactableList<Content: View>: View {
    let isLoading: Bool
    let placeholderCount: Int
    let content: () -> Content

    var body: some View {
        List {
            if isLoading {
                ForEach(0..<placeholderCount, id: \.self) { _ in
                    RedactedRowView()
                }
            } else {
                content()
            }
        }
        .redacted(reason: isLoading ? .placeholder : [])
    }
}

// MARK: - RedactedRowView

/// A default placeholder row used by `RedactableList`.
/// You can customize this or make it configurable for different row shapes.
private struct RedactedRowView: View {
    @Environment(\.appTheme) private var theme

    var body: some View {
        HStack {
            Circle()
                .fill(theme.onSurface.opacity(0.3))
                .frame(width: 24, height: 24)

            RoundedRectangle(cornerRadius: 4)
                .fill(theme.onSurface.opacity(0.3))
                .frame(height: 16)
                .padding(.horizontal)

            Spacer()
        }
        .padding(.vertical, .p8)
    }
}

// MARK: - Preview

#Preview {
    RedactedRowView()
}
