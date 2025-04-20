//
//  EntryListRowView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//


import SwiftUI

struct EntryListRowView: View {
    let entry: EntryModel
    let categories: [CategoryModel]
    let tags: [TagModel]
    
    @Environment(\.appTheme) private var theme
    
    private var selectedCategory: CategoryModel? {
        categories.first { $0.id == entry.category }
    }

    private var selectedTags: [TagModel] {
        tags.filter { entry.tags?.contains($0.id) ?? false }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        Text("₹\(String(format: "%.2f", entry.amount))")
                            .font(.headline)
                            .foregroundColor(theme.onSurface)
                            .frame(maxWidth: .infinity, alignment: .leading)

                    }

                    Text(entry.description)
                        .font(.subheadline)
                        .foregroundColor(theme.onSurface.opacity(0.8))
                        .lineLimit(1)
                        .truncationMode(.tail)

                    // Tag Chips
                    if !selectedTags.isEmpty {
                        HStack(spacing: 6) {
                            ForEach(selectedTags, id: \.id) { tag in
                                TagChipView(tag: tag)
                            }
                        }
                    }
                }
                
                
                // Show Category Icon
                VStack(spacing: 15) {
                    if let category = selectedCategory {
                        CategoryIconView(iconName: category.icon)
                    }
                    
                    Image(systemName: entry.imageURLs.isEmpty ? AppAssets.photoWithExclamationMark : AppAssets.photo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(theme.onSurface)
                        .padding(.leading, 4)
                }
            }
        }
        .padding(.all, .p6)
    }

}
