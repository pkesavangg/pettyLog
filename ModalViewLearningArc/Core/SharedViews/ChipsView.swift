//
//  ChipsView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 24/04/25.
//


import SwiftUI

//struct ChipsView<Tag: Hashable, Content: View>: View {
//    var spacing: CGFloat = 10
//    var animation: Animation = .easeInOut(duration: 0.2)
//    var tags: [Tag]
//    @ViewBuilder var content: (Tag, Bool) -> Content
//    var didChangeSelection: ([Tag]) -> Void = { _ in }
//
//    @State private var selectedTags: [Tag] = []
//
//    var body: some View {
//        CustomChipLayout(spacing: spacing) {
//            ForEach(tags, id: \.self) { tag in
//                content(tag, selectedTags.contains(tag))
//                    .contentShape(Rectangle())
//                    .onTapGesture {
//                        withAnimation(animation) {
//                            if selectedTags.contains(tag) {
//                                selectedTags.removeAll(where: { $0 == tag })
//                            } else {
//                                selectedTags.append(tag)
//                            }
//                            didChangeSelection(selectedTags)
//                        }
//                    }
//            }
//        }
//    }
//}
//
//
//import SwiftUI
//
//fileprivate struct CustomChipLayout: Layout {
//    var spacing: CGFloat
//
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        let width = proposal.width ?? 0
//        return .init(width: width, height: maxHeight(proposal: proposal, subviews: subviews))
//    }
//
//    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//        var origin = bounds.origin
//
//        for subview in subviews {
//            let size = subview.sizeThatFits(proposal)
//
//            if origin.x + size.width > bounds.maxX {
//                origin.x = bounds.minX
//                origin.y += size.height + spacing
//            }
//
//            subview.place(at: origin, proposal: proposal)
//            origin.x += size.width + spacing
//        }
//    }
//
//    private func maxHeight(proposal: ProposedViewSize, subviews: Subviews) -> CGFloat {
//        var origin = CGPoint.zero
//        for subview in subviews {
//            let size = subview.sizeThatFits(proposal)
//
//            if origin.x + size.width > (proposal.width ?? 0) {
//                origin.x = 0
//                origin.y += size.height + spacing
//            }
//
//            origin.x += size.width + spacing
//
//            if subview == subviews.last {
//                origin.y += size.height
//            }
//        }
//        return origin.y
//    }
//}
//
//
//struct ContentView2: View {
//    let allTags = ["Swift", "Kotlin", "Dart", "Rust", "Go", "JavaScriptJavaScriptJavaScript", "TypeScript", "Python"]
//
//    var body: some View {
//        ChipsView(tags: allTags) { tag, isSelected in
//            Text(tag)
//                .padding(.horizontal, 12)
//                .padding(.vertical, 8)
//                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
//                .foregroundColor(isSelected ? .white : .black)
//                .clipShape(Capsule())
//        } didChangeSelection: { selected in
//            print("Selected tags: \(selected)")
//        }
//        .padding()
//    }
//}

import SwiftUI

struct ChipsView<Tag: Identifiable & Hashable, Content: View>: View {
    var spacing: CGFloat = 10
    var tags: [Tag]
    var showAddButton: Bool = true
    @ViewBuilder var chipContent: (Tag, @escaping () -> Void) -> Content
    var onAddTapped: () -> Void = {}
    
    var body: some View {
        CustomChipLayout(spacing: spacing) {
            ForEach(tags) { tag in
                chipContent(tag) {
                    // Remove button action callback
                    onRemoveTapped(tag)
                }
            }
            
            if showAddButton {
                Button(action: onAddTapped) {
                    Text("Add Tag")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.blue)
                        .clipShape(Capsule())
                }
                .contentShape(Rectangle())
            }
        }
    }
    
    var onRemoveTapped: (Tag) -> Void = { _ in }
}

import SwiftUI

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


struct TagItem: Identifiable, Hashable {
    let id: UUID
    var name: String
}

struct ContentView2: View {
    @State private var tags: [TagItem] = [
        TagItem(id: UUID(), name: "Swift"),
        TagItem(id: UUID(), name: "Kotlin"),
        TagItem(id: UUID(), name: "Go"),
        TagItem(id: UUID(), name: "Rust")
    ]

    var body: some View {
        ChipsView(tags: tags,
                  chipContent: { tag, onDelete in
            HStack(spacing: 6) {
                Text(tag.name)
                Image(systemName: "xmark.circle.fill")
                    .onTapGesture {
                        onDelete()
                    }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        },
                  onAddTapped: {
            // Show add tag modal or alert
            let newTag = TagItem(id: UUID(), name: "New \(Int.random(in: 1...100))")
            tags.append(newTag)
        },
                  onRemoveTapped: { tagToRemove in
            tags.removeAll { $0.id == tagToRemove.id }
        })
        .padding()
    }
}



// MARK: - Preview
#Preview {
    ContentView2()
        
}
