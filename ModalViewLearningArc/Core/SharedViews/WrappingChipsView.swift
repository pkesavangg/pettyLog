//
//  WrappingChipsView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 24/04/25.
//


import SwiftUI

struct WrappingChipsView<TagModel: Identifiable & Hashable, Content: View>: View {
    @Environment(\.appTheme) private var theme
    var spacing: CGFloat = 10
    var tags: [TagModel]
    var showAddButton: Bool = true
    @ViewBuilder var chipContent: (TagModel) -> Content
    var onAddTapped: () -> Void = {}
    
    var body: some View {
        CustomChipLayout(spacing: spacing) {
            ForEach(tags) { tag in
                chipContent(tag)
            }
            
            if showAddButton {
                Button(action: onAddTapped) {
                    Text("Add Tag")
                        .pillStyle()
                }
            }
        }
    }
}

fileprivate struct CustomChipLayout: Layout {
    var spacing: CGFloat

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 0
        return .init(width: width, height: maxHeight(proposal: proposal, subviews: subviews))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        for subview in subviews {
            let size = subview.sizeThatFits(proposal)

            if origin.x + size.width > bounds.maxX {
                origin.x = bounds.minX
                origin.y += size.height + spacing
            }

            subview.place(at: origin, proposal: proposal)
            origin.x += size.width + spacing
        }
    }

    private func maxHeight(proposal: ProposedViewSize, subviews: Subviews) -> CGFloat {
        var origin = CGPoint.zero
        for subview in subviews {
            let size = subview.sizeThatFits(proposal)
            if origin.x + size.width > (proposal.width ?? 0) {
                origin.x = 0
                origin.y += size.height + spacing
            }
            origin.x += size.width + spacing
            if subview == subviews.last {
                origin.y += size.height
            }
        }
        return origin.y
    }
}

// MARK: - Preview

#Preview {
    WrappingChipsView(
        spacing: 10,
        tags: sampleTags,
        showAddButton: true
    ) { tag in
        Text(tag.name)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(tag.displayColor.opacity(0.2))
            .foregroundColor(tag.displayColor)
            .clipShape(Capsule())
    } onAddTapped: {
        print("Add tag tapped")
    }
    .padding()
}

// Sample TagModel Data for Preview
private let sampleTags: [TagModel] = [
    TagModel(id: "1", name: "Food", color: "#FF5733", dateCreated: "2025-04-25", isDefault: true),
    TagModel(id: "2", name: "Travel", color: "#3498DB", dateCreated: "2025-04-25", isDefault: false),
    TagModel(id: "3", name: "Shopping", color: "#9B59B6", dateCreated: "2025-04-25", isDefault: false),
    TagModel(id: "4", name: "Health", color: "#2ECC71", dateCreated: "2025-04-25", isDefault: false),
    TagModel(id: "5", name: "Entertainment", color: "#F1C40F", dateCreated: "2025-04-25", isDefault: false),
    TagModel(id: "1", name: "Food", color: "#FF5733", dateCreated: "2025-04-25", isDefault: true),
    TagModel(id: "2", name: "Travel", color: "#3498DB", dateCreated: "2025-04-25", isDefault: false),
    TagModel(id: "3", name: "Shopping", color: "#9B59B6", dateCreated: "2025-04-25", isDefault: false),
    TagModel(id: "4", name: "Health", color: "#2ECC71", dateCreated: "2025-04-25", isDefault: false),
    TagModel(id: "5", name: "Entertainment", color: "#F1C40F", dateCreated: "2025-04-25", isDefault: false)
]
